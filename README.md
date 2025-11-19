<p align="center">
<img src="img/Banner-ignite-25.png" alt="decorative banner" width="1200"/>
</p>

# [Microsoft Ignite 2025](https://ignite.microsoft.com)

## 🔥LAB516: Safeguard your agents with AI Red Teaming Agent in Microsoft Foundry

[![Microsoft Foundry Discord](https://dcbadge.limes.pink/api/server/nTYy5BXMWG)](https://aka.ms/MicrosoftFoundry-Ignite25)
[![Microsoft Foundry Developer Forum](https://img.shields.io/badge/GitHub-Microsoft_Foundry_Developer_Forum-blue?style=for-the-badge&logo=github&color=adff2f&logoColor=fff)](https://aka.ms/MicrosoftFoundryForum-Ignite25)

### Who Should Take This Lab?

This lab is ideal for:

1. **AI Developers** who want to improve the security posture of their apps
1. **Cloud Architects** evaluating security tools & practices for AI solutions
1. **AI Beginners** who want to learn AI Red Teaming tools & concepts

**Pre-Requisites**: We assume basic familiarity with AI application develoment and the AI Ops lifecycle. The lab uses GitHub Codespaces, VS Code & Python Notebooks - familiarity with these is ideal. You **must** have a GitHub account to get started.


### Session Description
This hands-on workshop will introduce participants to the fundamentals of [automated AI red teaming](https://learn.microsoft.com/en-us/azure/ai-foundry/concepts/ai-red-teaming-agent) of generative AI systems for safety and security risks using Microsoft Foundry. Attendees will learn how to apply automated attack techniques to identify safety issues and security vulnerabilities across multiple risk dimensions before deployment. Participants will engage in hands-on walkthroughs and guided exercises to apply these concepts in realistic development scenarios.

### 🧠 Learning Outcomes

By the end of this session, learners will be able to:

- describe what the AI Red Teaming Agent does and why it matters for AI safety
- identify and test against core risk categories with diverse attack strategies 
- configure and test different target types (callbacks, models & app endpoints)
- run AI Red Teaming Agent scans locally and in the cloud (using Azure AI SDKs)
- analyze scan results & metrics locally and in the cloud (using Microsoft Foundry Portal)
- compare baseline and advanced attack strategies for a real-world scenario

### 💻 Technologies Used

1. [Azure Developer CLI](https://learn.microsoft.com/azure/developer/azure-developer-cli/overview) - for provisioning a basic AI Agent app
1. [Microsoft Foundry Portal](https://learn.microsoft.com/azure/ai-foundry/what-is-azure-ai-foundry) - for project management and viewing scan results
1. [Microsoft Foundry SDK](https://learn.microsoft.com/python/api/overview/azure/ai-projects-readme) - for cloud-based red teaming operations
1. [Azure AI Red Teaming Agent](https://learn.microsoft.com/azure/ai-foundry/concepts/ai-red-teaming-agent) - for adversarial testing of your AI app
1. [Azure AI Evaluation SDK](https://learn.microsoft.com/azure/ai-foundry/how-to/develop/evaluate-sdk) - for local setup & execution of scans
1. [Azure AI Agents](https://learn.microsoft.com/azure/ai-foundry/agents/overview) - for creating intelligent agents with tools and custom functions
1. [Azure OpenAI Service](https://learn.microsoft.com/azure/ai-foundry/openai/overview) - for accessing GPT-4 and other language models
1. [PyRIT](https://github.com/Azure/PyRIT) - Python Risk Identification Tool framework underlying the red teaming agent

### 🚀 Getting Started

This lab is setup for both instructor-led sessions (pre-provisioned Skillable subscription) and self-guided learning (manually provisioned with your own Azure subscription). In both cases, we _recommend_ using the following approach for a quick start.

1. **Create a personal copy** of the repo to make changes.
   - Log into GitHub using your personal account
   - [Fork this repo](https://github.com/microsoft/ignite25-LAB516-safeguard-your-agents-with-ai-red-teaming-agent-in-azure-ai-foundry/fork) to get your personal copy. 
   - Open the fork in a new browser tab.

1. **Launch GitHub Codespaces** to get your development environment
   - Click the blue "Code" button in your fork - select "Codespaces" tab
   - Click the "+" button to create a new codespace - it opens a new tab
   - You will see a VS Code editor in the browser - wait till it loads

1. **Launch Workshop Guide** to get a web-based instruction guide 
   - Open the VS Code terminal in the IDE above - wait till prompt is active
   - Type `mkdocs serve > /dev/null 2>&1 &` - a dialog will pop up in a few seconds
   - Select "Open in browser" option - a web-based guide will open in a new tab
   - Click the **Begin Here** tab in navigation - follow instructions there!

Using the web-based instruction guide has three benefits:

1. **Search effectively** - quickly look up commands or sections on-demand
1. **Copy/Paste quickly** - hover on code regions to see _copy to clipboard_ option
1. **Toggle theme** - setup for light and dark theme modes to suit your preference

_You should now have a browser with three open tabs:_

- [X] GitHub Repository tab - from which you launched codespaces
- [X] GitHub Codespaces tab - which is your development environment
- [X] Workshop Guide tab - which will provide step-by-step walkthroughs

Ready to get to work? Let's go! 🚀




---

### 🌟 Microsoft Learn MCP Server

[![Install in VS Code](https://img.shields.io/badge/VS_Code-Install_Microsoft_Docs_MCP-0098FF?style=flat-square&logo=visualstudiocode&logoColor=white)](https://vscode.dev/redirect/mcp/install?name=microsoft.docs.mcp&config=%7B%22type%22%3A%22http%22%2C%22url%22%3A%22https%3A%2F%2Flearn.microsoft.com%2Fapi%2Fmcp%22%7D)

The Microsoft Learn MCP Server is a remote MCP Server that enables clients like GitHub Copilot and other AI agents to bring trusted and up-to-date information directly from Microsoft's official documentation. Get started by using the one-click button above for VSCode or access the [mcp.json](.vscode/mcp.json) file included in this repo.

For more information, setup instructions for other dev clients, and to post comments and questions, visit our Learn MCP Server GitHub repo at [https://github.com/MicrosoftDocs/MCP](https://github.com/MicrosoftDocs/MCP). Find other MCP Servers to connect your agent to at [https://mcp.azure.com](https://mcp.azure.com).

*Note: When you use the Learn MCP Server, you agree with [Microsoft Learn](https://learn.microsoft.com/en-us/legal/termsofuse) and [Microsoft API Terms](https://learn.microsoft.com/en-us/legal/microsoft-apis/terms-of-use) of Use.*

### 📚 Resources and Next Steps

| Resources          | Links                             | Description        |
|:-------------------|:----------------------------------|:-------------------|
| Ignite 2025 Next Steps | [https://aka.ms/Ignite25-Next-Steps](https://aka.ms/Ignite25-Next-Steps?ocid=ignite25_nextsteps_cnl) | Links to all repos for Microsoft Ignite Sessions|
| Microsoft Foundry Community Discord | [![Microsoft Foundry Discord](https://dcbadge.limes.pink/api/server/nTYy5BXMWG)](https://aka.ms/MicrosoftFoundry-Ignite25)| Connect with the Microsoft Foundry Community! |
| Learn at Ignite | [https://aka.ms/LearnAtIgnite](https://aka.ms/LearnAtIgnite?ocid=ignite25_nextsteps_github_cnl) | Continue learning on Microsoft Learn |

## Content Owners

<!-- TODO: Add yourself as a content owner
1. Change the src in the image tag to {your github url}.png
2. Change INSERT NAME HERE to your name
3. Change the github url in the final href to your url. -->

<table>
<tr>
    <td align="center"><a href="http://github.com/minthigpen">
        <img src="https://github.com/minthigpen.png" width="100px;" alt="MINSOO THIGPEN"
"/><br />
        <sub><b> MINSOO THIGPEN
</b></sub></a><br />
            <a href="https://github.com/minthigpen" title="talk">📢</a> 
    </td>
    <td align="center"><a href="http://github.com/nitya">
        <img src="https://github.com/nitya.png" width="100px;" alt="NITYA NARASIMHAN"
"/><br />
        <sub><b>NITYA NARASIMHAN
</b></sub></a><br />
            <a href="https://github.com/nityan" title="talk">📢</a> 
    </td>
    <td align="center"><a href="http://github.com/bethanyjep">
        <img src="https://github.com/bethanyjep.png" width="100px;" alt="BETHANY JEPCHUMBA"
"/><br />
        <sub><b>BETHANY JEPCHUMBA
</b></sub></a><br />
            <a href="https://github.com/bethanyjep" title="talk">📢</a> 
    </td>
</tr></table>


## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit [Contributor License Agreements](https://cla.opensource.microsoft.com).

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft
trademarks or logos is subject to and must follow
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.