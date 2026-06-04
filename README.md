# Replication: Athey, Inoue, and Tsugawa (2025)

This repository replicates Figure F1 and Equation (1) from:

Athey, Susan, Kosuke Inoue, and Yusuke Tsugawa. 2025. "Targeted Treatment Assignment Using Data from Randomized Experiments with Noncompliance." AEA Papers and Proceedings 115: 209-214.

## Result Replicated

Figure F1: Targeting Operator Characteristic (TOC) curve for compliance.
- Paper reports: AUTOC = 0.0412 (SE = 0.0068)
- This replication: AUTOC = 0.0414 (SE = 0.0087)

Equation (1): CLATE = tau_Y(x) / tau_W(x) estimated via instrumental forest.
- Paper reports mean LATE approximately 0.15
- This replication: mean CLATE = 0.1253

## Data

Data from the Oregon Health Insurance Experiment (OHIE):
- Finkelstein et al. (2018), Harvard Dataverse: https://doi.org/10.7910/DVN/SJG1ED
- Raw data file included in input/ as: 1_Cleaned_wide_Dataset.csv

## Prerequisites

- R (version 4.4.2+)
- R packages: readr, dplyr, missRanger, grf
- LaTeX (TinyTeX or MiKTeX)
- Make

Install R packages:
install.packages(c("readr", "dplyr", "missRanger", "grf"))

## Reproduce

git clone https://github.com/jackcghu/replication-athey-2025.git
cd replication-athey-2025
mkdir temp
make

The final paper will be at paper/paper.pdf.

## Repository Structure

replication-athey-2025/
├── input/          # Raw data (never modified by code)
├── code/
│   ├── preprocess.R   # Clean and impute data
│   └── analysis.R     # Estimate forests, produce outputs
├── output/
│   ├── figures/    # figure_f1.png
│   └── tables/     # main_result.tex, macros.tex
├── temp/           # Intermediate files (gitignored)
├── paper/
│   ├── paper.tex
│   └── paper.pdf
├── Makefile
├── run_all.sh
└── README.md