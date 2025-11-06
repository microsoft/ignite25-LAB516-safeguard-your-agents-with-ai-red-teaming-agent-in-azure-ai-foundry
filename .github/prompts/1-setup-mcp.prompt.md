---
mode: agent
---

# Task: Update `.vscode/mcp.json` Configuration

1. If the `.vscode/mcp.json` file does not exist in the repository, create it.
1. Check if the `.vscode/mcp.json` file contains the MCP server configuration for Microsoft Docs.
   Else add it with the following content and remind the user to "start" the server.
   
```json
{
	"servers": {
		"microsoft.docs.mcp": {
			"url": "https://learn.microsoft.com/api/mcp",
			"type": "http"
		}
	},
	"inputs": []
}
```.github/prompts