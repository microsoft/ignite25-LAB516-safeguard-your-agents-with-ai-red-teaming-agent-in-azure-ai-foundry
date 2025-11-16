# Lab 2: Scan Models & Applications

## About This Lab

Explore different red teaming target types including simple callbacks, direct model configurations, complete applications, and custom domain-specific attack prompts. This lab demonstrates the flexibility of AI red teaming across various deployment scenarios.

## Learning Objectives

- ✅ Test different target types: callbacks, model configurations, and applications
- ✅ Scan Azure OpenAI models directly without an application layer
- ✅ Create and use custom attack prompts for domain-specific testing

## Instructions

!!! lab "2-scan-model.ipynb"
    
    1. **Open Notebook**: Navigate to `labs/2-scan-model/` and open `2-scan-model.ipynb`
    2. **Select Kernel**: Choose the Python kernel for your environment
    3. **Clear All Outputs**: Clear any existing outputs from previous runs
    4. **Run All**: Execute all cells sequentially
    5. **Explore Outputs**: Review the results in each cell as the scans progress

---

## What You'll Do

**This notebook contains four progressive exercises:**

1. **Lab 2A - Basic Callback**: <br/> Test a simple fixed-response callback function (baseline verification, ASR = 0%)
2. **Lab 2B - Model Configuration**:  <br/> Scan an Azure OpenAI model deployment directly using model config dictionaries
3. **Lab 2C - Application Target**:  <br/> Evaluate a complete application with OpenAI Chat Protocol format
4. **Lab 2D - Custom Prompts**:  <br/> Run scans with domain-specific custom attack prompts from JSON files

Run each section sequentially and compare the Attack Success Rates across different target types and attack strategies.

---

## What You'll Learn

- Red team scans support callbacks, models, and application targets.
- Model configurations test Azure OpenAI deployments directly.
- Applications use OpenAI Chat Protocol with structured messages.
- Custom attack prompts enable industry-specific risk testing.
- Simple callbacks validate scan setup before complex testing.

---

## Ask Copilot

!!! prompt "ASK COPILOT: About Target Types"

    ```title="" linenums="0"
    What are the different target types supported by the AI Red Teaming Agent? Explain the difference between simple callbacks, model configurations, and complex application callbacks.
    ```

Try coming up with prompts on your own about:

1. Model configurations and how to test Azure OpenAI models directly
1. OpenAI Chat Protocol format and message structure
1. Custom attack prompts for domain-specific testing
1. Comparing ASR results across different target types
