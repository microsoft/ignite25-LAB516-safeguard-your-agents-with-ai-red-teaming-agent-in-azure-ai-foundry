# Hands-on Labs

The AI Red Teaming Agent Labs are organized into two tracks, to suit time constraints:

- **CORE LABS** - cover the core concepts in the 60-minute session provided.
- **MORE LABS** - provide additional labs you can do at home, to upskill further.

!!! task "Let's focus on completing the Core Labs - this gives you a sense for time required for each"

| Lab | Scan | Duration | Level | Objective |
|-----|-------|----------|------------|----------------|
| [Lab 1](01-scan-agent.md) | **Azure AI Agent (callback)** | 15 min | 🟢 100 | Understand API & workflow |
| [Lab 2](02-scan-model.md) | **Models & App Targets** | 25 min | 🟡 200 | Explore targets, risks, attacks |
| [Lab 3](03-scan-cloud.md) | **In Cloud** | 10 min | 🟡 200 | Learn to scale scans |

---

## 2. Test GitHub Copilot 

These technologies and tools evolve quickly. As learners, we need to actively build our intuition by asking questions and cultivating our curiosity. This is where GitHub Copilot can help. In every lab instructions page, we provide sample prompts you can use as a "conversation starter". 

**This is completely optional** - please be mindful of the time to complete each lab!

!!! task "Let's do a quick test to see if GitHub Copilot works for you - this section is optional!"

    1. Open `.vscode/mcp.json` - verify Docs MCP server is running (else start it)
    1. Click the Copilot icon at the top of the Codespaces window - select "Open Chat"
    1. Log into GitHub if needed - wait for Copilot chat window to become active
    1. Leave it in **Ask** mode for now - verify that a default model has been selected

!!! success "You are now ready to "Ask Copilot" for help."

---

## 3. Ask Copilot

Look for "Ask Copilot" prompt admonitions like this throughout the course. 

!!! prompt "ASK COPILOT"

    ```title="" linenums="0"
    What is AI Red Teaming? Explain briefly in 1-3 bullet points.
    ```

**To Try A Prompt**

1. Hover over the code block in the prompt - click the copy icon
1. Move to the copilot chat window - paste the prompt & enter
1. You will see something like this - your exact response may differ

!!! quote ""

    Used 4 references 
    ...

    AI Red Teaming is a proactive security testing approach for AI systems:

    1. Adversarial Testing: Systematically attempting to find vulnerabilities, weaknesses, and harmful behaviors in AI models by simulating attacks and malicious inputs (like prompt injections, jailbreaks, or bias exploitation).
    
    1. Safety Evaluation: Testing AI systems against specific risk categories (hate speech, violence, self-harm, sexual content, etc.) to identify failure modes and unintended behaviors before deployment.

    1. Automated & Manual Testing: Using both automated tools (like Azure AI's red teaming agent) and human red teamers to probe models with diverse attack strategies and edge cases, helping developers build more robust and responsible AI systems.


!!! success "You verified you can Ask Copilot for helpful explanations!"

**You are ready to begin the Core Labs!**

---

## 4. Additional Resources

- [AI Red Teaming Agent Documentation](https://learn.microsoft.com/azure/ai-foundry/concepts/ai-red-teaming-agent)
- [Azure AI Evaluation SDK](https://learn.microsoft.com/azure/ai-foundry/how-to/develop/evaluate-sdk)
- [Responsible AI Principles](https://www.microsoft.com/ai/responsible-ai)
- [Microsoft Foundry Portal](https://ai.azure.com)

---