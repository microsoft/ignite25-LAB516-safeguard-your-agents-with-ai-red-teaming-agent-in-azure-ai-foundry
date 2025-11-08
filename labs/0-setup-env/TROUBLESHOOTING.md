# Understanding Red Teaming Agent

## Troubleshooting

Sometimes you may see error messages in the prompt output that may look like your operation failed. In reality, this may be an expected outcome (e.g., Content Safety filter kicked in and blocked the prompt or response) or a known limitation of the underlying PyRIT framework. This section captures troubleshooting guidance for such error messages.

<br/>

### 1. Error Processing Prompts

When running specific attack strategies you might see an error like this.

```bash
ERROR: [morse/sexual] Error processing prompts: Data type text without prompt text not supported
...
...
                        ^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/vscode/.local/lib/python3.12/site-packages/pyrit/models/data_type_serializer.py", line 81, in data_serializer_factory
    raise ValueError(f"Data type {data_type} without prompt text not supported")
...
```

This error happens because the **Morse code attack** strategy in PyRIT sometimes fails to preserve the prompt text during encoding, resulting in an invalid object. When PyRIT tries to serialize this, it triggers the above validation error. The underlying process looks something like this:

1. RedTeam generates an adversarial prompt: ✅
2. Morse converter receives it: ✅
3. Morse converter encodes it: ✅ (or partial ✅)
4. Result gets packaged: ❌ (data structure malformed)
5. Serializer receives: data_type="text", prompt_text=None/Empty
6. Throws error: "Data type {data_type} without prompt text not supported""

The Morse strategy converts text prompts into Morse code (dots and dashes: ·− −−− ·−· ··· ·) - it's possible that the Morse converter has edge cases where the resulting data structure is invalid because it encounters characters it cannot encode or that it encodes in ways that break the data structure.

**Bottom Line:** The red team agent scan is still operating correctly. This is just a case where the PyRIT framework had a bug/failure for a specific prompt edge case. Since these prompts are geenerated for us stochastically, we cannot be certain of when such edge cases occur.. _Just ignore those errors for now - the run will still complete_.