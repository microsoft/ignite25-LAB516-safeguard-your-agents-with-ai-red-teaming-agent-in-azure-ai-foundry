# Lab 1: Scan Azure AI Agent

## About This Lab

Learn how to run automated security testing on Azure AI agents using the AI Red Teaming Agent. This lab demonstrates how to simulate adversarial attacks, evaluate agent responses, and measure safety vulnerabilities through Attack Success Rate (ASR) metrics.

## Learning Objectives

- ✅ Connect to Azure AI Foundry and retrieve an existing agent
- ✅ Configure and run automated red team scans with attack strategies
- ✅ Analyze scan results and interpret Attack Success Rate (ASR) metrics

## Instructions

!!! lab "1-scan-agent.ipynb"
    
    1. **Open Notebook**: Navigate to `labs/1-scan-agent/` and open `1-scan-agent.ipynb`
    2. **Select Kernel**: Choose the Python kernel for your environment
    3. **Clear All Outputs**: Clear any existing outputs from previous runs
    4. **Run All**: Execute all cells sequentially
    5. **Explore Outputs**: Review the results in each cell as the scan progresses

**Key steps in the notebook:**

1. Authenticate with Azure using DefaultAzureCredential
2. Retrieve your deployed agent from Azure AI Foundry
3. Create an agent callback function for red team testing
4. Configure the RedTeam instance with risk categories
5. Execute the scan using the Flip attack strategy (3-5 minutes)
6. Review results in local `scan-results/` folder and Azure AI Foundry Portal

## Takeaways

- AI Red Teaming Agent automates adversarial testing across risk categories.
- Attack Success Rate (ASR) quantifies unsafe response frequency.
- Agent callbacks provide a standard interface for testing interactions.
- Scan results are saved locally and logged to Azure AI Foundry Portal.
- Start simple and progressively increase test complexity for coverage.

## Ask Copilot

!!! prompt "Understanding AI Red Teaming"
    
    What is AI red teaming and why is it important for generative AI systems? How does the AI Red Teaming Agent identify safety vulnerabilities?

!!! prompt "Attack Success Rate"
    
    Explain what Attack Success Rate (ASR) means in AI red teaming. How is it calculated, and what does a high or low ASR indicate about system safety?

!!! prompt "Risk Categories"
    
    What are the four supported risk categories (Violence, Sexual, Hate/Unfairness, Self-Harm)? Provide examples of attack prompts for each.

!!! prompt "Attack Strategies"
    
    Explain the different attack strategies like Flip, Base64, Jailbreak, and Leetspeak. How do these help test AI safety?

!!! prompt "Agent Callback Functions"
    
    How does the agent callback function work? Why do we need to poll the run status when testing agents?
