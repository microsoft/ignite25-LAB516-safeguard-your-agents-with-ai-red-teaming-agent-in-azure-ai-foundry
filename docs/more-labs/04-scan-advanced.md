# Lab 4: Complex Scans

## Learning Objectives

By completing this lab, you will learn how to:

- ✅ Understand attack complexity levels: EASY, MODERATE, and DIFFICULT
- ✅ Use attack strategy groups for comprehensive multi-complexity testing
- ✅ Test all four risk categories simultaneously in a single scan
- ✅ Configure large-scale scans with multiple objectives per category
- ✅ Interpret results from extensive red team scans (100+ attack-response pairs)
- ✅ Apply comprehensive testing strategies to production-ready AI systems

## Instructions

1. **Open the notebook**: Navigate to `labs/4-scan-more/` and open [`4-scan-deepseek.ipynb`](../../labs/4-scan-more/4-scan-deepseek.ipynb)
2. **Review attack complexity**: Understand EASY (Base64, Flip, Morse), MODERATE (Tense), DIFFICULT (Composition)
3. **Configure comprehensive scan**: Set up scan with all risk categories and strategy groups
4. **Run the scan**: Execute the comprehensive scan (this takes 20-40 minutes due to scope)
5. **Analyze extensive results**: Review the ~100+ attack-response pairs across all categories
6. **Compare complexity levels**: See how attack success varies by complexity

**Expected Time**: 40-60 minutes (includes long scan duration)

## Ask Copilot

Use these prompts with GitHub Copilot Chat to deepen your understanding:

!!! prompt ""
    
    **Ask GitHub Copilot:**
    
    - "Explain the three attack complexity levels: EASY, MODERATE, and DIFFICULT. What makes an attack strategy more complex, and why do different complexity levels require different resources?"
    - "What attack strategies are included in each complexity group? Describe how Base64, Flip, Morse (EASY), Tense (MODERATE), and Composition attacks work."
    - "How do composition attacks work by combining multiple strategies? Why are they classified as DIFFICULT, and what makes them harder to defend against?"
    - "How should I use comprehensive multi-complexity testing in my production AI deployment workflow? What ASR thresholds should I target for different risk categories?"

---

**Previous Lab**: [← Lab 3: Cloud-Based Red Teaming](../labs/03-scan-cloud.md) | **Congratulations!** You've completed all labs! 🎉
