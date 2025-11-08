# Lab 3: Cloud-Based Red Teaming

## Learning Objectives

By completing this lab, you will learn how to:

- ✅ Understand the difference between local and cloud-based red teaming
- ✅ Use the Azure AI Projects SDK (v1.1.0b3+) for cloud scans
- ✅ Submit red team scans to run in Azure AI Foundry infrastructure
- ✅ Monitor scan progress and status in the Azure AI Foundry Portal
- ✅ Access comprehensive results and reports from cloud-based scans
- ✅ Decide when to use cloud vs. local scanning for your workflows

!!! lab "Instructions"

    1. **Open the notebook**: Navigate to `labs/3-scan-cloud/` and open `3-scan-cloud.ipynb`
    2. **Verify package version**: Check you have `azure-ai-projects==1.1.0b3` or later installed
    3. **Configure cloud scan**: Set up the RedTeam instance with your Azure AI project
    4. **Submit the scan**: Launch the scan in Azure AI Foundry (runs asynchronously in the cloud)
    5. **Monitor in portal**: Navigate to Azure AI Foundry Portal → Evaluation → AI red teaming
    6. **Analyze results**: Review the comprehensive reports and data visualizations

    **Expected Time**: 25-35 minutes (scan runs in background)

## Ask Copilot

Use these prompts with GitHub Copilot Chat to deepen your understanding:

!!! prompt ""
    
    **Ask GitHub Copilot:**
    
    - "What's the difference between local and cloud-based AI red teaming? When should I use each approach, and what are the tradeoffs in terms of scale, speed, and resource usage?"
    - "Explain the difference between azure-ai-evaluation SDK (used in Labs 1-2) and azure-ai-projects SDK (used in Lab 3). Why do I need version 1.1.0b3 or later for cloud red teaming?"
    - "What features are available in the Azure AI Foundry Portal for viewing red team results? How can I use the portal to share findings with my security team?"
    - "How can cloud-based red teaming help with pre-deployment validation? What's a good workflow for incorporating red team scans into my AI development lifecycle?"

---

[PREV LAB](02-scan-model.md){ .md-button } [NEXT LAB](../more-labs/04-scan-advanced.md){ .md-button .md-button--primary }
