# Lab 1: Scan Azure AI Agent

## Learning Objectives

By completing this lab, you will learn how to:

- ✅ Understand how the AI Red Teaming Agent works and its core components
- ✅ Configure and authenticate with Azure AI Foundry using DefaultAzureCredential
- ✅ Retrieve an existing Azure AI agent from your project
- ✅ Create an agent callback function for red team testing
- ✅ Run an automated red team scan with risk categories and attack strategies
- ✅ Analyze scan results and understand Attack Success Rate (ASR) metrics

## Instructions

1. **Open the notebook**: Navigate to `labs/1-scan-agent/` and open [`1-scan-agent.ipynb`](../../labs/1-scan-agent/1-scan-agent.ipynb)
2. **Run cells sequentially**: Execute each cell from top to bottom by clicking the ▶️ button or pressing `Shift+Enter`
3. **Observe agent retrieval**: Watch how the AIProjectClient connects to Azure and retrieves your agent
4. **Test the callback**: See how the agent_callback function enables red team testing
5. **Run the scan**: Execute the red team scan and wait for results (3-5 minutes)
6. **Analyze results**: Review the Attack Success Rate and scan outputs in both local files and Azure portal

**Expected Time**: 20-30 minutes

## Ask Copilot

Use these prompts with GitHub Copilot Chat to deepen your understanding:

!!! prompt ""
    
    **Ask GitHub Copilot:**
    
    - "What is AI red teaming and why is it important? Explain how the AI Red Teaming Agent helps identify safety vulnerabilities in generative AI systems."
    - "Explain what Attack Success Rate (ASR) means in AI red teaming. How is it calculated, and what does a high or low ASR indicate about an AI system's safety?"
    - "What are the four supported risk categories in AI red teaming (Violence, Sexual, Hate/Unfairness, Self-Harm)? Provide examples of prompts for each category."
    - "Explain the different attack strategies like Flip, Base64, Jailbreak, and Leetspeak. How do these strategies help test AI safety by obfuscating harmful prompts?"

---

**Previous Lab**: [← Lab 0: Environment Setup](00-setup.md) | **Next Lab**: [Lab 2: Scan Models & Applications →](02-scan-model.md)

By the end of this lab, you will:

- ✅ Understand how the AI Red Teaming Agent works
- ✅ Configure and authenticate with Azure AI Foundry
- ✅ Retrieve an existing agent from your project
- ✅ Set up an agent callback for testing
- ✅ Run an automated red team scan
- ✅ Analyze scan results and understand Attack Success Rate (ASR)

## What is AI Red Teaming?

The **AI Red Teaming Agent** helps organizations proactively find safety risks in generative AI systems. It simulates adversarial attacks by:

1. **Generating adversarial prompts** - Creates attack objectives across risk categories
2. **Sending prompts to the target** - Communicates with your AI agent or model
3. **Analyzing responses** - Evaluates if attacks successfully elicited unsafe content
4. **Generating security reports** - Provides metrics like Attack Success Rate (ASR)

