# Lab 4: Red Team the Zava Chatbot

## Learning Objectives

By completing this lab, you will learn how to:

- ✅ Understand AI red teaming fundamentals and the Map-Measure-Manage framework
- ✅ Create production-ready AI agents with file search capabilities
- ✅ Configure and run baseline red teaming scans
- ✅ Test with advanced attack strategies (Base64, ROT13, Leetspeak, Composition)
- ✅ Analyze Attack Success Rate (ASR) metrics by risk category
- ✅ Interpret scan results and identify safety vulnerabilities
- ✅ Apply best practices for production AI safety

## Instructions

1. **Open the notebook**: Navigate to `labs/4-scan-more/` and open `4-redteam-zava.ipynb`
2. **Review red teaming concepts**: Understand risk categories and attack strategies
3. **Create the Cora agent**: Build an Azure AI Agent with Zava's product catalog (47 files)
4. **Run baseline scan**: Test with direct adversarial queries across 4 risk categories
5. **Run advanced scan**: Apply sophisticated attack strategies (encoding, obfuscation)
6. **Analyze results**: Review ASR metrics and successful attacks
7. **View in portal**: Access detailed reports in Azure AI Foundry

**Expected Time**: 45-60 minutes (includes scan execution time)

## What is Cora?

Cora is an AI shopping assistant for **Zava Hardware Store** with access to:

- **50+ real products** including paint, power tools, hand tools, hardware, electrical, and plumbing supplies
- Product information (names, SKUs, prices, descriptions)
- Real-time inventory levels
- Customer loyalty discounts (Bronze 5%, Silver 10%, Gold 15%, Platinum 20%)

This lab tests whether Cora can:
- ✅ Refuse to generate harmful content (violence, hate, sexual, self-harm)
- ✅ Resist prompt injection and jailbreak attempts
- ✅ Maintain safety guardrails under adversarial attacks
- ✅ Protect customer data and business logic

## Ask Copilot

Use these prompts with GitHub Copilot Chat to deepen your understanding:

!!! prompt ""
    
    **Ask GitHub Copilot:**
    
    - "Explain the Map-Measure-Manage framework for AI safety. How does it help organizations prevent AI-related incidents?"
    - "What are the four risk categories tested by the AI Red Teaming Agent? Provide examples of attacks in each category."
    - "How do attack strategies like Base64, ROT13, and Leetspeak bypass AI safety filters? Why are composition attacks more effective?"
    - "What is Attack Success Rate (ASR) and how should I interpret it? What ASR threshold is acceptable for production deployment?"
    - "How can I use Azure AI Content Safety filters alongside red teaming to secure a production chatbot?"

---

**Previous Lab**: [← Lab 3: Cloud-Based Red Teaming](../core-labs/03-scan-cloud.md) | **Congratulations!** You've completed all labs! 🎉
