This repository contains the replication materials for the paper "Targeted Treatment Assignment Using Data from Randomized Experiments with Noncompliance" authored by Susan Athey, Kosuke Inoue, and Yusuke Tsugawa, forthcoming at AER: Papers & Proceedings. The working paper is available on [SSRN](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=5214522).

# Data 

Citation: Finkelstein, Amy. Oregon Health Insurance Experiment Public Use Data, 2013. Available at http://www.nber.org/oregon/data.html.

The data used in this project can be downloaded for free at [this website](https://www.nber.org/research/data/oregon-health-insurance-experiment-data) (see also citation). We do not include it in the repo because each user must agree to terms and conditions before downloading from the NBER website. To access the data, create an NBER log in, if you do not have one already, then log in to the provided website. After you agree to terms, you will be able to download a zip folder containing all relevant datasets and documentation on the data. After you have extracted the contents of the zip folder, navigate to OHIE_Public_Use_Files >> OHIE_Data. There, you will find the following files:

- `oregonhie_survey6m_vars.dta`
- `oregonhie_survey12m_vars.dta`
- `oregonhie_ed_vars.dta`
- `oregonhie_inperson_vars.dta`
- `oregonhie_patterns_vars.dta`
- `oregonhie_stateprograms_vars.dta`
- `oregonhie_survey0m_vars.dta`
- `oregonhie_descriptive_vars.dta`

If you want to replicate the results of this project from the raw data, copy and paste these files into Input_Data >> Data after cloning the repo. Then, run the `prepare_data_modified.do` file in the Input_Data folder. It is recommended that you reference OHIE_Public_Use_Files >> OHIE_Documentation for variable codebooks and guides with details on the survey design.

Otherwise, you can use the pre-processed data included in the Input_Data folder: `data_for_analysis.dta` and start from script 1_Initial_Data_Cleaning below.

# Computational Requirements

## Software Requirements

The codebase uses R Scripts almost exclusively; however, if you want to replicate the results from the raw data, the raw data is in Stata format, so the pre-processing is also conducted in Stata.

- R (code was last run on version 4.3.3)  
    - It is important to run the code on the specified versions of grf (2.4.0) and missRanger (2.6.1) to replicate the results of the paper.
    - Each script installs and loads the necessary R packages.

**Necessary R packages with specific versions:**  
- grf: 2.4.0  
- missRanger: 2.6.1  
- ggplot2: 3.5.2  
- tidyr: 1.3.1 (from tidyverse)  
- dplyr: 1.1.4  
- metafor: 4.8.0  
- splitstackshape: 1.4.8  
- tidyverse: 2.0.0  
- foreach: 1.5.2  
- cowplot: 1.2.0  
- reshape2: 1.4.4  
- doParallel: 1.0.17  
- survival: 3.8.3  
- readstata13: 0.11.0  
- rsample: 1.3.1  
- DiagrammeR: 1.0.11  
- e1071: 1.7.16  
- pscl: 1.5.9  
- pROC: 1.19.0.1  
- caret: 7.0.1  
- ModelMetrics: 1.2.2.2  
- MatchIt: 4.7.2  
- Hmisc: 5.2.3  
- scales: 1.4.0  
- lmtest: 0.9.40  
- sandwich: 3.1.1  
- haven: 2.5.5  
- rpms: 0.5.1  
- randomForest: 4.7.1.2  
- fabricatr: 1.0.2  
- gridExtra: 2.3  
- VIM: 6.2.2  
- mice: 3.18.0  
- missForest: 1.5  
- ivreg: 0.6.5  
- kableExtra: 1.4.0  
- xtable: 1.8.4  
- corrplot: 0.95  
- psych: 2.5.6  

## Controlled Randomness

**Summary:**  
- All 8 core scripts have deterministic seeds set.  
- Primary seed: `777` (used across all scripts).  
- Forest-specific seeds: `123456789` (IV forest) and `987654321` (causal forest).  
- Seeds are always defined in the “Non-run-specific parameters” section of each script.

**2_Impute_Missing_Data.Rmd**  
- Random seed set at line 59  
- `seedset <- 777`  

**3_Create_New_Outcomes.Rmd**  
- Random seed set at line 62  
- `seedset <- 777`  

**4_Run_Forests.Rmd**  
- Random seeds set at lines 62–64  
- `seedset <- 777`, `seed.ivforest <- 123456789`, `seed.cf <- 987654321`  

**4a_Tune_ohp.Rmd** *(not required for replication)*  
- Random seeds set at lines 62–64  
- `seedset <- 777`, `seed.ivforest <- 123456789`, `seed.cf <- 987654321`  

**4a_Tune_debt.Rmd** *(not required for replication)*  
- Random seeds set at lines 62–64  
- `seedset <- 777`, `seed.ivforest <- 123456789`, `seed.cf <- 987654321`  

**5_CDFs.Rmd**  
- Random seed set at line 57  
- `seedset <- 777`  

**6_TOCs.Rmd**  
- Random seeds set at lines 59–61  
- `seedset <- 777`, `seed.ivforest <- 123456789`, `seed.cf <- 987654321`  

**7_Quintile_Plots.Rmd**  
- Random seed set at line 57  
- `seedset <- 777`  

**8_Correlations.Rmd**  
- Random seed set at line 62  
- `seedset <- 777`  
 
## Memory, Runtime, and Storage Requirements

- **Approximate time to reproduce analyses on a standard 2025 desktop machine:** 10–60 minutes.  
- **Storage requirements:**  
  - 2.26 GB for the repository  
  - 300 MB for intermediate data  

The code was last run on a 8-core Apple Silicon Mac (arm64 architecture) machine with macOS Sonoma 14.7.6 (Darwin 23.6.0) operating system and 161 GB free disk space.

To replicate the results of the paper, you will need to run the code on a machine with exactly 6 threads.

# Description of Code and Repository File Structure

Each of the folders in the root directory, except for Input_Data, have two folders: As_published and Testing. The Testing folders are all empty except for Compiled_Notebooks. The As_published folders contain the results from the published paper. It is recommended that you not edit the content of the As_published folders after cloning the repo; instead, you can use the Testing folders for implementing your replication or alternative specification(s), while preserving the original content for comparison in the As_published folder.

To replicate the results of this paper, clone the repository to your local computer. Then, set your working directory in RStudio to the root directory. To generate all results, run the master_script.r in Compiled_notebooks. 

If running the scripts individually, verify that the working directory is set to the root directory before running each script, then use the drop-down menu by "Knit" to select the "Current Working Directory" under "Knit Directory."

Scripts 1 - 3 process the data; script 4 runs the forests; and scripts 5 - 8 analyze the forest output, creating the tables and figures of the paper. The sequencing of scripts 1 - 4 is strict; however, scripts 5 - 8 can be run in any order after script 4 has generated the forest output.

Scripts 4a generate the tuned parameter values for honesty.fraction, sample.fraction, and min.node.size used in script 4. These scripts DO NOT need to be run for the replication; rather, they document the origin of these tuned parameter values.

The code pipeline is designed to be flexible to generate comprehensive results for any outcome-ranking pair. Each script contains two sections for parameters: "Non-run-specific parameters" includes seeds and other settings; "Run-specific parameters" are parameters you are likely to want to change if trying alternative specifications like outcome variables, ranking variables, and covariates. Other parameters in "run-specific parameters" assist in storing different runs of results, based on choices in script 3 in which penalty outcomes are created. 

 More results are generated than are included in the paper, so each script description below specifies which output corresponds to paper content.

 ## master_script.r

 * Description: Runs scripts 1-8 described below to generate all results of the paper.

## 1_Initial_Data_Cleaning.Rmd

* Description: Cleans the pre-processed data.
* Input: Pre-processed Stata data file `Input_Data/data_for_analysis.dta`
* Output file(s): Cleaned wide dataset `1_Cleaned_Wide_Dataset.csv` stored in (`Cleaned_Input_Data/Testing`) or (`Cleaned_Input_Data/As_Published`) depending on the flag 

**Non-run-specific Parameters:**

None

**Run-specific Parameters:**

| Parameter | Type | Format | Description |
|-----------|------|---------|-------------|
| published_paper_run | Binary (0/1) | Integer | Controls output paths |

**Data Cleaning Details**

This script:

- Drops observations with missing values for `age_inp` (n = 8517),  `treatment` (n = 0), and `edu_inp` (n = 11).
- Drops observations that are not a man or a woman  (`gender_inp` not equal to 0 or 1).
- Cleans the race variables (`race_white_inp`, `race_black_inp`, `race_nwother_inp`, `hispanic_inp`) by, first, dropping observations that have missing values for all race variables. For the remaining observations with at least one non-missing race value, replace missing values for all race variables with `0`.
- Creates the lessHS (`edu_inp == 1`) and HSorGED (`edu_inp == 2`) variables based on edu_inp.
- Creates the diagnosis index variable by summing all diagnosis variables (variables with the suffic `_dx_pre_lottery`), then normalizing to between 0 and 1.
- Converts all variable types to numeric. Then, converts numhh_list to factor.
- Renames variables.
- Creates negative versions of outcomes for which lower values are always better (e.g., the main outcome of interest in this paper: `debt`).

**Numbers Reported in Paper:**

- Difference in take-up between eligible and ineligible individuals reported at end of script.

## 2_Impute_Missing_Data.Rmd

* Description: Imputes missing covariates using MissRanger, then prints out summary statistics of processed dataset. 
* Input: Cleaned wide dataset `1_Cleaned_Wide_Dataset.csv` stored in (`Cleaned_Input_Data/Testing`) or (`Cleaned_Input_Data/As_Published`) depending on the flag
* Output file(s): Cleaned wide dataset `2_Imputed_Wide_Dataset.csv` stored in (`Cleaned_Input_Data/Testing`) or (`Cleaned_Input_Data/As_Published`) depending on the flag 

**Non-run-specific Parameters:**

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| seedset | 777 |Random seed |
| numthreadsset | min(6, cores) | Key parameter for reproducibility |

**Run-specific Parameters:**

| Parameter | Type | Format | Description |
|-----------|------|---------|-------------|
| published_paper_run | Binary (0/1) | Integer | Controls output paths |


#### 3_Create_New_Outcomes.Rmd

* Description: Creates and assigns the fold variable used for cross-validation; creates binary versions of the `charg_tot_pre_ed` and `ed_charg_tot_pre_ed` variables; and creates the penalty versions of the outcome variables as $Y_i - c^W W_i$ for a grid of costs $c^W$, where $W_i$ is the individual's treatment assignment.  
* Input: Cleaned wide dataset `2_Imputed_Wide_Dataset.csv` stored in (`Cleaned_Input_Data/Testing`) or (`Cleaned_Input_Data/As_Published`) depending on the flag 
* Output file(s): Penalized outcomes dataset: `3_Penalty_Outcomes_Wide_Dataset.csv` stored in `/Intermediate_data/Testing/cw_[cw_run_name]_[cw_grid]/` or `/Intermediate_data/As_Published/cw_[cw_run_name]_[cw_grid]/`depending on the flag 

**Non-run-specific Parameters:**

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| seedset | 777 | Seed for folds creation |
| nfolds | 10 | Number of cross-validation folds |

**Run-specific Parameters:**

| Parameter | Type | Format | Description |
|-----------|------|---------|-------------|
| published_paper_run | Binary (0/1) | Integer | Controls output paths |
| cw_run_name | String | Character | Name for penalty grid run, determines folder name with cw_grid |
| cw_grid | Integer | Integer | Number of grid points for penalty, determines number of cw values generated and folder name with cw_run_name |
| outcomes_list | List | list(list("outcome_name", max_cw_value)) | Format: `list(list("outcome_name", max_cw_value))` |

## 4_Run_Forests.Rmd

* Description: Estimates CATEs and CLATEs using tuned parameter values.
* Input: Penalized outcomes dataset: `3_Penalty_Outcomes_Wide_Dataset.csv` stored in `/Intermediate_data/Testing/cw_[cw_run_name]_[cw_grid]/` or `/Intermediate_data/As_Published/cw_[cw_run_name]_[cw_grid]/`depending on the flag 
*Output file(s):
  - Combined cate/clate estimates in csv: `cate_clate_results_[outcome].csv` → `/Intermediate_data/Testing/cw_[name]_[grid]/` or  `/Intermediate_data/As_published/cw_[name]_[grid]/` depending on the flag
  - CLATE forest object: `clate_results_[outcome].RData` → `/Intermediate_data/Testing/cw_[name]_[grid]/` or  `/Intermediate_data/As_published/cw_[name]_[grid]/` depending on the flag
  - CATE forest object: `cate_results_[outcome].RData` → `/Intermediate_data/Testing/cw_[name]_[grid]/` or  `/Intermediate_data/As_published/cw_[name]_[grid]/` depending on the flag
  - Combined forest object: `combined_results_[outcome].RData` → `/Intermediate_data/Testing/cw_[name]_[grid]/`or  `/Intermediate_data/As_published/cw_[name]_[grid]/` depending on the flag

**Non-run-specific Parameters:**

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| seedset | 777 | Not used |
| seed.ivforest | 123456789 | Seed for IV forest |
| seed.cf | 987654321 | Seed for causal forest |
| numthreadsset | min(6, cores) | Key parameter for reproducibility |

**Run-specific Parameters:**

| Parameter | Type | Format | Description |
|-----------|------|---------|-------------|
| published_paper_run | Binary (0/1) | Integer | Controls input/output paths |
| cw_run_name | String | Character | Name for penalty grid run, determines folder name with cw_grid |
| cw_grid | Integer | Integer | Number of grid points for penalty, determines folder name with cw_run_name |
| outcomes_list | Vector | list("outcome_name_cw0") | Names of outcomes for forests |
| covariates_list | Vector | Character vector | Names of covariates for forests |
| coverage_parameters | List | Named list | Tuning parameters for coverage outcomes |
| outcome_cate_parameters | List | Named list | Tuning parameters for cate outcomes |
| outcome_clate_parameters | List | Named list | Tuning parameters for clate outcomes |

**Functions:**
- `calculate_cate()`: Estimates CATE using causal forest
- `calculate_clate()`: Estimates CLATE using instrumental forest

## 4a_Tune_ohp.Rmd - DOES NOT NEED TO BE RUN FOR REPLICATION

* Description: Estimates CATE for coverage outcome, tuning all parameters.
* Input: Penalized outcomes dataset: `3_Penalty_Outcomes_Wide_Dataset.csv` stored in `/Intermediate_data/Testing/cw_[cw_run_name]_[cw_grid]/` or `/Intermediate_data/As_Published/cw_[cw_run_name]_[cw_grid]/` depending on the flag
* Output file(s):
  - CLATE tuning results: `clate_tuning_results_[outcome].RData` → `/Intermediate_data/Testing/cw_[name]_[grid]/` or  `/Intermediate_data/As_published/cw_[name]_[grid]/` depending on the flag
  - CATE tuning results: `cate_tuning_results_[outcome].RData` → `/Intermediate_data/Testing/cw_[name]_[grid]/` or  `/Intermediate_data/As_published/cw_[name]_[grid]/` depending on the flag
  - Combined results: `cate_clate_tuning_results_[outcome].csv` → `/Intermediate_data/Testing/cw_[name]_[grid]/` or  `/Intermediate_data/As_published/cw_[name]_[grid]/` depending on the flag
  - Tuned parameters: `tuned_parameters_[outcome].csv` → `/Intermediate_data/Testing/cw_[name]_[grid]/` or  `/Intermediate_data/As_published/cw_[name]_[grid]/` depending on the flag


**Non-run-specific Parameters:**

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| seedset | 777 | Not used |
| seed.ivforest | 123456789 | Seed for IV forest |
| seed.cf | 987654321 | Seed for causal forest |
| numthreadsset | min(6, cores) | Key parameter for reproducibility |

**Run-specific Parameters:**

| Parameter | Type | Format | Description |
|-----------|------|---------|-------------|
| published_paper_run | Binary (0/1) | Integer | Controls input/output paths |
| cw_run_name | String | Character | Name for penalty grid run, determines folder name with cw_grid |
| cw_grid | Integer | Integer | Number of grid points for penalty, determines folder name with cw_run_name |
| outcomes_list | Vector | list("ohp_all_ever_inperson_cw0") | Names of outcomes for forests |
| covariates_list | Vector | Character vector | Names of covariates for forests |

**Key Functions:**
- `calculate_cate()`: Estimates CATE using causal forest
- `calculate_clate()`: Estimates CLATE using instrumental forest

## 4a_Tune_debt.Rmd - DOES NOT NEED TO BE RUN FOR REPLICATION

* Description: Estimates CATE and CLATE for debt_neg outcome, tuning all parameters. 
* Input: Penalized outcomes dataset: `3_Penalty_Outcomes_Wide_Dataset.csv` stored in `/Intermediate_data/Testing/cw_[cw_run_name]_[cw_grid]/` or `/Intermediate_data/As_Published/cw_[cw_run_name]_[cw_grid]/` depending on the flag
* Output file(s):
  - CLATE tuning results: `clate_tuning_results_[outcome].RData` → `/Intermediate_data/Testing/cw_[name]_[grid]/` or  `/Intermediate_data/As_published/cw_[name]_[grid]/` depending on the flag
  - CATE tuning results: `cate_tuning_results_[outcome].RData` → `/Intermediate_data/Testing/cw_[name]_[grid]/` or  `/Intermediate_data/As_published/cw_[name]_[grid]/` depending on the flag
  - Combined results: `cate_clate_tuning_results_[outcome].csv` → `/Intermediate_data/Testing/cw_[name]_[grid]/` or  `/Intermediate_data/As_published/cw_[name]_[grid]/` depending on the flag
  - Tuned parameters: `tuned_parameters_[outcome].csv` → `/Intermediate_data/Testing/cw_[name]_[grid]/ `or  `/Intermediate_data/As_published/cw_[name]_[grid]/` depending on the flag


**Non-run-specific Parameters:**

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| seedset | 777 | Not used |
| seed.ivforest | 123456789 | Seed for IV forest |
| seed.cf | 987654321 | Seed for causal forest |
| numthreadsset | min(6, cores) | Key parameter for reproducibility |

**Run-specific Parameters:**

| Parameter | Type | Format | Description |
|-----------|------|---------|-------------|
| published_paper_run | Binary (0/1) | Integer | Controls input/output paths |
| cw_run_name | String | Character | Name for penalty grid run, determines folder name with cw_grid |
| cw_grid | Integer | Integer | Number of grid points for penalty, determines folder name with cw_run_name |
| outcomes_list | Vector | list("debt_neg_cw0") | Names of outcomes for forests |
| covariates_list | Vector | Character vector | Names of covariates for forests |

**Key Functions:**
- `calculate_cate()`: Estimates CATE using causal forest
- `calculate_clate()`: Estimates CLATE using instrumental forest

## 5_CDFs.Rmd

* Description: Creates cumulative distribution function plots. 
* Input: Treatment effect estimates: `cate_clate_results_[outcome].csv` stored in `/Intermediate_data/Testing/cw_[cw_run_name]_[cw_grid]/` or `/Intermediate_data/As_Published/cw_[cw_run_name]_[cw_grid]/` depending on the flag 
* Output file(s): CDF plots: `cdf_[outcome_var]_[ranking_var]_[type].[png|pdf]` → `/Saved_tables_figures/[Testing|As_Published]/cw_[name]_[grid]/`

Also outputs individual increasing and decreasing CDFs.

**Non-run-specific Parameters:**

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| seedset | 777 | Not used |
| numthreadsset | min(6, cores) | Key parameter for reproducibility |

**Run-specific Parameters:**

| Parameter | Type | Format | Description |
|-----------|------|---------|-------------|
| published_paper_run | Binary (0/1) | Integer | Controls input/output paths |
| simulation_run | Binary (0/1) | Integer | Controls input/output paths |
| cw_run_name | String | Character | Name for penalty grid run, determines folder name with cw_grid |
| cw_grid | Integer | Integer | Number of grid points, determines folder name with cw_run_name |
| covariates_list | Vector | Character vector | Names of covariates for regressions |
| cate_outcome_rankvar_pairs | List | list(list("outcome_var", "ranking_var")) | Outcome-ranking variable pairs for CATE |
| clate_outcome_rankvar_pairs | List | list(list("outcome_var", "ranking_var")) | Outcome-ranking variable pairs for CLATE |

**Key Functions:**
- `create_cumulative_clate_plot(outcome_var, ranking_var, cdf_dataframe, decreasing=FALSE)`: Creates cumulative distribution function (CDF) plots for the CLATE analysis. It estimates the treatment effect for specified percentiles and generates plots with confidence intervals.
  
- `create_cumulative_cate_plot(outcome_var, ranking_var, cdf_dataframe, decreasing=FALSE)`: Similar to the CLATE function, but for the CATE analysis. It processes the data to create CDF plots for the CATE estimates.

- `create_cumulative_outcome_plots(outcome, ranking_v, type)`: This function orchestrates the creation of CDF plots by calling either `create_cumulative_clate_plot` or `create_cumulative_cate_plot` based on the specified type. It handles the data preparation by calling read_treatment_effect_datasets.

- `read_treatment_effect_datasets(outcome, ranking_v)`: Reads the necessary datasets for the specified outcome and ranking variable. It merges the outcome data with the selected ranking data to prepare for CDF analysis.

**Numbers Reported in Paper:**

- LATE for bottom 30% vs. top 70%.

#### 6_TOCs.Rmd

* Description: Generates TOC curves and estimates AUTOC. 
* Input: Treatment effect estimates: `cate_clate_results_[outcome].csv` stored in `/Intermediate_data/Testing/cw_[cw_run_name]_[cw_grid]/` or `/Intermediate_data/As_Published/cw_[cw_run_name]_[cw_grid]/` depending on the flag 
* Output file(s): 
    * TOC plots: `[AUTOC|QINI]_toc_[type]_[outcome].[png|pdf]` → `/Saved_tables_figures/[Testing|As_Published]/cw_[name]_[grid]/`

**Non-run-specific Parameters:**

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| seedset | 777 | Not used |
| numthreadsset | min(6, cores) | Key parameter for reproducibility |

**Run-specific Parameters:**

| Parameter | Type | Format | Description |
|-----------|------|---------|-------------|
| published_paper_run | Binary (0/1) | Integer | Controls output paths |
| cw_run_name | String | Character | Name for penalty grid run |
| cw_grid | Integer | Integer | Number of grid points |
| forest_files | Vector | c("cate/clate_results_[outcome].RData") | Outcomes to analyze |
| qini | Binary (0/1) | Integer | Controls whether to generate QINI or AUTOC metrics|

**Key Functions:**
- `compute_alternative_toc_clate(outcome_file_name, forest_input, type_input)`: Generates results for outcome CLATE x outcome CLATE
- `compute_alternative_toc_cate(outcome_file_name, forest_input, type_input)`:  Generates results for outcome CATE x outcome CATE
- `compute_alternative_toc_clate_coverage_cate(outcome_file_name, forest_input, type_input)`: Generates results for outcome CLATE x coverage CATE
- `compute_alternative_toc_cate_coverage_cate(outcome_file_name, forest_input, type_input)`: Generates results for outcome CATE x coverage CATE

**Paper Figures Produced:**
- **Figure 1**: AUTOC_toc_cate_ohp_all_ever_inperson_cw0.png
- **Figure 2**: AUTOC_toc_clate_debt_neg_cw0.png
- **Figure 3**: AUTOC_toc_coverage_clate_debt_neg_cw0.png
- **Figure 4**: AUTOC_toc_cate_debt_neg_cw0.png
- **Figure 5**: AUTOC_toc_coverage_cate_debt_neg_cw0.png
- **Figure 6a**: AUTOC_toc_coverage_cate_debt_neg_cw1.png
- **Figure 6b**: AUTOC_toc_coverage_cate_debt_neg_cw2.png
- **Figure 6c**: AUTOC_toc_coverage_cate_debt_neg_cw3.png
- **Figure 6d**: AUTOC_toc_coverage_cate_debt_neg_cw4.png

#### 7_Quintile_Plots.Rmd

* Description: Creates quintile plots.
* Input: Treatment effect estimates: `cate_clate_results_[outcome].csv` stored in `/Intermediate_data/Testing/cw_[cw_run_name]_[cw_grid]/` or `/Intermediate_data/As_Published/cw_[cw_run_name]_[cw_grid]/` depending on the flag 
*Output file(s): 
    - Quintile plots: `Q_[type]_[outcome var]_[ranking_var].[png|pdf]` → `/Saved_tables_figures/[Testing|As_Published]/cw_[name]_[grid]/`

**Non-run-specific Parameters:**

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| seedset | 777 | Not used |
| seed.ivforest | 123456789 | Seed for IV forest |
| seed.cf | 987654321 | Seed for causal forest |
| numthreadsset | min(6, cores) | Key parameter for reproducibility |

**Run-specific Parameters:**

| Parameter | Type | Format | Description |
|-----------|------|---------|-------------|
| published_paper_run | Binary (0/1) | Integer | Controls output paths |
| cw_run_name | String | Character | Name for penalty grid run |
| cw_grid | Integer | Integer | Number of grid points |
| covariates_list | Vector | Character vector | Names of covariates for regressions |
| cate_outcome_rankvar_pairs | List | list(list("outcome_var", "ranking_var")) | Outcome-ranking variable pairs for CATE |
| clate_outcome_rankvar_pairs | List | list(list("outcome_var", "ranking_var")) | Outcome-ranking variable pairs for CLATE |

**Key Functions:**
- `create_quintile_plot(outcome_var, ranking_var, type)`: Creates quintile plots for the specified outcome and ranking variable based on cate/clate type.

- `create_quintile_clate_plot(outcome_var, ranking_var, cdf_dataframe)`: Prepares data for CLATE quintile plots. 

- `create_quintile_cate_plot(outcome_var, ranking_var, cdf_dataframe)`: Prepares data for CATE quintile plots. 

- `create_quintile_outcome_plots(outcome, ranking_v, type)`: This function orchestrates the creation of both CATE and CLATE quintile plots by calling the respective functions based on the specified type. It handles the data preparation with the read_treatment_effect_datasets function.

- `read_treatment_effect_datasets(outcome, ranking_v)`: Reads the necessary datasets for the specified outcome and ranking variable. It merges the outcome data with the selected ranking data to prepare for quintile analysis.

#### 8_Correlations.Rmd

* Description: Calculates correlations between rankings.  
* Input: Treatment effect estimates: `cate_clate_results_[outcome].csv` stored in `/Intermediate_data/Testing/cw_[cw_run_name]_[cw_grid]/` or `/Intermediate_data/As_Published/cw_[cw_run_name]_[cw_grid]/` depending on the flag 
* Output:
  - Correlation tables: `[correlations_run_name]_combined_correlations.csv` → `/Saved_tables_figures/[Testing|As_Published]/cw_[name]_[grid]/`
  - Correlation plots: `[correlations_run_name]_combined_correlations.[png|pdf]` → `/Saved_tables_figures/[Testing|As_Published]/cw_[name]_[grid]/`

**Non-run-specific Parameters:**

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| seedset | 777 | Not used |
| seed.ivforest | 123456789 | Seed for IV forest |
| seed.cf | 987654321 | Seed for causal forest |
| numthreadsset | min(6, cores) | Key parameter for reproducibility |

**Run-specific Parameters:**

| Parameter | Type | Format | Description |
|-----------|------|---------|-------------|
| published_paper_run | Binary (0/1) | Integer | Controls output paths |
| cw_run_name | String | Character | Name for penalty grid run, determines folder name with cw_grid |
| cw_grid | Integer | Integer | Number of grid points, determines folder name with cw_run_name |
| correlations_run_name | String | Character | Name for correlation output, ***change this each run*** |
| outcomes_list | Vector | list("outcome_var_cw0_lambda0") | Outcomes to correlate |
| spearman | Binary (0/1) | Integer | Set to 1 for Spearman's correlation, 0 for ranking_20 variables

**Key Functions:**
- `create_heatmap(correlations, standard_errors, title)`: Creates a heatmap of the correlations between the specified outcomes.

**Numbers Reported in Paper:**

The `spear_correlations_published_paper.csv` shows reported numbers in the paper for:

- Correlation between coverage CATE and outcome CLATE.
- Correlation between coverage CATE and outcome CATE.
- Correlations between coverage CATE and penalized outcome CATEs.

