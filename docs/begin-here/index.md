# Workshop Overview

## 1. Select Your Path

_The workshop guide is setup for use both in-venue (for instructor-led sessions) and at home (for self-guided learners). Pick the tab that reflects your learner context. It gets enforced site-wide, ensuring instructions are tailored to suit your context._

=== "INSTRUCTOR LED SESSION"

    Pick this tab if you are in an instructor led session at Microsoft Ignite.

    - **Duration** - Your session is 75 minutes.
    - **Subscription** - You will use the subscription provided by Skillable
    - **Infrastructure** - Has been pre-provisioned for you!

    **✅ You're all set! [Move directly to the next step to validate it!](./00-setup.md)**

=== "SELF-GUIDED SESSION"

    Pick this tab if you are working through this on your own.

    - **Duration** - Complete the lab at your own pace
    - **Subscription** - You will need your own Azure subscription
    - **Infrastructure** - You will provision resources using scripts we provide





## 2. Workshop Objectives

This workshop teaches you how to use the AI Red Teaming Agent in Microsoft Foundry to proactively scan your AI agents and applications for vulnerabilities _before deploying to production_. These scans _simulate adversarial attacks_ across multiple risk categories and attack strategies and generate reports that you can analyze to understand and mitigate these risks.

!!! quote ""

    By the end of this lab you should be able to:

    - [X] Describe risk categories and attack strategies for red teaming
    - [X] Create an AI Red Teaming Agent for desired risk categories
    - [X] Run a red teaming scan - for a target AI agent, model, or callback
    - [X] Run a red teaming scan  - from your local environment, or in the cloud
    - [X] Run a red teaming scan - with built-in or custom attack prompts
    - [X] View attack success rate (ASR) & analyze report for vulnerabilities


## 3. Prerequisites

!!! quote ""
    Note: We provide a laptop with an Azure subscription pre-provisioned for you, for instructor-led sessions.

To complete the lab, you will need:

- A laptop with a modern browser installed - we recommend Microsoft Edge
- An Azure subscription - [sign up here for free](https://aka.ms/free)
- A personal GitHub account - [sign up here for free](https://github.com/signup)
- Familiarity with VS Code, Git and GitHub tooling
- Familiarity with Generative AI concepts & workflows


## 4. Azure Infrastructure

!!! quote ""
    This lab uses a customized version of the [Getting Started With AI Agents](https://github.com/Azure-Samples/get-started-with-ai-agents) template for Microsoft Foundry. 

    - It is pre-provisioned for instructor-led sessions. Participants are all set.
    - We provide scripts for self-guided learners to do this manually. It takes ~15-20 mins.
    
This sets up a basic Microsoft Foundry project with a model deployment and sample AI agent as shown in the architecture diagram below. The template has built-in support for tracing, monitoring, evaluations and red-teaming features - making it a good sandbox for this lab.

 ![Architecture](./../assets/architecture.png)


If provisioning it yourself, review region availability constraints when selecting location. **Our recommendation:** Use Sweden Central, France Central or East US 2
    
- [Content Safety](https://learn.microsoft.com/azure/ai-services/content-safety/overview#region-availability)
- [Azure AI Search](https://learn.microsoft.com/azure/search/search-region-support#americas)
- [Risk and Safety Evaluators](https://learn.microsoft.com/azure/ai-foundry/concepts/evaluation-evaluators/risk-safety-evaluators#azure-ai-foundry-project-configuration-and-region-support)


---

!!! success "NOW READY TO PROCEED TO [LAB 0: ENVIRONMENT SETUP](00-setup.md)!"
