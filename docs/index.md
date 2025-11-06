---
template: home.html
---

## Welcome to AI Red Teaming Agent Labs

This hands-on workshop teaches you how to use automated AI red teaming to identify safety and security vulnerabilities in your generative AI systems before deployment.

### What's New

!!! info "Microsoft Ignite 2025 - LAB516"
    This is a hands-on workshop for Microsoft Ignite 2025. Learn to safeguard your agents with the AI Red Teaming Agent in Azure AI Foundry.

The AI Red Teaming Agent provides powerful capabilities for securing AI systems:

- **Automated Adversarial Testing**: Systematically probe AI systems for safety vulnerabilities
- **Multiple Risk Categories**: Test for Violence, Sexual content, Hate/Unfairness, and Self-Harm
- **Attack Strategies**: Use encoding, obfuscation, and jailbreak techniques
- **Cloud and Local Scanning**: Run scans locally or at scale in Azure AI Foundry

### Quick Links

=== "Installation"

    ```bash
    # Install required packages
    pip install -r requirements.txt
    ```

=== "Verify"

    ```bash
    # Check installed versions
    pip show azure-ai-evaluation azure-ai-projects
    ```

=== "Requirements"

    ```python
    azure-ai-evaluation>=0.5.0
    azure-ai-projects>=1.1.0b3
    azure-identity
    openai
    python-dotenv
    ```

### Getting Started

Follow these steps to get up and running:

1. **[Setup Environment](getting-started/setup.md)** - Configure Azure and local tools
2. **[Explore Labs](labs/)** - Work through hands-on exercises
3. **[Join the Community](#resources)** - Connect with other learners

### Resources

!!! tip "Community & Support"
    - 💬 [Azure AI Foundry Discord](https://discord.com/invite/ByRwuEEgH4)
    - 🐛 [GitHub Forum](https://aka.ms/foundry/forum)
    - 📚 [Microsoft Learn](https://aka.ms/LearnAtIgnite?ocid=ignite25_nextsteps_github_cnl)
    - 📖 [AI Red Teaming Docs](https://learn.microsoft.com/azure/ai-foundry/concepts/ai-red-teaming-agent)

---

Ready to build safer AI? [Get started now →](getting-started/setup.md){ .md-button .md-button--primary }