![How AI Red Teaming Works](https://learn.microsoft.com/en-us/azure/ai-foundry/media/evaluations/red-teaming-agent/how-ai-red-teaming-works.png)

!!! info "Built on PyRIT"
    The AI Red Teaming Agent leverages [PyRIT (Python Risk Identification Tool)](https://github.com/Azure/PyRIT), Microsoft's open-source framework for AI red teaming.

## Prerequisites

- ✅ **Lab 0 completed** - Environment setup with Azure resources
- ✅ **Environment variables configured** - `.env` file with Azure credentials
- ✅ **Agent deployed** - Existing Azure AI agent in your project
- ✅ **Notebook environment** - Jupyter or VS Code with Python kernel

!!! prompt ""
    
    **Ask GitHub Copilot:**
    
    - "What is the AI Red Teaming Agent?"
    - "Explain the attack strategies used in red teaming"
    - "How does Attack Success Rate (ASR) measure safety?"

## Lab Instructions

### Step 1: Open the Notebook

Navigate to the lab directory and open the notebook:

```bash
cd labs/1-scan-agent
jupyter notebook 1-scan-agent.ipynb
# OR
code 1-scan-agent.ipynb
```

### Step 2: Import Required Libraries

Run the following cell to import all necessary libraries:

```python
from typing import Optional, Dict, Any
import os
import time
from pathlib import Path
from dotenv import load_dotenv

# Azure imports
from azure.identity import DefaultAzureCredential, get_bearer_token_provider
from azure.ai.evaluation.red_team import RedTeam, RiskCategory, AttackStrategy
from azure.ai.projects import AIProjectClient
import azure.ai.agents
from azure.ai.agents.models import ListSortOrder

print("✅ All libraries imported successfully!")
```

**Key packages:**

- `azure.ai.evaluation` - For running local red team scans
- `azure.ai.projects` - For interacting with Azure AI Foundry
- `azure.identity` - For Azure authentication
- `azure.ai.agents` - For working with AI agents

!!! prompt ""
    
    **Ask GitHub Copilot:**
    
    - "What is DefaultAzureCredential and how does it work?"
    - "Explain the difference between RedTeam and AIProjectClient"
    - "What authentication methods does DefaultAzureCredential support?"

### Step 3: Load Environment Variables

Load your Azure configuration from the `.env` file:

```python
# Load environment variables from .env file
current_dir = Path(os.getcwd())
env_path = current_dir / ".env"

# Try loading from current directory first, then parent directories
if not env_path.exists():
    env_path = current_dir.parent / ".env"
if not env_path.exists():
    env_path = current_dir.parent.parent / ".env"

load_dotenv(dotenv_path=env_path)

print(f"✅ Environment variables loaded from: {env_path}")
```

This cell searches for your `.env` file in the current directory and parent directories.

### Step 4: Initialize Azure Credentials

Set up Azure authentication:

```python
# Initialize Azure credentials
credential = DefaultAzureCredential(exclude_interactive_browser_credential=False)

# Get AI project parameters from environment variables
project_endpoint = os.environ.get("AZURE_AI_PROJECT_ENDPOINT")
deployment_name = os.getenv("AZURE_AI_DEPLOYMENT_NAME")  
agent_id = os.environ.get("AZURE_EXISTING_AGENT_ID")
agent_name = os.environ.get("AZURE_AI_AGENT_NAME")

# Validate required environment variables
if not project_endpoint:
    raise ValueError("❌ AZURE_AI_PROJECT_ENDPOINT environment variable is not set!")
    
if not agent_id and not agent_name:
    raise ValueError("❌ Please set either AZURE_EXISTING_AGENT_ID or AZURE_AI_AGENT_NAME.")

print("✅ Azure credentials initialized successfully!")
print(f"📍 Project Endpoint: {project_endpoint}")
print(f"🤖 Agent ID: {agent_id if agent_id else 'Will lookup by name: ' + agent_name}")
```

**DefaultAzureCredential** supports multiple authentication methods in order:

1. Environment variables
2. Managed Identity (in Azure)
3. Azure CLI (`az login`)
4. Interactive browser (fallback)

!!! task "Verify Your Configuration"
    
    Ensure you see:
    
    - ✅ Credentials initialized successfully
    - 📍 Your project endpoint URL
    - 🤖 Your agent ID or name

### Step 5: Retrieve the Agent

Connect to your Azure AI Foundry project and retrieve the agent:

```python
# Create AI Project Client
project_client = AIProjectClient(endpoint=project_endpoint, credential=credential)

# Look up the agent by name if agent ID is not provided
if not agent_id and agent_name:
    print(f"🔍 Searching for agent with name: {agent_name}")
    for agent_item in project_client.agents.list_agents():
        if agent_item.name == agent_name:
            agent_id = agent_item.id
            print(f"✅ Found agent: {agent_name} (ID: {agent_id})")
            break
            
if not agent_id:
    raise ValueError("❌ Agent ID not found. Please provide a valid agent ID or name.")
    
# Retrieve the agent
agent = project_client.agents.get_agent(agent_id)

# Use model from agent if deployment name not explicitly provided
if not deployment_name:
    deployment_name = agent.model
    
print(f"\n✅ Agent retrieved successfully!")
print(f"  - Agent ID: {agent.id}")
print(f"  - Agent Name: {agent.name}")
print(f"  - Using Model: {deployment_name}")
```

This cell:

1. Creates an `AIProjectClient` to connect to your Azure AI Foundry project
2. Searches for your agent by name (if ID not provided)
3. Retrieves the agent object
4. Extracts the model deployment name

### Step 6: Create a Conversation Thread

Create a thread for agent communication:

```python
# Create a thread for agent communication
thread = project_client.agents.threads.create()

print(f"✅ Conversation thread created: {thread.id}")
```

**Threads** maintain conversation context and history during red team testing.

### Step 7: Define the Agent Callback

Create a callback function that allows the Red Team Agent to interact with your agent:

```python
def agent_callback(query: str) -> str:
    """
    Callback function for the Red Team Agent to interact with the target agent.
    
    Args:
        query: The adversarial prompt to send to the agent
        
    Returns:
        The agent's response to the query
    """
    # Create a message in the thread
    message = project_client.agents.messages.create(
        thread_id=thread.id, 
        role="user", 
        content=query
    )
    
    # Create a run to process the message
    run = project_client.agents.runs.create(
        thread_id=thread.id, 
        agent_id=agent.id
    )

    # Poll the run until it completes
    while run.status in ["queued", "in_progress", "requires_action"]:
        time.sleep(1)
        run = project_client.agents.runs.get(thread_id=thread.id, run_id=run.id)

    # Handle errors
    if run.status == "failed":
        print(f"Run error: {run.last_error}")
        return "Error: Agent run failed."
    
    # Retrieve and return the agent's response
    messages = project_client.agents.messages.list(
        thread_id=thread.id, 
        order=ListSortOrder.DESCENDING
    )
    
    for msg in messages:
        if msg.text_messages:
            return msg.text_messages[0].text.value
    
    return "Could not get a response from the agent."

print("✅ Agent callback function defined successfully!")
```

**How it works:**

1. Sends the adversarial query to your agent
2. Creates a run to process the query
3. Polls for completion
4. Returns the agent's response

!!! prompt ""
    
    **Ask GitHub Copilot:**
    
    - "Explain how the agent callback function works"
    - "What is a thread in Azure AI agents?"
    - "Why do we need to poll the run status?"

### Step 8: Configure the Red Team Agent

Initialize the Red Team Agent with your scan configuration:

```python
# Initialize the Red Team Agent
red_team = RedTeam(
    azure_ai_project=project_endpoint,
    credential=credential,
    risk_categories=[RiskCategory.Violence],  # Testing for violent content
    num_objectives=1,  # One attack objective per category
    output_dir="scan-results/"  # Save results to this directory
)

print("✅ Red Team Agent configured successfully!")
print(f"📊 Risk Categories: Violence")
print(f"🎯 Attack Objectives per Category: 1")
print(f"💾 Output Directory: scan-results/")
```

**Configuration explained:**

- **azure_ai_project** - Your Azure AI Foundry project endpoint
- **credential** - Azure authentication credentials
- **risk_categories** - Which risk types to test
- **num_objectives** - Number of attack objectives per category (start with 1 for quick testing)
- **output_dir** - Where to save scan results

**Supported Risk Categories:**

| Risk Category | Description |
|--------------|-------------|
| `Violence` | Content intended to hurt, injure, damage, or kill |
| `Sexual` | Content related to anatomical organs or sexual acts |
| `HateUnfairness` | Hateful content or unfair representations |
| `SelfHarm` | Content related to actions intended to hurt oneself |

!!! info "Learn More"
    See [Supported Risk Categories](https://learn.microsoft.com/azure/ai-foundry/concepts/ai-red-teaming-agent#supported-risk-categories) for full details.

### Step 9: Run the Red Team Scan

Execute the red team scan with an attack strategy:

```python
print("🚀 Starting Red Team scan...")
print(f"Target: {agent.name}")
print(f"Attack Strategy: Flip")
print("-" * 50)

# Run the scan (use await if in async context)
result = await red_team.scan(
    target=agent_callback,
    scan_name="1-Agent-Target",
    attack_strategies=[AttackStrategy.Flip],
)

print("-" * 50)
print("✅ Red Team scan complete!")
print(f"📁 Results saved to: scan-results/")
```

**Attack Strategies:**

| Strategy | Description | Complexity |
|----------|-------------|------------|
| `Flip` | Reverses character order in prompts | Easy |
| `Base64` | Encodes prompts in Base64 format | Easy |
| `Leetspeak` | Replaces letters with numbers/symbols | Easy |
| `Jailbreak` | Injects prompts to bypass safeguards | Moderate |
| `ROT13` | Shifts characters by 13 positions | Easy |

!!! warning "Scan Duration"
    This may take **3-5 minutes** depending on:
    
    - Number of objectives
    - Number of attack strategies
    - Model response time

!!! prompt ""
    
    **Ask GitHub Copilot:**
    
    - "What does the Flip attack strategy do?"
    - "How is Attack Success Rate calculated?"
    - "Explain the different attack complexity levels"

### Step 10: Clean Up Resources

Close the project client:

```python
# Close the project client
project_client.close()

print("✅ Resources cleaned up successfully!")
```

## Understanding Your Results

### Local Results

After the scan completes, you'll find results in the `scan-results/` directory:

```
scan-results/
├── 1-Agent-Target/
│   ├── scorecard.json          # Summary metrics
│   ├── conversations/          # Full conversation logs
│   └── details.json            # Row-level data
```

**Key metrics in scorecard.json:**

- **Attack Success Rate (ASR)** - Percentage of attacks that succeeded
- **Total Attacks** - Number of attack-response pairs
- **Successful Attacks** - Number that elicited unsafe content

### Azure AI Foundry Portal Results

Results are automatically logged to your Azure AI Foundry project!

!!! task "View Results in Portal"
    
    1. Navigate to [Azure AI Foundry](https://ai.azure.com)
    2. Select your project
    3. Go to **Evaluation** → **AI red teaming** tab
    4. Click on your scan: `1-Agent-Target`

**Portal features:**

- **Risk Category Reports** - Breakdown by risk type
- **Attack Complexity Reports** - Classification by difficulty
- **Data View** - Row-level attack-response pairs
- **Conversation History** - Full interaction context

![AI Red Teaming Portal](https://learn.microsoft.com/en-us/azure/ai-foundry/media/evaluations/red-teaming-agent/ai-red-team.png)

!!! copilot "Ask GitHub Copilot"
    
    Try asking:
    
    - "How do I interpret Attack Success Rate?"
    - "What's a good ASR threshold for production?"
    - "Explain the risk category breakdown report"

## Experimentation Ideas

!!! task "Try These Variations"
    
    1. **Test more risk categories:**
    
    ```python
    risk_categories=[
        RiskCategory.Violence,
        RiskCategory.Sexual,
        RiskCategory.HateUnfairness,
        RiskCategory.SelfHarm
    ]
    ```
    
    2. **Increase attack objectives:**
    
    ```python
    num_objectives=5  # More comprehensive testing
    ```
    
    3. **Try different attack strategies:**
    
    ```python
    attack_strategies=[
        AttackStrategy.Jailbreak,
        AttackStrategy.Base64,
        AttackStrategy.Flip
    ]
    ```
    
    4. **Compare results:**
    
    Run multiple scans with different configurations and compare ASR scores.

## Troubleshooting

??? question "Error: Agent not found"
    
    **Problem:** Cannot retrieve agent by name or ID
    
    **Solution:**
    
    1. Verify agent exists: Visit Azure AI Foundry Portal
    2. Check environment variable: `echo $AZURE_AI_AGENT_NAME`
    3. List all agents:
    
    ```python
    for agent in project_client.agents.list_agents():
        print(f"{agent.name} - {agent.id}")
    ```

??? question "Error: Authentication failed"
    
    **Problem:** DefaultAzureCredential cannot authenticate
    
    **Solution:**
    
    1. Run `az login` in terminal
    2. Verify subscription: `az account show`
    3. Check environment variables are loaded

??? question "Scan takes too long"
    
    **Problem:** Scan running for 10+ minutes
    
    **Solution:**
    
    1. Reduce `num_objectives` to 1
    2. Use fewer attack strategies
    3. Test one risk category at a time

## Next Steps

Congratulations! You've completed your first AI Red Teaming scan! 🎉

**What's next:**

1. **[Lab 2: Scan Models & Applications](02-scan-model.md)** - Test different target types
2. **[Lab 3: Cloud-Based Red Teaming](03-scan-cloud.md)** - Scale with cloud scans
3. **[Lab 4: Advanced Attack Strategies](04-scan-advanced.md)** - Comprehensive testing

## Additional Resources

- [AI Red Teaming Agent Documentation](https://learn.microsoft.com/azure/ai-foundry/concepts/ai-red-teaming-agent)
- [PyRIT - Python Risk Identification Tool](https://github.com/Azure/PyRIT)
- [Planning Red Teaming for LLMs](https://learn.microsoft.com/azure/ai-foundry/openai/concepts/red-teaming)
- [Risk and Safety Evaluators](https://learn.microsoft.com/azure/ai-foundry/concepts/evaluation-evaluators/risk-safety-evaluators)

---

[Continue to Lab 2 →](02-scan-model.md){ .md-button .md-button--primary }
[Back to Labs](index.md){ .md-button }
