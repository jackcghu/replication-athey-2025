# Replication Proposal

**Paper:** Athey, Inoue, and Tsugawa (2025). "Targeted Treatment Assignment Using Data from Randomized Experiments with Noncompliance." AEA Papers and Proceedings 115: 209-214.

**Data:** Oregon Health Insurance Experiment. Harvard Dataverse. https://doi.org/10.7910/DVN/SJG1ED

**Result to replicate:** Figure F1 (TOC curve for compliance, AUTOC = 0.0412) and Equation (1) (CLATE = tau_Y(x) / tau_W(x), mean LATE ~ 0.15).

**Toolchain:** R. Packages: grf, missRanger, readr, dplyr.

**Why this paper:** The paper combines IV methods with machine learning to study treatment targeting under noncompliance, which is a practically important and methodologically interesting problem in program evaluation.
