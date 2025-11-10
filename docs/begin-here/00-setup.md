# Lab 0: Environment Setup

In this lab, we'll complete Azure authentication, configure local environment variables, and validate the setup!

## Learning Objectives

By the end of this lab, you will:

- ✅ Authenticate your Codespaces environment with Azure
- ✅ Have a `.env` file with all required environment variables
- ✅ Know how to run a Jupyter notebook in GitHub Codespaces
- ✅ Use the notebook to validate that all required env variables are set

---

## 1. Complete Azure Setup

You are currently viewing this section in a web-based workshop guide launched from a GitHub Codespaces environment. This means your local development environment is working - and it's now time to setup & connect to Azure infrastructure for the lab.

=== "INSTRUCTOR LED SESSION"

    As an in-venue learner, you just need to do one step to complete setup!

    - [X] **Azure Subscription** - Check that you have credentials from Skillable
    - [X] **Infrastructure Setup** - Azure resources are pre-provisioned for you!! 
    - [ ] **Authentication** - Just complete this step to connect Codespaces to Azure!

    ---

    1. Open a new VS Code terminal and run this command:

        ```bash title="" linenums="0"
        az login
        ```

    1. Complete the device-code based auth flow when prompted
    1. Use the **Skillable-provided credentials** to log into Azure
    1. On return to VS Code, select the default subscription shown

    Your Azure and Local development environments are now ready!

=== "SELF-GUIDED SESSION"

    --8<-- "setup-self.md"

---

## 2. Create the `.env` file

By this time you should have a provisioned resource group in your Azure subscription. We will need its **resource group name** in this step.

1. Open a new browser tab - navigate to the [Azure Portal > Resource Groups](https://portal.azure.com/#browse/resourcegroups) page
1. Identify the resource group provisioned for this lab
    - For Skillable setup, it will start with `rg-Ignite`
    - For Self-Guided setup, it will be whatever you chose during setup

Now, open a new VS Code terminal in your codespaces tab

1. Change to the `infra/` folder in the repository

    ```bash title="" linenums="0"
    cd infra/
    ```
2. Run the setup-env script - enter the resource group name when prompted. 

    ```bash title="" linenums="0"
    ./2-setup-env.sh
    ```
3. On completion - you should see a `.env` file created in the root of the repo.

---

## 3. Validate The Environment

1. Return to the VS Code editor and open the File Explorer (left)
1. Open the `labs/0-setup-env` folder 
1. Click on the `0-validate-setup.ipynb` file to open the notebook
1. Click **Select Kernel** and pick the default Python environment
1. Click **Clear All Outputs** - then **Run All** to validate `.env`

If everything is successful, you should see output like this in the final cell. **Otherwise, look at the cell output error logs for insights into issues**.


```bash title="" linenums="0"
======================================================================
📊 VALIDATION SUMMARY - AI Red Teaming Lab Environment
======================================================================
✅ Valid variables: 12
❌ Missing variables: 0
⚠️  Warnings: 0

🎉 All environment variables are properly configured!
   You're ready to proceed with all lab exercises.

📚 Available Labs:
   - Lab 1: Agent Red Teaming (labs/1-scan-agent/)
   - Lab 2: Model Red Teaming (labs/2-scan-model/)
   - Lab 3: Cloud Red Teaming (labs/3-scan-cloud/)
   - Lab 4: Advanced Red Teaming (labs/4-scan-more/)
```

---

!!! success "CONGRATULATIONS!! YOU ARE READY TO START WORKING WITH LABS!"