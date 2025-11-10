
As a self-guided learner, you will need to do all the steps yourself!

- [ ] **Azure Subscription** - You need to use your own. Have credentials ready.
- [ ] **Infrastructure Setup** - You will need do this manually. We have scripts!
- [ ] **Authentication** - We will connect your Codespaces & Azure environments here

---

1. **Azure Subscription**. You need an Azure subscription that has quota for the required model in the targeted region. Keep the credentials ready!

2. **Infrastructure Setup**. We tried to make this easier wiht scripts.

    - First, open a VS Code terminal and switch to the `infra/` folder

        ```bash title="" linenums="0"
        cd infra/
        ```

    - Authenticate now with Azure - using your Azure credentials.

        ```bash title="" linenums="0"
        az login
        ```

    - Next, run the setup script - this will prompt you for required information interactively. On completion, you should see a `ForBeginners/` subfolder that contains the infrastructure defined by a custom template.

        ```bash title="" linenums="0"
        ./1-setup.sh
        ```

Your Azure and Local development environments are now ready!

