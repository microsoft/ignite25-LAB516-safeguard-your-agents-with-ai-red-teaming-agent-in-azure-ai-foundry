# Environment Setup

This guide will help you set up your Azure AI Foundry environment and local development tools for the AI Red Teaming labs.

## Prerequisites

Before starting these labs, ensure you have:

- **Azure Subscription** - Active Azure subscription with permissions to create resources
- **GitHub Account** (optional) - For running in GitHub Codespaces
- **VS Code** (optional) - For local development
- **Python 3.10+** - Required for running notebooks and SDKs

## Azure Resources Required

The labs require the following Azure resources:

1. **Azure AI Foundry Project** - Central hub for AI development
2. **Azure OpenAI Service** - For deploying LLM models
3. **Azure AI Services** - For safety evaluations
4. **Azure Search** (optional) - For RAG scenarios

!!! info "Supported Regions"
    Choose a region that supports:
    
    - [Content Safety](https://learn.microsoft.com/azure/ai-services/content-safety/overview#region-availability)
    - [Azure AI Search](https://learn.microsoft.com/azure/search/search-region-support#americas)
    - [Risk and Safety Evaluators](https://learn.microsoft.com/azure/ai-foundry/concepts/evaluation-evaluators/risk-safety-evaluators#azure-ai-foundry-project-configuration-and-region-support)
    
    **Recommended regions**: France Central, Sweden Central, East US 2

## Setup Options

Choose your preferred setup method:

=== "Skillable Hosted Environment"

    If you're using a Skillable hosted lab environment:
    
    1. Your Azure resources are **pre-provisioned**
    2. Your environment variables are **pre-configured**
    3. Skip to [Verify Setup](#verify-setup) below
    
    !!! success "Ready to Go!"
        Your Skillable environment is ready. Proceed directly to Lab 1.

=== "Self-Guided Setup"

    If you're running the labs on your own:
    
    ### Step 1: Clone the Repository
    
    ```bash
    git clone https://github.com/microsoft/ignite25-LAB516-safeguard-your-agents-with-ai-red-teaming-agent-in-azure-ai-foundry.git
    cd ignite25-LAB516-safeguard-your-agents-with-ai-red-teaming-agent-in-azure-ai-foundry
    ```
    
    ### Step 2: Provision Azure Resources
    
    Run the automated setup script:
    
    ```bash
    cd infra
    ./1-setup.sh
    ```
    
    This script will:
    
    - Authenticate with Azure (`az login`)
    - Create a resource group
    - Deploy the Bicep template
    - Provision AI Foundry project, OpenAI, and supporting services
    
    !!! warning "Deployment Time"
        Infrastructure provisioning takes approximately **10-15 minutes**.
    
    ### Step 3: Configure Environment Variables
    
    After deployment completes, set up your environment:
    
    ```bash
    # From the infra/ directory
    ./2-setup-env.sh
    ```
    
    This creates a `.env` file with your Azure resource credentials.
    
    ### Step 4: Load Environment Variables
    
    ```bash
    # Load the environment variables
    source ./2-setup-env.sh
    ```

## Verify Setup

Confirm your environment is configured correctly:

!!! task "Verify Azure Resources"
    
    Check that all resources were created:
    
    ```bash
    az resource list --resource-group <your-resource-group-name> --output table
    ```
    
    You should see approximately **7 resources**:
    
    - AI Foundry Hub
    - AI Foundry Project
    - Azure OpenAI Service
    - Azure AI Services (Content Safety)
    - Storage Account
    - Key Vault
    - Application Insights (if created)

!!! task "Verify Environment Variables"
    
    Check that your `.env` file contains:
    
    ```bash
    cat ../.env
    ```
    
    Required variables:
    
    - `PROJECT_CONNECTION_STRING`
    - `AZURE_OPENAI_ENDPOINT`
    - `AZURE_OPENAI_API_KEY`
    - `AZURE_OPENAI_DEPLOYMENT`
    - `AZURE_SUBSCRIPTION_ID`
    - `AZURE_RESOURCE_GROUP`

!!! task "Verify Python Environment"
    
    Check Python version:
    
    ```bash
    python --version  # Should be 3.10 or higher
    ```
    
    Install required packages:
    
    ```bash
    pip install -r requirements.txt
    ```

## Install Required Packages

The labs use several Azure AI SDKs:

```bash
# Install from requirements.txt
pip install -r requirements.txt
```

Key packages include:

- `azure-ai-evaluation` - For local red team scans
- `azure-ai-projects` - For cloud-based scans
- `azure-identity` - For Azure authentication
- `openai` - For Azure OpenAI integration
- `python-dotenv` - For environment variable management

## Authenticate with Azure

!!! copilot "Ask GitHub Copilot"
    
    Try asking Copilot:
    
    - "How do I authenticate with Azure CLI?"
    - "What's the difference between DefaultAzureCredential and AzureCliCredential?"
    - "Show me how to verify my Azure authentication"

Authenticate using Azure CLI:

```bash
az login
```

This opens a browser window for authentication. After successful login, you'll see your subscriptions listed.

Set your default subscription (if needed):

```bash
az account set --subscription "<your-subscription-id>"
```

## Troubleshooting

### Common Issues

??? question "Error: Region doesn't support required services"
    
    **Solution**: Choose a different region from the [recommended list](#azure-resources-required).
    
    Update `infra/azuredeploy.parameters.json` with the new region and redeploy.

??? question "Error: Insufficient quota for model deployment"
    
    **Solution**: Request quota increase in Azure Portal:
    
    1. Navigate to Azure OpenAI resource
    2. Go to "Quotas" section
    3. Request increase for desired model
    4. Wait for approval (can take 1-2 business days)

??? question "Error: .env file not found"
    
    **Solution**: Run the setup script again:
    
    ```bash
    cd infra
    ./2-setup-env.sh
    ```

??? question "Error: Import azure.ai.evaluation failed"
    
    **Solution**: Ensure packages are installed:
    
    ```bash
    pip install --upgrade azure-ai-evaluation azure-ai-projects
    ```

## Next Steps

Once your environment is set up:

1. **[Return to Labs Overview](../labs/)** - See all available labs
2. **[Start Lab 1](../labs/01-scan-agent.md)** - Run your first red team scan
3. **[Join the Community](https://discord.com/invite/ByRwuEEgH4)** - Connect with other learners

## Additional Resources

- [Azure AI Foundry Documentation](https://learn.microsoft.com/azure/ai-foundry/)
- [AI Red Teaming Agent Documentation](https://learn.microsoft.com/azure/ai-foundry/concepts/ai-red-teaming-agent)
- [Azure AI Evaluation SDK](https://learn.microsoft.com/azure/ai-foundry/how-to/develop/evaluate-sdk)
- [Responsible AI Resources](https://www.microsoft.com/ai/responsible-ai)

---

!!! success "Setup Complete!"
    Your environment is ready. Proceed to [Lab 1: Scan Azure AI Agent](../labs/01-scan-agent.md) to begin learning!
