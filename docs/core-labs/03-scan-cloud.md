# Lab 3: Cloud-Based Red Teaming

## About This Lab

Scale your security testing by running red team scans in Azure AI Foundry cloud infrastructure. This lab demonstrates how to submit asynchronous cloud-based scans, monitor their progress in the Azure portal, and access comprehensive results with enhanced visualization and reporting capabilities.

## Learning Objectives

- ✅ Configure and submit red team scans to run in Azure AI Foundry cloud infrastructure
- ✅ Monitor scan progress and status through the Azure AI Foundry Portal
- ✅ Access and analyze comprehensive cloud-based scan results and reports

## Instructions

!!! lab "3-scan-cloud.ipynb"
    
    1. **Open Notebook**: Navigate to `labs/3-scan-cloud/` and open `3-scan-cloud.ipynb`
    2. **Select Kernel**: Choose the Python kernel for your environment
    3. **Clear All Outputs**: Clear any existing outputs from previous runs
    4. **Run All**: Execute all cells sequentially
    5. **Explore Outputs**: Review the results in each cell as the scan submits

**Key steps in the notebook:**

1. Verify you have `azure-ai-projects==1.1.0b3` or later installed
2. Import the cloud-based RedTeam class from `azure.ai.projects`
3. Configure the RedTeam instance with your Azure AI project endpoint
4. Submit the scan to Azure AI Foundry (runs asynchronously in the cloud)
5. Navigate to Azure AI Foundry Portal → **Evaluation** → **AI red teaming** tab
6. Monitor scan progress and view results when complete (typically 5-10 minutes)
7. Explore comprehensive reports, visualizations, and data views in the portal

## Takeaways

- Cloud scans run on Azure infrastructure without local resources.
- Scans execute asynchronously and complete in 5-10 minutes.
- Azure portal provides rich visualizations and analysis tools.
- Portal results enable team collaboration and remediation tracking.
- Azure AI Projects SDK v1.1.0b3+ enables cloud scanning.

## Ask Copilot

!!! prompt "Local vs Cloud Scanning"
    
    What's the difference between local and cloud-based AI red teaming? When should I use each approach, and what are the tradeoffs in terms of scale, speed, and resource usage?

!!! prompt "SDK Differences"
    
    Explain the difference between azure-ai-evaluation SDK (used in Labs 1-2) and azure-ai-projects SDK (used in Lab 3). Why do I need version 1.1.0b3 or later for cloud red teaming?

!!! prompt "Portal Features"
    
    What features are available in the Azure AI Foundry Portal for viewing red team results? How can I use the portal to share findings with my security team?

!!! prompt "Development Lifecycle"
    
    How can cloud-based red teaming help with pre-deployment validation? What's a good workflow for incorporating red team scans into my AI development lifecycle?

!!! prompt "Asynchronous Execution"
    
    Why does cloud-based scanning run asynchronously? How do I check scan status and retrieve results programmatically after submission?
