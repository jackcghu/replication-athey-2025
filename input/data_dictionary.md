# Data Dictionary

All variables used in the replication analysis. Source: Oregon Health Insurance Experiment (OHIE), Finkelstein et al. (2018).

| Variable | Description | Units | Source |
|----------|-------------|-------|--------|
| debt_neg | Binary outcome: 1 if individual reports no medical debt | Binary (0/1) | OHIE in-person survey |
| ohp_all_ever_inperson | Treatment: 1 if individual enrolled in Medicaid | Binary (0/1) | OHIE administrative records |
| eligibility | Instrument: 1 if individual won Medicaid lottery | Binary (0/1) | OHIE lottery records |
| age_inp | Age at time of in-person interview | Years | OHIE in-person survey |
| gender_inp | Gender of respondent | Binary (0/1) | OHIE in-person survey |
| hispanic_inp | 1 if Hispanic ethnicity | Binary (0/1) | OHIE in-person survey |
| race_white_inp | 1 if non-Hispanic White | Binary (0/1) | OHIE in-person survey |
| race_black_inp | 1 if non-Hispanic Black | Binary (0/1) | OHIE in-person survey |
| race_nwother_inp | 1 if other race/ethnicity | Binary (0/1) | OHIE in-person survey |
| lessHS | 1 if education less than high school | Binary (0/1) | OHIE in-person survey |
| HSorGED | 1 if education is high school diploma or GED | Binary (0/1) | OHIE in-person survey |
| hypertension | 1 if diagnosed with hypertension pre-lottery | Binary (0/1) | OHIE in-person survey |
| diabetes | 1 if diagnosed with diabetes pre-lottery | Binary (0/1) | OHIE in-person survey |
| highcholesterol | 1 if diagnosed with high cholesterol pre-lottery | Binary (0/1) | OHIE in-person survey |
| ast_dx_pre_lottery | 1 if diagnosed with asthma pre-lottery | Binary (0/1) | OHIE in-person survey |
| ami_dx_pre_lottery | 1 if diagnosed with heart attack pre-lottery | Binary (0/1) | OHIE in-person survey |
| chf_dx_pre_lottery | 1 if diagnosed with congestive heart failure pre-lottery | Binary (0/1) | OHIE in-person survey |
| emp_dx_pre_lottery | 1 if diagnosed with emphysema/COPD pre-lottery | Binary (0/1) | OHIE in-person survey |
| kid_dx_pre_lottery | 1 if diagnosed with kidney failure pre-lottery | Binary (0/1) | OHIE in-person survey |
| cancer_dx_pre_lottery | 1 if diagnosed with cancer pre-lottery | Binary (0/1) | OHIE in-person survey |
| depression | 1 if diagnosed with depression pre-lottery | Binary (0/1) | OHIE in-person survey |
| charg_tot_pre_ed | Total ED charges pre-lottery | USD | OHIE administrative records |
| ed_charg_tot_pre_ed | ED-specific charges pre-lottery | USD | OHIE administrative records |
| num_visit_pre_cens_ed | Number of ED visits pre-lottery | Count | OHIE administrative records |
| any_depres_pre_ed | 1 if any ED visit for depression pre-lottery | Binary (0/1) | OHIE administrative records |
| numhh_list | Household size at lottery entry | Count (1/2/3) | OHIE lottery records |
