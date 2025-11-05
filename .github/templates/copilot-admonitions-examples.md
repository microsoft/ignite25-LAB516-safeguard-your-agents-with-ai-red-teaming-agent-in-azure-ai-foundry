# Copilot Admonitions Examples

This file demonstrates how to use the custom `task` and `note` admonitions styled with the purple-pink Copilot branding color (#7C4ACD).

## Basic Usage

### Task Admonition

Use for action items or things users should do:

```markdown
!!! task "Complete This Task"
    Follow these steps to complete the setup:
    
    1. First step
    2. Second step
    3. Third step
```

**Renders as:**

!!! task "Complete This Task"
    Follow these steps to complete the setup:
    
    1. First step
    2. Second step
    3. Third step

---

### Note Admonition

Use for important information or Copilot-specific guidance:

```markdown
!!! note "Important Information"
    This is a custom note admonition with purple-pink styling.
    Use this to highlight key concepts or Copilot tips.
```

**Renders as:**

!!! note "Important Information"
    This is a custom note admonition with purple-pink styling.
    Use this to highlight key concepts or Copilot tips.

---

## Collapsible Admonitions

### Collapsible (Closed by Default)

Use `???` for collapsible admonitions that start collapsed:

```markdown
??? task "Optional Task"
    This task is collapsible and starts closed.
    Click to expand and see the details.
```

**Renders as:**

??? task "Optional Task"
    This task is collapsible and starts closed.
    Click to expand and see the details.

---

### Collapsible (Open by Default)

Use `???+` for collapsible admonitions that start expanded:

```markdown
???+ note "Expandable Note"
    This note is collapsible but starts open.
    Users can click to collapse it if desired.
```

**Renders as:**

???+ note "Expandable Note"
    This note is collapsible but starts open.
    Users can click to collapse it if desired.

---

## Practical Examples

### Lab Task Example

```markdown
!!! task "Lab Exercise: Set Up Your Environment"
    **Objective:** Configure your development environment
    
    **Steps:**
    
    1. Open a terminal
    2. Run `pip install -r requirements.txt`
    3. Verify installation with `python --version`
    
    **Expected Result:** Python 3.10+ should be installed
```

**Renders as:**

!!! task "Lab Exercise: Set Up Your Environment"
    **Objective:** Configure your development environment
    
    **Steps:**
    
    1. Open a terminal
    2. Run `pip install -r requirements.txt`
    3. Verify installation with `python --version`
    
    **Expected Result:** Python 3.10+ should be installed

---

### Copilot Tip Example

```markdown
!!! note "💡 Copilot Tip"
    You can use GitHub Copilot to auto-complete this code.
    Just start typing the function name and press `Tab` to accept suggestions.
```

**Renders as:**

!!! note "💡 Copilot Tip"
    You can use GitHub Copilot to auto-complete this code.
    Just start typing the function name and press `Tab` to accept suggestions.

---

## Styling Details

- **Border Color:** `#7C4ACD` (Medium Purple)
- **Background:** `rgba(124, 74, 205, 0.1)` (10% opacity purple)
- **Icon Background:** `#7C4ACD`
- **Matches:** Microsoft Ignite and GitHub Copilot branding

## Installation

To use these custom admonitions in your MkDocs site:

1. Copy the CSS from `.github/templates/copilot-admonitions.css`
2. Add it to your `docs/assets/extra.css` file (or equivalent)
3. Ensure `admonition` and `pymdownx.details` are in your `markdown_extensions` in `mkdocs.yml`

```yaml
markdown_extensions:
  - admonition
  - pymdownx.details
  - pymdownx.superfences
```

## When to Use

| Admonition Type | Use Cases |
|----------------|-----------|
| `!!! task` | Action items, exercises, hands-on activities, step-by-step instructions |
| `!!! note` | Important information, tips, Copilot-specific guidance, key concepts |
| `??? task` | Optional tasks, advanced exercises, supplementary activities |
| `???+ note` | Helpful context that's visible but can be hidden, detailed explanations |
