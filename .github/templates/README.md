# MkDocs Templates & Resources

This directory contains reusable templates and resources for MkDocs documentation sites with custom Copilot branding.

## Files

### `copilot-admonitions.css`
Custom CSS for `task` and `note` admonitions styled with purple-pink Copilot branding color (#7C4ACD).

**Usage:**
1. Copy the contents into your `docs/assets/extra.css` file
2. Ensure `admonition` and `pymdownx.details` are enabled in `mkdocs.yml`

### `copilot-admonitions-examples.md`
Complete examples and documentation showing how to use the custom admonitions in your markdown files.

**Includes:**
- Basic usage examples
- Collapsible variants
- Practical lab and tip examples
- Styling details
- Installation instructions
- Usage guidelines

## Integration with Metaprompt

These templates are referenced in the main documentation metaprompt at:
- `.github/prompts/2-create-docs.prompt.md`

The metaprompt contains comprehensive instructions for:
- Setting up MkDocs with Material theme
- Creating custom home pages with card layouts
- Organizing labs with tables and navigation
- Implementing the purple-pink theme
- Using custom Copilot admonitions

## Quick Start

1. **Review the metaprompt** at `.github/prompts/2-create-docs.prompt.md`
2. **Copy CSS** from `copilot-admonitions.css` into your site
3. **Read examples** in `copilot-admonitions-examples.md`
4. **Use in markdown:**
   ```markdown
   !!! task "Your Task"
       Task description here
   
   !!! note "Important Note"
       Note content here
   ```

## Color Palette

- **Copilot Purple-Pink:** `#7C4ACD`
- **Background (10% opacity):** `rgba(124, 74, 205, 0.1)`

This color matches Microsoft Ignite and GitHub Copilot branding.
