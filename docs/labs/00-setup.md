# Lab 0: Environment Setup

**Duration:** 15-20 minutes | **Difficulty:** 🟢 Beginner

## Overview

This lab guides you through setting up your Azure AI Foundry environment and local development tools for the AI Red Teaming workshops.

## Learning Objectives

By the end of this lab, you will:

- ✅ Provision an Azure AI Foundry project with required services
- ✅ Deploy an Azure OpenAI model for red teaming operations
- ✅ Configure environment variables for SDK authentication
- ✅ Install required Python packages
- ✅ Verify your setup is working correctly

## Prerequisites

- **Azure Subscription** with permissions to create resources
- **Azure CLI** installed and authenticated
- **Python 3.10+** installed
- **Git** for cloning the repository

## Lab Instructions

### Step 1: Choose Your Setup Path

=== "Skillable Hosted Environment"

    !!! success "Pre-Configured Environment"
        If you're using a Skillable hosted lab environment:
        
        - Azure resources are **already provisioned**
        - Environment variables are **already configured**
        - Skip to [Step 5: Verify Setup](#step-5-verify-setup)

=== "Self-Guided Setup"

    Follow the steps below to set up your own environment.

### Step 2: Clone the Repository

Clone the workshop repository:

```bash
git clone https://github.com/microsoft/ignite25-LAB516-safeguard-your-agents-with-ai-red-teaming-agent-in-azure-ai-foundry.git
cd ignite25-LAB516-safeguard-your-agents-with-ai-red-teaming-agent-in-azure-ai-foundry
```

!!! prompt ""
    
    **Ask GitHub Copilot:**
    
    - "What's in the infra/ directory?"
    - "Explain the Bicep template structure"
    - "What Azure resources will be created?"

### Step 3: Provision Azure Infrastructure

Navigate to the infrastructure directory and run the setup script:

```bash
cd infra
./1-setup.sh
```

This script will:

1. **Authenticate with Azure** (`az login`)
2. **Create a resource group** in your selected region
3. **Deploy the Bicep template** with AI Foundry resources
4. **Provision required services:**
   - Azure AI Foundry Hub
   - Azure AI Foundry Project
   - Azure OpenAI Service (with model deployment)
   - Azure AI Services (Content Safety)
   - Storage Account
   - Key Vault
   - Application Insights (optional)

!!! warning "Deployment Time"
    Infrastructure provisioning takes approximately **10-15 minutes**. The script will display progress updates.

!!! info "Region Selection"
    Choose a region that supports all required services:
    
    - **Recommended**: France Central, Sweden Central, East US 2
    - See [supported regions](https://learn.microsoft.com/azure/ai-foundry/concepts/evaluation-evaluators/risk-safety-evaluators#azure-ai-foundry-project-configuration-and-region-support)

### Step 4: Configure Environment Variables

After deployment completes, configure your environment:

```bash
# Still in the infra/ directory
./2-setup-env.sh
```

This script:

1. Extracts resource information from your Azure deployment
2. Creates a `.env` file in the project root
3. Populates it with connection strings and credentials

Load the environment variables:

```bash
source ./2-setup-env.sh
```

!!! prompt ""
    
    **Ask GitHub Copilot:**
    
    - "What environment variables are required?"
    - "How does DefaultAzureCredential work?"
    - "Show me how to verify my .env file"

### Step 5: Verify Setup

Verify your Azure resources were created successfully:

```bash
az resource list --resource-group <your-rg-name> --output table
```

Expected output should show approximately **7 resources**:

| Name | Type | Location |
|------|------|----------|
| aihub-xxx | Microsoft.MachineLearningServices/workspaces | Your region |
| aiproject-xxx | Microsoft.MachineLearningServices/workspaces | Your region |
| openai-xxx | Microsoft.CognitiveServices/accounts | Your region |
| aiservices-xxx | Microsoft.CognitiveServices/accounts | Your region |
| storage-xxx | Microsoft.Storage/storageAccounts | Your region |
| keyvault-xxx | Microsoft.KeyVault/vaults | Your region |
| appinsights-xxx | Microsoft.Insights/components | Your region |

!!! task "Verify Environment Variables"
    
    Check your `.env` file contains required values:
    
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

### Step 6: Install Python Packages

Navigate back to the project root and install dependencies:

```bash
cd ..
pip install -r requirements.txt
```

Key packages installed:

- **azure-ai-evaluation** - For local red team scans (Labs 1-2)
- **azure-ai-projects** - For cloud-based scans (Lab 3)
- **azure-identity** - For Azure authentication
- **openai** - For Azure OpenAI integration
- **python-dotenv** - For environment variables

!!! copilot "Ask GitHub Copilot"
    
    Try asking:
    
    - "What's the difference between azure-ai-evaluation and azure-ai-projects?"
    - "Explain the azure-identity authentication flow"
    - "How do I check installed package versions?"

### Step 7: Verify Python Environment

Check your Python installation:

```bash
python --version
```

Expected: Python 3.10 or higher

Verify package installation:

```bash
pip list | grep azure-ai
```

Expected output:

```
azure-ai-evaluation    0.5.0
azure-ai-projects      1.1.0b3
```

### Step 8: Test Azure Authentication

Run a quick test to verify Azure authentication:

```bash
az account show
```

This should display your current Azure subscription details.

!!! success "Authentication Successful"
    If you see your subscription information, authentication is working correctly.

## Verify Notebook Environment

Open the first notebook to verify everything works:

```bash
# Open Jupyter or VS Code
jupyter notebook labs/1-scan-agent/1-scan-agent.ipynb
# OR
code labs/1-scan-agent/1-scan-agent.ipynb
```

Run the first few cells to test:

```python
# Test imports
from azure.ai.evaluation import RedTeam, RiskCategory
from azure.identity import DefaultAzureCredential

print("✅ Imports successful!")
```

## Troubleshooting

??? question "Error: Azure Login Failed"
    
    **Problem:** `az login` command fails
    
    **Solution:**
    
    1. Clear cached credentials: `az account clear`
    2. Try again: `az login`
    3. Select the correct subscription: `az account set --subscription <id>`

??? question "Error: Deployment Failed - Quota Exceeded"
    
    **Problem:** Insufficient quota for Azure OpenAI model
    
    **Solution:**
    
    1. Go to [Azure Portal](https://portal.azure.com)
    2. Navigate to your Azure OpenAI resource
    3. Go to "Quotas" → Request increase
    4. Wait for approval (1-2 business days)

??? question "Error: Region Not Supported"
    
    **Problem:** Selected region doesn't support required services
    
    **Solution:**
    
    1. Delete the resource group: `az group delete --name <rg-name>`
    2. Edit `infra/azuredeploy.parameters.json`
    3. Change `location` to a supported region
    4. Run `./1-setup.sh` again

??? question "Error: Package Import Failed"
    
    **Problem:** `ImportError: No module named 'azure.ai.evaluation'`
    
    **Solution:**
    
    ```bash
    pip install --upgrade azure-ai-evaluation azure-ai-projects
    ```

??? question "Error: Environment Variables Not Set"
    
    **Problem:** `.env` file is empty or missing
    
    **Solution:**
    
    ```bash
    cd infra
    ./2-setup-env.sh
    source ./2-setup-env.sh
    ```

## Cleanup (Optional)

To remove all Azure resources after completing the labs:

```bash
cd infra
./3-teardown.sh
```

!!! warning "Permanent Deletion"
    This will **permanently delete** all resources and data. Only run this when you're completely finished with the labs.

## Next Steps

!!! success "Setup Complete!"
    Your environment is ready for AI red teaming labs!

Now you can:

1. **[Start Lab 1: Scan Azure AI Agent](01-scan-agent.md)** - Run your first red team scan
2. **[Return to Labs Overview](index.md)** - See all available labs
3. **[Join the Community](https://discord.com/invite/ByRwuEEgH4)** - Connect with other learners

## Additional Resources

- [Azure AI Foundry Documentation](https://learn.microsoft.com/azure/ai-foundry/)
- [Azure AI Evaluation SDK Guide](https://learn.microsoft.com/azure/ai-foundry/how-to/develop/evaluate-sdk)
- [Bicep Template Documentation](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [Azure CLI Reference](https://learn.microsoft.com/cli/azure/)

---

[Continue to Lab 1 →](01-scan-agent.md){ .md-button .md-button--primary }
[Back to Labs](index.md){ .md-button }
