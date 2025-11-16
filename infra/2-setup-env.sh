#!/bin/bash
# setup-env.sh - Simple script to configure .env file for AI Red Teaming labs

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env"
ENV_SAMPLE="$SCRIPT_DIR/.env.sample"

echo ""
echo "================================================"
echo "  Azure AI Red Teaming - Environment Setup"
echo "================================================"
echo ""

# Step 1: Check if .env exists, else copy from .env.sample
if [ -f "$ENV_FILE" ]; then
    echo "✓ Found existing .env file"
else
    echo "Creating .env file from template..."
    cp "$ENV_SAMPLE" "$ENV_FILE"
    echo "✓ Created .env file"
fi
echo ""

# Step 2: Check Azure CLI login
echo "Checking Azure CLI login..."
if ! az account show &> /dev/null; then
    echo "Not logged in. Running az login..."
    az login
fi
echo "✓ Logged into Azure CLI"
echo ""

# Step 3: Use default subscription
echo "Getting default subscription..."
SELECTED_SUB=$(az account show --query "id" -o tsv)
SELECTED_SUB_NAME=$(az account show --query "name" -o tsv)
echo "✓ Using subscription: $SELECTED_SUB_NAME"
echo ""

# Step 4: Find matching resource groups
echo "Searching for resource groups..."
ALL_RGS=($(az group list --query "[].name" -o tsv))

# Find all matching resource groups with priority
PRIORITY_1_RGS=()  # rg-Ignite*
PRIORITY_2_RGS=()  # rg-*Ignite* or rg-*516*

for rg in "${ALL_RGS[@]}"; do
    # Priority 1: Starts with "rg-Ignite" or "rg-ignite" (case-insensitive)
    if [[ "${rg,,}" == rg-ignite* ]]; then
        PRIORITY_1_RGS+=("$rg")
    # Priority 2: Contains "Ignite" or "516" anywhere after "rg-"
    elif [[ "${rg,,}" == rg-*ignite* ]] || [[ "$rg" == *516* ]]; then
        PRIORITY_2_RGS+=("$rg")
    fi
done

# Combine arrays with priority 1 first
MATCHED_RGS=("${PRIORITY_1_RGS[@]}" "${PRIORITY_2_RGS[@]}")

