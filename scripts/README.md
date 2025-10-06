# Infrastructure Setup

This project uses the [get-started-with-ai-agents](https://github.com/Azure-Samples/get-started-with-ai-agents) template to provision infrastructure for this project.

For simplicity, all steps are coded in `scripts/` that you can just run at command line to get things done.


## Authenticate with Azure

Run this command from root of repo:

```bash
./scripts/setup-auth
```

## Setup Template

Run this command from the root of repo:

```bash
./scripts/setup-azd
```

## Teardown Template

Run this command from the root of repo:

```bash
./scripts/teardown-azd
```