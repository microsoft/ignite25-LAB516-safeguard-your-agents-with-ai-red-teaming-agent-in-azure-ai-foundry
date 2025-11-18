# Lab 1: Scan Azure AI Agent

## About This Lab

Learn how to run automated security testing on Azure AI agents using the AI Red Teaming Agent. This lab demonstrates how to simulate adversarial attacks, evaluate agent responses, and measure safety vulnerabilities through Attack Success Rate (ASR) metrics.

## Learning Objectives

- ✅ Connect to Microsoft Foundry and retrieve an existing agent
- ✅ Configure and run automated red team scans with attack strategies
- ✅ Analyze scan results and interpret Attack Success Rate (ASR) metrics

## Instructions

!!! lab "1-scan-agent.ipynb"
    
    1. **Open Notebook**: Navigate to `labs/1-scan-agent/` and open `1-scan-agent.ipynb`
    2. **Select Kernel**: Choose the Python kernel for your environment
    3. **Clear All Outputs**: Clear any existing outputs from previous runs
    4. **Run All**: Execute all cells sequentially
    5. **Explore Outputs**: Review the results in each cell as the scan progresses

## What You'll Do

1. Authenticate with Azure using DefaultAzureCredential
2. Retrieve your deployed agent from Microsoft Foundry
3. Create an agent callback function for red team testing
4. Configure the RedTeam instance with risk categories
5. Execute the scan using the Flip attack strategy (3-5 minutes)
6. Review results in local `scan-results/` folder and Microsoft Foundry Portal

---

## What You'll Learn

- AI Red Teaming Agent automates adversarial testing across risk categories.
- Attack Success Rate (ASR) quantifies unsafe response frequency.
- Agent callbacks provide a standard interface for testing interactions.
- Scan results are saved locally and logged to Microsoft Foundry Portal.
- Start simple and progressively increase test complexity for coverage.

---

## Ask Copilot

!!! prompt "ASK COPILOT: About Attack Success Rate"

    ```title="" linenums="0"
    Explain what Attack Success Rate (ASR) means in AI red teaming. How is it calculated, and what does a high or low ASR indicate about system safety?
    ```

Try coming up with prompts on your own about:

1. AI Red Teaming and how it works
1. Risk Categories and what they represent
1. Attack Strategies and how they help test AI safery
1. The specific code or implementation features in lab
