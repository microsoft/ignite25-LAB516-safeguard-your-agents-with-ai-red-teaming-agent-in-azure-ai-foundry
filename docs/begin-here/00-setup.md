# Lab 0: Environment Setup

!!! quote ""

    By the end of this section, you will:

    - [ ] Authenticate your Codespaces environment with Azure
    - [ ] Have a `.env` file with all required environment variables
    - [ ] Know how to run a Jupyter notebook in GitHub Codespaces
    - [ ] Use the notebook to validate that all required env variables are set

---

## 1. Complete Azure Setup

By now you should be running in a GitHub Codespaces environment with this workshop guide open in a browser tab and your infrastructure deployed in Azure.
Let's authenticate with Azure to get credentials in our codespaces environment.

=== "INSTRUCTOR LED SESSION"

    1. Open a new VS Code terminal and run this command:

        ```bash title="" linenums="0"
        az login
        ```

    1. Complete the device-code based auth flow when prompted
    1. Use the **Skillable-provided credentials** to log into Azure
    1. On return to VS Code, select the default subscription shown

    !!! success "Your Azure and Local development environments are now ready!"


=== "SELF-GUIDED SESSION"

    --8<-- "setup-self.md"

---

## 2. Create the `.env` file

Open a new VS Code terminal and let's configure our codespaces environment variables. 

1. Change to the `infra/` folder in the repository

    ```bash title="" linenums="0"
    cd infra/
    ```

1. Run the setup-env script 

    ```bash title="" linenums="0"
    ./2-setup-env.sh
    ```

1. The script will prompt you to select or specify the right resource group to use
    - For Skillable, pick the choice that starts with `rg-Ignite`
    - For Self-guided, pick the choice that you just setup earlier
    - If for any reason, the choices shown are not valid - just enter the right name

1. Verify that a `.env` file was created and populated with values.


!!! success "Your .env file was setup. Let's validate the values, next!"


---

## 3. Validate The Environment

This section will help you validate the environment variables **and** get you familiar with running Jupyter notebooks in our codespaces environment. 

1. Open VS Code editor and click_Explorer_ icon in left sidebar
1. Open the `labs/0-setup-env` folder - view the file listing
1. Click on `0-validate-setup.ipynb` - this opens notebook in editor
1. Click **Select Kernel** - pick the default Python environment
1. Click **Clear All Outputs** - then click **Run All** 
1. Wait till run completes - scroll to the final cell (bottom of page)

You should see output like this:

- If everything works, you get `Missing variables: 0`
- If something failed, scroll back to that cell to resolve the error - and re-run it.


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