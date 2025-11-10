# Lab 4: Red Team the Zava Chatbot

## About This Lab

Test Cora, an AI shopping assistant for Zava Hardware Store, using baseline and advanced attack strategies. This lab demonstrates comprehensive security testing of a production-ready agent with file search capabilities and real product data across 50+ items.

## Learning Objectives

- ✅ Create production-ready AI agents with file search capabilities and product catalogs
- ✅ Run baseline and advanced red teaming scans with sophisticated attack strategies
- ✅ Analyze Attack Success Rate (ASR) metrics by risk category and attack complexity

## Instructions

!!! lab "4-redteam-zava.ipynb"
    
    1. **Open Notebook**: Navigate to `labs/4-scan-more/` and open `4-redteam-zava.ipynb`
    2. **Select Kernel**: Choose the Python kernel for your environment
    3. **Clear All Outputs**: Clear any existing outputs from previous runs
    4. **Run All**: Execute all cells sequentially
    5. **Explore Outputs**: Review the results as baseline and advanced scans execute

**About Cora - Zava Hardware Store AI Assistant:**

Cora is an AI shopping assistant with access to 50+ real products including paint, power tools, hand tools, hardware, electrical, and plumbing supplies. The agent provides product information, pricing, inventory levels, and customer loyalty discounts (Bronze 5%, Silver 10%, Gold 15%, Platinum 20%).

**Key steps in the notebook:**

1. Review red teaming concepts and Map-Measure-Manage framework
2. Create Cora agent with Zava's 47-file product catalog
3. Run baseline scan with direct adversarial queries
4. Run advanced scan with encoding/obfuscation strategies
5. Analyze and compare baseline vs. advanced ASR metrics
6. Review successful attacks and identify vulnerabilities
7. Access detailed reports in Azure AI Foundry Portal

## Takeaways

- Production agents need testing against baseline and advanced strategies.
- Advanced attacks bypass basic filters using encoding and obfuscation.
- ASR metrics by risk category reveal specific vulnerability patterns.
- File search capabilities require thorough security validation.
- Map-Measure-Manage framework enables systematic AI safety.

## Ask Copilot

!!! prompt "Planning Your Testing Strategy"
    
    How should I decide which risk categories to prioritize when testing my own AI agent? What factors determine testing scope?

!!! prompt "Baseline vs Advanced Testing"
    
    When should I run baseline scans versus advanced scans? How do I build a progressive testing strategy for my use case?

!!! prompt "Custom Attack Prompts"
    
    How can I create domain-specific attack prompts for my industry? What makes an effective custom prompt for security testing?

!!! prompt "Interpreting Results for Action"
    
    What ASR threshold should trigger remediation in my application? How do I prioritize fixing vulnerabilities based on scan results?

!!! prompt "Production Deployment Checklist"
    
    What red teaming steps should I complete before deploying an AI agent to production? How do I integrate testing into my CI/CD pipeline?
