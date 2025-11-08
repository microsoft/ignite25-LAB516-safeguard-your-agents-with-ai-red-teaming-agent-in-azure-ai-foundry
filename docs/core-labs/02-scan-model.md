# Lab 2: Scan Models & Applications

## Learning Objectives

By completing this lab, you will learn how to:

- ✅ Understand different scan target types (callbacks, model configs, applications)
- ✅ Test simple fixed-response callbacks to verify scan setup
- ✅ Scan Azure OpenAI model deployments directly with model configurations
- ✅ Evaluate complete AI applications using complex callback functions
- ✅ Create and use custom attack prompts for domain-specific testing
- ✅ Compare Attack Success Rates across different target types and strategies

!!! lab "Instructions"

    This lab contains **four progressive exercises** in a single notebook:

    1. **Open the notebook**: Navigate to `labs/2-scan-model/` and open `2-scan-model.ipynb`
    2. **Lab 2A - Basic Callback**: Run a scan on a fixed-response callback (ASR = 0%, baseline test)
    3. **Lab 2B - Model Config**: Test an Azure OpenAI model deployment directly
    4. **Lab 2C - Application Target**: Scan a complete application with chat protocol
    5. **Lab 2D - Custom Prompts**: Use domain-specific custom attack prompts
    6. **Compare results**: Analyze how ASR varies across different targets and strategies

    **Expected Time**: 30-45 minutes

## Ask Copilot

Use these prompts with GitHub Copilot Chat to deepen your understanding:

!!! prompt "**ASK COPILOT**"

    1. What are the different target types supported by the AI Red Teaming Agent? Explain the difference between simple callbacks, model configurations, and complex application callbacks.
    1. How do I test an Azure OpenAI model directly without an application layer? What does a model configuration dictionary need to include?
    1. Explain the OpenAI Chat Protocol format used for complex callbacks. What's the structure of messages arrays and how do system prompts, user messages, and assistant responses work together?
    1. When should I use custom attack prompts instead of auto-generated ones? How can I create domain-specific prompts for my industry or use case?

---

[PREV LAB](01-scan-agent.md){ .md-button } [NEXT LAB](03-scan-cloud.md){ .md-button .md-button--primary }
