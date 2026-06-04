# =============================================================
# analysis.R
# Replication: Athey, Inoue, Tsugawa (2025)
# Reads from temp/, produces table and figure to output/
# =============================================================

library(readr)
library(dplyr)
library(grf)

# -------------------------
# Load cleaned data
# -------------------------
c_d_imputed <- read_csv("temp/cleaned_data.csv", show_col_types = FALSE)

# -------------------------
# Define Y, W, Z
# -------------------------
Y <- c_d_imputed$debt_neg
W <- c_d_imputed$ohp_all_ever_inperson
Z <- c_d_imputed$eligibility

# -------------------------
# Define X — paper-specified
# covariates (Supplemental Appendix A.5)
# -------------------------
X <- c_d_imputed %>%
  select(
    age_inp, gender_inp,
    hispanic_inp, race_white_inp, race_black_inp, race_nwother_inp,
    lessHS, HSorGED,
    hypertension, diabetes, highcholesterol,
    ast_dx_pre_lottery, ami_dx_pre_lottery, chf_dx_pre_lottery,
    emp_dx_pre_lottery, kid_dx_pre_lottery, cancer_dx_pre_lottery,
    depression,
    charg_tot_pre_ed, ed_charg_tot_pre_ed,
    num_visit_pre_cens_ed, any_depres_pre_ed,
    numhh_list
  ) %>%
  as.matrix()

cat("N:", length(Y), "\n")
cat("Cols in X:", ncol(X), "\n")

# =========================================================
# Equation (1): CLATE via instrumental forest
# tau_CL(x) = tau_Y(x) / tau_W(x)
# =========================================================
set.seed(123)
clate_forest <- instrumental_forest(
  X = X, Y = Y, W = W, Z = Z,
  num.trees = 2000,
  honesty  = TRUE,
  seed     = 123
)
tau_CL_hat <- predict(clate_forest)$predictions

# =========================================================
# Figure F1: Compliance forest + TOC
# =========================================================
set.seed(123)
compliance_forest <- causal_forest(
  X = X, Y = W, W = Z,
  num.trees = 2000,
  honesty  = TRUE,
  seed     = 123
)
tau_W_hat <- predict(compliance_forest)$predictions

rate_compliance <- rank_average_treatment_effect(
  compliance_forest,
  priorities = tau_W_hat
)

autoc_est <- rate_compliance$estimate
autoc_se  <- rate_compliance$std.err

ci_lo <- autoc_est - 1.96 * autoc_se
ci_hi <- autoc_est + 1.96 * autoc_se

# =========================================================
# Console summary
# =========================================================
cat("\nReplication Results\n")
cat("==================\n")
cat("Paper reports:  AUTOC = 0.0412 (SE 0.0068)\n")
cat("We obtain:      AUTOC =", round(autoc_est, 4),
    "(SE", round(autoc_se, 4), ")\n")
cat("Difference:    ", round(autoc_est - 0.0412, 4), "\n\n")
cat("Mean CLATE:    ", round(mean(tau_CL_hat), 4), "\n")
cat("SD CLATE:      ", round(sd(tau_CL_hat), 4), "\n")

# =========================================================
# Save Figure F1 to output/figures/
# =========================================================
png("output/figures/figure_f1.png", width = 700, height = 500, res = 100)
plot(
  rate_compliance,
  main = "Figure F1: Targeting Operator Characteristic Curve for Compliance",
  xlab = "Treated fraction (q)",
  ylab = "Targeting Operator Characteristic"
)
dev.off()
cat("Saved output/figures/figure_f1.png\n")

# =========================================================
# Save AUTOC table to output/tables/
# =========================================================
latex_table <- sprintf(
'\\begin{table}[h]
\\centering
\\caption{Replication of Figure F1 AUTOC from Athey, Inoue, and Tsugawa (2025)}
\\begin{tabular}{lcc}
\\toprule
 & Replicated & Paper \\\\
\\midrule
AUTOC & $%.4f$ & $0.0412$ \\\\
Standard Error & $(%.4f)$ & $(0.0068)$ \\\\
95\\%% CI & $[%.4f,\\ %.4f]$ & $[0.0279,\\ 0.0545]$ \\\\
Mean CLATE & $%.4f$ & $\\approx 0.15$ \\\\
N & \\multicolumn{2}{c}{12,208} \\\\
\\bottomrule
\\end{tabular}
\\label{tab:main}
\\end{table}',
  autoc_est, autoc_se, ci_lo, ci_hi, mean(tau_CL_hat)
)

writeLines(latex_table, "output/tables/main_result.tex")
cat("Saved output/tables/main_result.tex\n")

# =========================================================
# Save macros file so paper.tex can read numbers directly
# =========================================================
macros <- sprintf(
'\\newcommand{\\autoc}{%.4f}
\\newcommand{\\autocse}{%.4f}
\\newcommand{\\meanclate}{%.4f}
\\newcommand{\\sdclate}{%.4f}
\\newcommand{\\autoclate}{%.4f}',
  autoc_est, autoc_se, mean(tau_CL_hat), sd(tau_CL_hat),
  autoc_est - 0.0412
)
writeLines(macros, "output/tables/macros.tex")
cat("Saved output/tables/macros.tex\n")
