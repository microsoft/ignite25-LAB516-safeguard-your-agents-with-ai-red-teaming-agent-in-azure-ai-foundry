# Overview

Welcome to the hands-on workshop on **AI Red Teaming using Azure AI Foundry**. This workshop will take you from understanding core concepts to implementing and running AI red teaming scans both locally and in the cloud.

**Duration:** 75 minutes  
**Level:** Beginner to Intermediate  
**Prerequisites:** Basic understanding of AI/ML concepts and Python programming

---


## Before You Begin

This workshop is setup for both instructor-led (in venue) and self-guided (at home) sessions. Pick the tab that describes your current context. It will automatically be enforced throughout the site.

## Prerequisites

Before starting this workshop, ensure you have:

- **Azure Subscription** with appropriate permissions
- **Python 3.10, 3.11, or 3.12** installed (PyRIT doesn't support Python 3.9)
- **Azure CLI** installed and configured
- **Basic familiarity** with Python development and Azure services
- **Access** to Azure AI Foundry (or willingness to create a free trial)

## Learning Objectives

By the end of this workshop, you will be able to:

1. **Understand** the fundamentals of AI red teaming and its importance in AI safety
2. **Identify** different risk categories and attack strategies used in AI red teaming
3. **Set up** and configure the AI Red Teaming Agent locally using PyRIT
4. **Execute** automated safety scans against AI models and applications
5. **Deploy** and manage AI red teaming in the cloud using Azure AI Foundry
6. **Analyze** results and interpret Attack Success Rate (ASR) metrics
7. **Implement** best practices for continuous AI safety monitoring

## Workshop Structure

### 📚 [1. Introduction](./01-intro/README.md) *(15 minutes)*
- Core concepts and terminology
- Understanding risk categories and attack strategies
- The role of AI red teaming in responsible AI development

### 🖥️ [2. Local Scan With PyRIT](./02-local-red-teaming/README.md)
- Setting up the development environment
- Installing and configuring PyRIT and Azure AI Evaluation SDK
- Running your first red teaming scan locally
- Understanding and analyzing results

### ☁️ [3. Cloud Scan With AIF](./03-cloud-red-teaming/README.md) 
- Configuring Azure AI Foundry projects
- Setting up cloud-based red teaming scans
- Managing and monitoring scans at scale
- Viewing results in the Azure portal

---

## Getting Started

The quickest way to start is to use GitHub Codespaces

1. **Fork this repository** to your personal profile
2. **Navigate** to fork in a new browser tab
3. Click the **Code** button, select **Codespaces** tab
4. Click the **Create Codespaces** button

This opens a new GitHub Codespaces session in a new browser tab. Wait till the session loads, then preview the instruction guide, next.


## Preview Guide

The repository is configured to use [mkdocs-material](https://squidfunk.github.io/mkdocs-material/), a modern and customizable documentation framework for MkDocs. To preview the workshop guide:

1. Open a new VS Code Terminal in your Codespaces session
1. Run this command - you will see a dialog pop-up
    ```bash
    mkdocs serve
    ```
1. Select _Open in Browser_ - you should see (this page) previewed in the browser.
1. Click the [Core Labs](./Core%20Labs/01-intro/) page to get started!

---

## Additional Resources

- [Azure AI Foundry Documentation](https://learn.microsoft.com/en-us/azure/ai-foundry/)
- [PyRIT GitHub Repository](https://github.com/Azure/PyRIT)
- [Microsoft AI Red Team Resources](https://www.microsoft.com/security/blog/2023/08/07/microsoft-ai-red-team-building-future-of-safer-ai/)
- [Responsible AI Best Practices](https://www.microsoft.com/ai/responsible-ai)

---

**Ready to secure your AI systems?** Let's begin with [Module 1: Introduction to AI Red Teaming](./01-intro/README.md) 🚀




