
1. **Azure Subscription**. 

    - You need an Azure subscription with access to Azure AI services & models.
    - Keep your credentials ready!

2. **Infrastructure Setup**. 

    - Open a VS Code terminal and switch to the `infra/` folder

        ```bash title="" linenums="0"
        cd infra/
        ```

    - Authenticate using your Azure credentials.

        ```bash title="" linenums="0"
        az login
        ```

    - Run the setup script - this will prompt you for required information interactively. 

        ```bash title="" linenums="0"
        ./1-setup.sh
        ```

    - You will see a `infra/ForBeginners/` subfolder in the local filesystem
    - You will see a new resource group in Azure

!!! success "Your Azure and Local development environments are now ready!"

