# Hands-on Labs

The AI Red Teaming Agent Labs are organized into two tracks, to suit time constraints:

- Core labs cover the core concepts in the 60-minute session provided.
- More labs provide advanced exercises that you can do at your own pace at home.

## 1. Core Labs 

In this section, we'll focus on these core labs:

| Lab | Scan | Duration | Level | Objective |
|-----|-------|----------|------------|----------------|
| [Lab 1](01-scan-agent.md) | **Azure AI Agent (callback)** | 15 min | 🟢 100 | Understand API & workflow |
| [Lab 2](02-scan-model.md) | **Models & App Targets** | 25 min | 🟡 200 | Explore targets, risks, attacks |
| [Lab 3](03-scan-cloud.md) | **In Cloud** | 10 min | 🟡 200 | Learn to scale scans |


!!! tip "Want Advanced Labs (300-400 level)?"
    Check out the [More Labs](../more-labs/index.md) section to see how to apply these concepts to real-world scenarios and learn advanced attack strategies or analysis techniques.

---

## 2. Configure Copilot

AI technologies are evolving fast - and as learners, we need to actively build our intuition by asking questions and adopting a curiosity-driven mindset. GitHub Copilot can help. 

!!! quote ""

    **Using GitHub Copilot is optional. Complete these steps only if you want to explore AI assisted learning.**

1. Open `.vscode/mcp.json` - verify Docs MCP server is running (else start it)
1. Click the Copilot icon at the top of the Codespaces window - select "Open Chat"
1. Log into GitHub if needed - wait for Copilot chat window to become active
1. Switch to "Agent" mode - verify that a default model has been selected

You are now ready to "Ask Copilot" for help.

## 3. Ask Copilot

Throughout the guide, we've set up "Ask Copilot" sections with suggested prompts you can try, to explore relevant concepts or dive deeper into a specific topic. Here are some examples:

!!! prompt "Understanding Key Metrics"

    What is Attack Success Rate (ASR) in AI red teaming? How is it calculated and what does a 15% ASR mean for my AI system's safety?

!!! prompt "Risk Categories"

    What are the four risk categories (Violence, Sexual, Hate/Unfairness, Self-Harm) used in AI red teaming? Provide examples of attack prompts for each category.

!!! prompt "Attack Complexity"

    Explain the different attack complexity levels (Easy, Moderate, Difficult). What makes Base64 encoding "easy" while composition attacks are "difficult"?

!!! prompt "Attack Strategies"

    How do attack strategies like Base64, Flip, ROT13, Leetspeak, and Jailbreak work? Show me examples of each strategy.

!!! prompt "Target Types"

    What are the different target types supported by the AI Red Teaming Agent? When should I use simple callbacks vs model configs vs application callbacks?

!!! prompt "Local vs Cloud Scanning"

    What's the difference between local and cloud-based red teaming? What are the tradeoffs and when should I use each approach?

!!! prompt "Interpreting Results"

    How do I interpret AI Red Teaming Agent scan reports? What should I look for in the results and what actions should I take based on ASR scores?

**To Try A Prompt**

- Copy a prompt into the GitHub Copilot chat window
- Read the response - then ask clarifying questions
- Alternatively - ask your own questions on the topic

!!! tip "Say 'give me a Microsoft Docs reference' to ground responses better"

---

## 4. Additional Resources

- [AI Red Teaming Agent Documentation](https://learn.microsoft.com/azure/ai-foundry/concepts/ai-red-teaming-agent)
- [Azure AI Evaluation SDK](https://learn.microsoft.com/azure/ai-foundry/how-to/develop/evaluate-sdk)
- [Responsible AI Principles](https://www.microsoft.com/ai/responsible-ai)
- [Azure AI Foundry Portal](https://ai.azure.com)

---