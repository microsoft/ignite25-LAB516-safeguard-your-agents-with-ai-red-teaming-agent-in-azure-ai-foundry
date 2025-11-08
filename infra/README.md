# Infrastructure Setup Scripts

## About This Document

**📚 | FOR LEARNERS**

Are you a workshop participant in an instructor-led session or taking the self-guided option at home? This README is meant for maintainers. As a learner, we recommend you launch the workshop guide instead - and follow the steps to _use_ these scripts.

1. We assume you have a personal fork of this repo
1. If you haven't done so - launch GitHub Codespaces on your fork
1. When ready - open a VS Code terminal to the root of the repo
1. Run this command and wait a few seconds - you should see a popup
    ```bash
    mkdocs serve
    ```
1. Accept the "Open in browser" default - you should see a new tab open with the workshop guide. Click the _Begin Here_ tab and get started.

<br/>

**🧰 | FOR MAINTAINERS**

This README explains how to run the scripts to setup infrastructure for this lab - but also provides insights into the decisions made to use an azd template and customize it. By reading this section you should be able to:

1. Understand what each script does.
1. Run scripts to create a customized infra for this lab.
1. Update scripts to evolve this lab to support new features later.

Ready? Read on!


<br/>

## Template Overview

The lab explores Red Teaming Agent usage in the context of an AI Agent application (with underlying tools and models) running in Azure AI Foundry. To provide a sandbox environment that can _evolve with the learner_, we will use the [Get Started with AI Agents](https://github.com/Azure-Samples/get-started-with-ai-agents) template with the architecture shown below.

The template provisions a single AI Agent with a backing Large Language Model - and a front-end UI (web app) hosted in a Contaner Apps environment. While the template has support for Azure AI Search activation, this is _optional_. The template also allows you to activate features like tracing and application insights by configuring the _azd_ environment before deploying infrastructure with `azd up`.

![AZD](./../docs/assets/architecture.png)

For convenience (and control) we maintain a custom base instance of this template in a [ForBeginners](https://github.com/microsoft/forBeginners) repository, along with scripts that can be used to customize it for various labs like this one. 

## Scripts Overview

The scripts below make this transparent to you with just 3 steps required to provision (infra), setup (env variables), and teardown (cleanup).

| Script | Purpose |
|--------|---------|
| `1-setup.sh` | Clone template repository and provision Azure infrastructure |
| `2-setup-env.sh` | Configure environment variables for local development |
| `3-teardown.sh` | Delete all provisioned Azure resources |

## Setup Infrastructure

### 1. Initial Setup & Provisioning

```bash
./1-setup.sh
```

**What it does:**
- Clones the ForBeginners repository template
- Creates an Azure Developer CLI (azd) environment
- Configures AI model settings (with confirmation prompts)
- Provisions Azure infrastructure (does NOT deploy the application)

**Note:** After this completes, you'll need to manually run `azd up` if you want to deploy the application.

### 2. Environment Configuration

```bash
./2-setup-env.sh
```

**What it does:**
- Exports Azure resource connection strings and endpoints as environment variables
- Required before running local lab exercises

**Important:** Use `source` (not `./`) to ensure variables are set in your current shell.

### 3. Cleanup (Optional)

```bash
./3-teardown.sh
```

**What it does:**
- Removes all Azure resources created during setup
- Use this when you're done with the lab to avoid ongoing charges

<br/>

## Setup Agent

By default, the template will have created an AI Agent for you with a default set of instructions. To give us more contral, let's set up a _named agent_ of our own to reflect the **Zava DIY Customer Support** chatbot scenario.

**1. CREATE A NEW AGENT**

1. Visit the [AI Foundry Portal](https://ai.azure.com)
1. Click on the AI Foundry Project created by template
1. Click on the Agent tab in the portal
1. Click **Create** to create a new Agent
    1. Set its name to "Cora-For-Zava"
    1. Set its description to
        ```bash
        "You are Cora, a polite and helpful chatbot for Zava, an enterprise retailer of Home Improvement goods for DIY enthusiats"
        ```
    1. Set its instructions as follows:

        ```
        You are a customer support chatbot for the Zava Home Improvement retail store.
        You are polite and helpful in your answers.
        You follow all legal and ethical guidelines.

        You always start by acknowledging the user's question with a cheerful phrase and an emoji related to the topic.
        For instance: "🔫Love this DIY project!"

        You then answer the question with a brief and factual answer (1-2 sentences max)

        Then you end with a helpful question that can guide the customer towards their goal.
        ```

**2. TEST THE AGENT**

1. Ask a question like: 
    ```bash
    I want to paint my living room wall. What paint should I buy?
    ```
1. Verify that the agent is responding to you with the right format (polite, cheerful emoji, helpful ending)


**3. TEST THE AGENT**

1. Note that the responses are not grounded in knowledge (yet). The agent playground in the portal does have the ability to attach knowledge and action tools - but we will not be using them in our _Core Labs_ today.
1. However, note that our azd template is setup to support Azure AI Search - and we expect to add "More Labs" content later to help you explore these scenarios in more detail. So fork and star the repo -- and keep an eye out for updates.

**Congratulations** - You are ready for labs!

<br/>

## Refresh Environment

Sometimes, you may deploy the infrastructure - but then shut down the Codespaces (development environment) and then relaunch it another day to continue working. 

In this case, how do you _refresh_ the local environment variables needed to connect back to your pre-provisioned infrastructure? We made it simple. 

The `scripts/2-setup-env.sh` script will automatically recreate the `.env` for you from the resource group details, using the Azure CLI, in 2 steps:

1. Open a VS Code terminal and authenticate with Azure CLI. Complete the device code auth flow and select the desired subscription when prompted to do so.

    ```bash
    az login
    ```
1. Now run the script. 

    ```bash
    ./infra/2-setup-env.sh
    ```
1. You will be prompted to enter 
    - the resource group name for provisioned infra in this subscription e.g., "rg-ignite-lab519"
    - the default agent name that exists in that resource group e.g., "Cora-For-Zava"
1. In just a few seconds you will see a `.env` file created with the same format as `infra/.env.sample` - and all values filled!

**Congratulations** - You are ready for labs!