# Step 5: Display matching resource groups and let user pick
if [ ${#MATCHED_RGS[@]} -gt 0 ]; then
    echo ""
    echo "Found matching resource groups:"
    for i in "${!MATCHED_RGS[@]}"; do
        printf "%2d) %s\n" $((i+1)) "${MATCHED_RGS[$i]}"
    done
    echo ""
    read -p "Select resource group number (or press Enter and type a different name): " RG_CHOICE
    
    if [ -z "$RG_CHOICE" ]; then
        # User pressed Enter without selecting
        read -p "Enter resource group name: " SELECTED_RG
    elif [[ "$RG_CHOICE" =~ ^[0-9]+$ ]] && [ "$RG_CHOICE" -ge 1 ] && [ "$RG_CHOICE" -le ${#MATCHED_RGS[@]} ]; then
        # Valid number selected
        SELECTED_RG="${MATCHED_RGS[$((RG_CHOICE-1))]}"
        echo "✓ Selected: $SELECTED_RG"
    else
        # Invalid number, treat as a resource group name
        SELECTED_RG="$RG_CHOICE"
    fi
else
    echo "No matching resource groups found."
    echo ""
    echo "Available Resource Groups:"
    az group list --query "[].name" -o tsv | nl
    echo ""
    read -p "Enter resource group name: " SELECTED_RG
fi

# Verify the resource group exists
if ! az group show --name "$SELECTED_RG" &> /dev/null; then
    echo "❌ Error: Resource group '$SELECTED_RG' not found in subscription '$SELECTED_SUB_NAME'"
    echo ""
    echo "Available Resource Groups:"
    az group list --query "[].name" -o tsv | nl
    echo ""
    exit 1
fi

echo "✓ Found resource group: $SELECTED_RG"
echo ""

# Step 5: Get location from resource group
LOCATION=$(az group show --name "$SELECTED_RG" --query location -o tsv)
echo "✓ Location: $LOCATION"
echo ""

# Step 6: Find Azure AI Foundry Resource (AI Service)
echo "Searching for Azure AI Foundry Resource..."
AI_RESOURCES=($(az cognitiveservices account list \
    --resource-group "$SELECTED_RG" \
    --query "[?kind=='AIServices'].name" \
    -o tsv))

if [ ${#AI_RESOURCES[@]} -eq 0 ]; then
    echo "No AI Foundry Resource found in resource group"
    SELECTED_RESOURCE=""
elif [ ${#AI_RESOURCES[@]} -eq 1 ]; then
    SELECTED_RESOURCE="${AI_RESOURCES[0]}"
    echo "✓ Found AI Foundry Resource: $SELECTED_RESOURCE"
else
    echo ""
    for i in "${!AI_RESOURCES[@]}"; do
        printf "%2d) %s\n" $((i+1)) "${AI_RESOURCES[$i]}"
    done
    echo ""
    read -p "Select AI Foundry Resource (enter number): " RESOURCE_CHOICE
    SELECTED_RESOURCE="${AI_RESOURCES[$((RESOURCE_CHOICE-1))]}"
    echo "✓ Selected: $SELECTED_RESOURCE"
fi
echo ""

# Step 7: Find Azure AI Foundry Project (child of AI Service)
if [ -z "$SELECTED_RESOURCE" ]; then
    echo "Skipping project search - no AI Foundry Resource selected"
    SELECTED_PROJECT=""
else
    echo "Searching for Azure AI Foundry Projects under $SELECTED_RESOURCE..."
    
    # List AI projects as child resources using the correct resource type
    AI_PROJECTS=($(az resource list \
        --resource-group "$SELECTED_RG" \
        --resource-type "Microsoft.CognitiveServices/accounts/projects" \
        --query "[].name" \
        -o tsv))
    
    # Extract just the project name (after the /)
    FILTERED_PROJECTS=()
    for project in "${AI_PROJECTS[@]}"; do
        # Check if this project belongs to the selected resource
        if [[ "$project" == "$SELECTED_RESOURCE/"* ]]; then
            # Extract project name after the /
            project_name="${project#*/}"
            FILTERED_PROJECTS+=("$project_name")
        fi
    done
    
    if [ ${#FILTERED_PROJECTS[@]} -eq 0 ]; then
        echo "No AI Foundry Project found"
        SELECTED_PROJECT=""
        PROJECT_ENDPOINT=""
    elif [ ${#FILTERED_PROJECTS[@]} -eq 1 ]; then
        SELECTED_PROJECT="${FILTERED_PROJECTS[0]}"
        echo "✓ Found AI Foundry Project: $SELECTED_PROJECT"
        
        # Get project endpoint from properties
        PROJECT_ENDPOINT=$(az resource show \
            --resource-group "$SELECTED_RG" \
            --resource-type "Microsoft.CognitiveServices/accounts/projects" \
            --name "$SELECTED_RESOURCE/$SELECTED_PROJECT" \
            --query "properties.endpoints.\"AI Foundry API\"" \
            -o tsv 2>/dev/null)
        
        if [ -z "$PROJECT_ENDPOINT" ] || [ "$PROJECT_ENDPOINT" = "null" ]; then
            # Construct endpoint if not found
            PROJECT_ENDPOINT="https://$SELECTED_RESOURCE.services.ai.azure.com/api/projects/$SELECTED_PROJECT"
        fi
        echo "✓ Project endpoint: $PROJECT_ENDPOINT"
    else
        echo ""
        for i in "${!FILTERED_PROJECTS[@]}"; do
            printf "%2d) %s\n" $((i+1)) "${FILTERED_PROJECTS[$i]}"
        done
        echo ""
        read -p "Select AI Foundry Project (enter number): " PROJECT_CHOICE
        SELECTED_PROJECT="${FILTERED_PROJECTS[$((PROJECT_CHOICE-1))]}"
        echo "✓ Selected: $SELECTED_PROJECT"
        
        # Get project endpoint from properties
        PROJECT_ENDPOINT=$(az resource show \
            --resource-group "$SELECTED_RG" \
            --resource-type "Microsoft.CognitiveServices/accounts/projects" \
            --name "$SELECTED_RESOURCE/$SELECTED_PROJECT" \
            --query "properties.endpoints.\"AI Foundry API\"" \
            -o tsv 2>/dev/null)
        
        if [ -z "$PROJECT_ENDPOINT" ] || [ "$PROJECT_ENDPOINT" = "null" ]; then
            # Construct endpoint if not found
            PROJECT_ENDPOINT="https://$SELECTED_RESOURCE.services.ai.azure.com/api/projects/$SELECTED_PROJECT"
        fi
        echo "✓ Project endpoint: $PROJECT_ENDPOINT"
    fi
fi
echo ""

# Step 8: Find model deployments
if [ -z "$SELECTED_RESOURCE" ]; then
    echo "Skipping model deployment search - no AI Service selected"
    SELECTED_DEPLOYMENT=""
else
    echo "Searching for model deployments in $SELECTED_RESOURCE..."
    
    DEPLOYMENTS=($(az cognitiveservices account deployment list \
        --name "$SELECTED_RESOURCE" \
        --resource-group "$SELECTED_RG" \
        --query "[].name" \
        -o tsv 2>/dev/null))
    
    if [ ${#DEPLOYMENTS[@]} -eq 0 ]; then
        echo "No model deployments found"
        SELECTED_DEPLOYMENT=""
    elif [ ${#DEPLOYMENTS[@]} -eq 1 ]; then
        SELECTED_DEPLOYMENT="${DEPLOYMENTS[0]}"
        echo "✓ Found model deployment: $SELECTED_DEPLOYMENT"
    else
        echo ""
        echo "Available Model Deployments:"
        for i in "${!DEPLOYMENTS[@]}"; do
            printf "%2d) %s\n" $((i+1)) "${DEPLOYMENTS[$i]}"
        done
        echo ""
        read -p "Select model deployment (enter number): " DEPLOY_CHOICE
        SELECTED_DEPLOYMENT="${DEPLOYMENTS[$((DEPLOY_CHOICE-1))]}"
        echo "✓ Selected: $SELECTED_DEPLOYMENT"
    fi
fi
echo ""

# Update .env file
echo "Updating .env file..."

# Set defaults for empty values
SELECTED_DEPLOYMENT="${SELECTED_DEPLOYMENT:-}"
SELECTED_AGENT="RedTeaming-Cora"

# Get Azure OpenAI endpoint and key for Lab 2
if [ -n "$SELECTED_RESOURCE" ]; then
    echo "Retrieving Azure OpenAI endpoint and key for Lab 2..."
    
    # Get the cognitive services endpoint first
    COGNITIVE_ENDPOINT=$(az cognitiveservices account show \
        --name "$SELECTED_RESOURCE" \
        --resource-group "$SELECTED_RG" \
        --query "properties.endpoint" \
        -o tsv 2>/dev/null)
    
    # Convert to OpenAI format: https://<resource-name>.openai.azure.com/
    if [ -n "$COGNITIVE_ENDPOINT" ]; then
        # Extract the resource name from the endpoint or use SELECTED_RESOURCE
        AZURE_OPENAI_ENDPOINT="https://${SELECTED_RESOURCE}.openai.azure.com/"
    else
        AZURE_OPENAI_ENDPOINT=""
    fi
    
    # Get the API key
    AZURE_OPENAI_API_KEY=$(az cognitiveservices account keys list \
        --name "$SELECTED_RESOURCE" \
        --resource-group "$SELECTED_RG" \
        --query "key1" \
        -o tsv 2>/dev/null)
    
    # Construct the target endpoint with deployment name
    if [ -n "$COGNITIVE_ENDPOINT" ] && [ -n "$SELECTED_DEPLOYMENT" ]; then
        # Remove trailing slash from cognitive endpoint if present
        COGNITIVE_ENDPOINT_CLEAN="${COGNITIVE_ENDPOINT%/}"
        # Construct the full target URI
        AZURE_OPENAI_TARGET_ENDPOINT="${COGNITIVE_ENDPOINT_CLEAN}/openai/deployments/${SELECTED_DEPLOYMENT}/chat/completions?api-version=2025-01-01-preview"
    else
        AZURE_OPENAI_TARGET_ENDPOINT=""
    fi
    
    if [ -n "$AZURE_OPENAI_ENDPOINT" ] && [ -n "$AZURE_OPENAI_API_KEY" ]; then
        echo "✓ Retrieved Azure OpenAI credentials"
        if [ -n "$AZURE_OPENAI_TARGET_ENDPOINT" ]; then
            echo "✓ Constructed target endpoint"
        fi
    else
        echo "⚠ Warning: Could not retrieve Azure OpenAI credentials"
        AZURE_OPENAI_ENDPOINT=""
        AZURE_OPENAI_API_KEY=""
        AZURE_OPENAI_TARGET_ENDPOINT=""
    fi
else
    AZURE_OPENAI_ENDPOINT=""
    AZURE_OPENAI_API_KEY=""
    AZURE_OPENAI_TARGET_ENDPOINT=""
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s|^AZURE_SUBSCRIPTION_ID=.*|AZURE_SUBSCRIPTION_ID=$SELECTED_SUB|" "$ENV_FILE"
    sed -i '' "s|^AZURE_RESOURCE_GROUP=.*|AZURE_RESOURCE_GROUP=$SELECTED_RG|" "$ENV_FILE"
    sed -i '' "s|^AZURE_LOCATION=.*|AZURE_LOCATION=$LOCATION|" "$ENV_FILE"
    sed -i '' "s|^AZURE_AI_PROJECT=.*|AZURE_AI_PROJECT=$SELECTED_PROJECT|" "$ENV_FILE"
    sed -i '' "s|^AZURE_AI_PROJECT_ENDPOINT=.*|AZURE_AI_PROJECT_ENDPOINT=$PROJECT_ENDPOINT|" "$ENV_FILE"
    sed -i '' "s|^AZURE_AI_SERVICE=.*|AZURE_AI_SERVICE=$SELECTED_RESOURCE|" "$ENV_FILE"
    sed -i '' "s|^AZURE_AI_DEPLOYMENT_NAME=.*|AZURE_AI_DEPLOYMENT_NAME=$SELECTED_DEPLOYMENT|" "$ENV_FILE"
    sed -i '' "s|^AZURE_AI_AGENT_NAME=.*|AZURE_AI_AGENT_NAME=$SELECTED_AGENT|" "$ENV_FILE"
    # Lab 2 variables
    sed -i '' "s|^AZURE_OPENAI_API_KEY=.*|AZURE_OPENAI_API_KEY=$AZURE_OPENAI_API_KEY|" "$ENV_FILE"
    sed -i '' "s|^AZURE_OPENAI_DEPLOYMENT=.*|AZURE_OPENAI_DEPLOYMENT=$SELECTED_DEPLOYMENT|" "$ENV_FILE"
    sed -i '' "s|^AZURE_OPENAI_ENDPOINT=.*|AZURE_OPENAI_ENDPOINT=$AZURE_OPENAI_ENDPOINT|" "$ENV_FILE"
    sed -i '' "s|^AZURE_OPENAI_TARGET_ENDPOINT=.*|AZURE_OPENAI_TARGET_ENDPOINT=$AZURE_OPENAI_TARGET_ENDPOINT|" "$ENV_FILE"
else
    sed -i "s|^AZURE_SUBSCRIPTION_ID=.*|AZURE_SUBSCRIPTION_ID=$SELECTED_SUB|" "$ENV_FILE"
    sed -i "s|^AZURE_RESOURCE_GROUP=.*|AZURE_RESOURCE_GROUP=$SELECTED_RG|" "$ENV_FILE"
    sed -i "s|^AZURE_LOCATION=.*|AZURE_LOCATION=$LOCATION|" "$ENV_FILE"
    sed -i "s|^AZURE_AI_PROJECT=.*|AZURE_AI_PROJECT=$SELECTED_PROJECT|" "$ENV_FILE"
    sed -i "s|^AZURE_AI_PROJECT_ENDPOINT=.*|AZURE_AI_PROJECT_ENDPOINT=$PROJECT_ENDPOINT|" "$ENV_FILE"
    sed -i "s|^AZURE_AI_SERVICE=.*|AZURE_AI_SERVICE=$SELECTED_RESOURCE|" "$ENV_FILE"
    sed -i "s|^AZURE_AI_DEPLOYMENT_NAME=.*|AZURE_AI_DEPLOYMENT_NAME=$SELECTED_DEPLOYMENT|" "$ENV_FILE"
    sed -i "s|^AZURE_AI_AGENT_NAME=.*|AZURE_AI_AGENT_NAME=$SELECTED_AGENT|" "$ENV_FILE"
    # Lab 2 variables
    sed -i "s|^AZURE_OPENAI_API_KEY=.*|AZURE_OPENAI_API_KEY=$AZURE_OPENAI_API_KEY|" "$ENV_FILE"
    sed -i "s|^AZURE_OPENAI_DEPLOYMENT=.*|AZURE_OPENAI_DEPLOYMENT=$SELECTED_DEPLOYMENT|" "$ENV_FILE"
    sed -i "s|^AZURE_OPENAI_ENDPOINT=.*|AZURE_OPENAI_ENDPOINT=$AZURE_OPENAI_ENDPOINT|" "$ENV_FILE"
    sed -i "s|^AZURE_OPENAI_TARGET_ENDPOINT=.*|AZURE_OPENAI_TARGET_ENDPOINT=$AZURE_OPENAI_TARGET_ENDPOINT|" "$ENV_FILE"
fi

echo "✓ Configuration saved"
echo ""
echo "================================================"
echo "Summary:"
echo "  Subscription: $SELECTED_SUB_NAME"
echo "  Resource Group: $SELECTED_RG"
echo "  Location: $LOCATION"
echo "  AI Service: $SELECTED_RESOURCE"
echo "  AI Project: $SELECTED_PROJECT"
echo "  Project Endpoint: $PROJECT_ENDPOINT"
echo "  Model Deployment: $SELECTED_DEPLOYMENT"
echo ""
echo "Lab 2 - Azure OpenAI Configuration:"
echo "  OpenAI Endpoint: $AZURE_OPENAI_ENDPOINT"
echo "  OpenAI Deployment: $SELECTED_DEPLOYMENT"
echo "  OpenAI Target Endpoint: $AZURE_OPENAI_TARGET_ENDPOINT"
echo "  OpenAI API Key: ${AZURE_OPENAI_API_KEY:0:8}..." # Show only first 8 chars
echo "================================================"
echo ""
