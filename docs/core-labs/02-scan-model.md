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

**This notebook contains four progressive exercises:**

1. **Lab 2A - Basic Callback**: Test a simple fixed-response callback function (baseline verification, ASR = 0%)
2. **Lab 2B - Model Configuration**: Scan an Azure OpenAI model deployment directly using model config dictionaries
3. **Lab 2C - Application Target**: Evaluate a complete application with OpenAI Chat Protocol format
4. **Lab 2D - Custom Prompts**: Run scans with domain-specific custom attack prompts from JSON files

Run each section sequentially and compare the Attack Success Rates across different target types and attack strategies.

## Takeaways

- Red team scans support callbacks, models, and application targets.
- Model configurations test Azure OpenAI deployments directly.
- Applications use OpenAI Chat Protocol with structured messages.
- Custom attack prompts enable industry-specific risk testing.
- Simple callbacks validate scan setup before complex testing.

## Ask Copilot

!!! prompt "Target Types"
    
    What are the different target types supported by the AI Red Teaming Agent? Explain the difference between simple callbacks, model configurations, and complex application callbacks.

!!! prompt "Model Configurations"
    
    How do I test an Azure OpenAI model directly without an application layer? What parameters does a model configuration dictionary need to include?

!!! prompt "Chat Protocol Format"
    
    Explain the OpenAI Chat Protocol format used for complex callbacks. What's the structure of messages arrays with system prompts, user messages, and assistant responses?

!!! prompt "Custom Attack Prompts"
    
    When should I use custom attack prompts instead of auto-generated ones? How can I create domain-specific prompts for my industry or use case?

!!! prompt "Comparing Results"
    
    How do Attack Success Rates differ between testing a raw model versus a complete application with safety guardrails? What insights can I gain from comparing results?
