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

# Step 4: Ask for resource group name
read -p "Enter resource group name: " SELECTED_RG

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

# Step 9: Find agents
DEFAULT_AGENT="agent-template-assistant"

if [ -z "$SELECTED_PROJECT" ]; then
    echo "Skipping agent search - no AI Project selected"
    SELECTED_AGENT=""
else
    echo "Searching for agents in project $SELECTED_PROJECT..."
    
    # Try to list agents using the AI Foundry API
    # Note: This requires the project endpoint
    # We'll use az rest to query the agents API
    
    # Construct the full resource name for the project
    FULL_PROJECT_NAME="$SELECTED_RESOURCE/$SELECTED_PROJECT"
    
    # Try to get agents via REST API
    AGENTS=($(az rest \
        --method GET \
        --url "https://management.azure.com/subscriptions/$SELECTED_SUB/resourceGroups/$SELECTED_RG/providers/Microsoft.CognitiveServices/accounts/$SELECTED_RESOURCE/projects/$SELECTED_PROJECT/agents?api-version=2025-04-01-preview" \
        --query "value[].name" \
        -o tsv 2>/dev/null))
    
    if [ ${#AGENTS[@]} -eq 0 ]; then
        echo "No agents found via API"
        read -p "Enter agent name (default: $DEFAULT_AGENT): " SELECTED_AGENT
        SELECTED_AGENT="${SELECTED_AGENT:-$DEFAULT_AGENT}"
        echo "✓ Using: $SELECTED_AGENT"
    elif [ ${#AGENTS[@]} -eq 1 ]; then
        FOUND_AGENT="${AGENTS[0]}"
        echo "✓ Found agent: $FOUND_AGENT"
        read -p "Use this agent or enter a different name (default: $FOUND_AGENT): " SELECTED_AGENT
        SELECTED_AGENT="${SELECTED_AGENT:-$FOUND_AGENT}"
        if [ "$SELECTED_AGENT" != "$FOUND_AGENT" ]; then
            echo "✓ Using: $SELECTED_AGENT"
        fi
    else
        echo ""
        echo "Available Agents:"
        for i in "${!AGENTS[@]}"; do
            printf "%2d) %s\n" $((i+1)) "${AGENTS[$i]}"
        done
        echo ""
        read -p "Select agent (enter number) or press Enter to use default ($DEFAULT_AGENT): " AGENT_CHOICE
        if [ -z "$AGENT_CHOICE" ]; then
            SELECTED_AGENT="$DEFAULT_AGENT"
            echo "✓ Using default: $SELECTED_AGENT"
        else
            SELECTED_AGENT="${AGENTS[$((AGENT_CHOICE-1))]}"
            echo "✓ Selected: $SELECTED_AGENT"
        fi
    fi
fi
echo ""

# Update .env file
echo "Updating .env file..."

# Set defaults for empty values
SELECTED_DEPLOYMENT="${SELECTED_DEPLOYMENT:-}"
SELECTED_AGENT="${SELECTED_AGENT:-}"

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
    
    if [ -n "$AZURE_OPENAI_ENDPOINT" ] && [ -n "$AZURE_OPENAI_API_KEY" ]; then
        echo "✓ Retrieved Azure OpenAI credentials"
    else
        echo "⚠ Warning: Could not retrieve Azure OpenAI credentials"
        AZURE_OPENAI_ENDPOINT=""
        AZURE_OPENAI_API_KEY=""
    fi
else
    AZURE_OPENAI_ENDPOINT=""
    AZURE_OPENAI_API_KEY=""
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
echo "  Agent Name: $SELECTED_AGENT"
echo ""
echo "Lab 2 - Azure OpenAI Configuration:"
echo "  OpenAI Endpoint: $AZURE_OPENAI_ENDPOINT"
echo "  OpenAI Deployment: $SELECTED_DEPLOYMENT"
echo "  OpenAI API Key: ${AZURE_OPENAI_API_KEY:0:8}..." # Show only first 8 chars
echo "================================================"
echo ""
