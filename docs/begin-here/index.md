# Workshop Overview

## 1. Select Your Path

_The workshop guide is setup for use both in-venue (for instructor-led sessions) and at home (for self-guided learners). Pick the tab that reflects your learner context. It gets enforced site-wide, ensuring instructions are tailored to suit your context._

=== "INSTRUCTOR LED SESSION"

    - [X] **Location** - In a lab session at Microsoft Ignite
    - [X] **Duration** - You have 75 minutes to complete lab
    - [X] **Subscription** - You will be provided a Skillable subscription
    - [X] **Infrastructure** - is pre-provisioned for you

=== "SELF-GUIDED SESSION"

    - [ ] **Location** - Working by yourself, at home
    - [ ] **Duration** - Complete the lab at your own pace
    - [ ] **Subscription** - You will need your own Azure subscription
    - [ ] **Infrastructure** - You will need to provision it manually


## 2. Workshop Objectives

This workshop teaches you how to use the AI Red Teaming Agent in Azure AI Foundry to proactively scan your AI agents and applications for vulnerabilities _before deploying to production_. These scans _simulate adversarial attacks_ across multiple risk categories and attack strategies and generate reports that you can analyze to understand and mitigate these risks.

By the end of this lab you should be able to:

- [X] Describe risk categories and attack strategies for red teaming
- [X] Create an AI Red Teaming Agent for desired risk categories
- [X] Run a red teaming scan - for a target AI agent, model, or callback
- [X] Run a red teaming scan  - from your local environment, or in the cloud
- [X] Run a red teaming scan - with built-in or custom attack prompts
- [X] View attack success rate (ASR) & analyze report for vulnerabilities


## 3. Prerequisites

To complete this workshop you will need:

- A personal GitHub account - [sign up here for free](https://github.com/signup)
- An Azure subscription - [sign up here for free](https://aka.ms/free)
- Access to relevant Azure AI services and models
- Familiarity with VS Code, Git and GitHub tooling
- Familiarity with Generative AI concepts & workflows

**Self-guided learners will need an Azure Subscription**. In-venue attendees will be provided with one that has resources pre-provisioned for the lab.

## 4. Azure Infrastructure

This lab uses a customized version of the [Getting Started With AI Agents](https://github.com/Azure-Samples/get-started-with-ai-agents) template for Azure AI Foundry. This sets up a basic Azure AI Foundry project with a model deployment and sample AI agent as shown in the architecture diagram below. The template has built-in support for tracing, monitoring, evaluations and red-teaming features - making it a good sandbox for this lab.

 ![Architecture](./../assets/architecture.png)

**Self-guided learners will need to provision the infrastructure themselves**. We have provided scripts and instructions to make this simple. Review the links below to understand the region availability constraints for relevant resources. 

- [Content Safety](https://learn.microsoft.com/azure/ai-services/content-safety/overview#region-availability)
- [Azure AI Search](https://learn.microsoft.com/azure/search/search-region-support#americas)
- [Risk and Safety Evaluators](https://learn.microsoft.com/azure/ai-foundry/concepts/evaluation-evaluators/risk-safety-evaluators#azure-ai-foundry-project-configuration-and-region-support)

**Our recommendation:** Use Sweden Central, France Central or East US 2

---

!!! success "NOW READY TO PROCEED TO [LAB 0: ENVIRONMENT SETUP](00-setup.md)!"
