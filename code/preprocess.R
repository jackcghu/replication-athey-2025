# =============================================================
# preprocess.R
# Replication: Athey, Inoue, Tsugawa (2025)
# Reads raw data from input/, cleans, imputes, writes to temp/
# =============================================================

library(readr)
library(dplyr)
library(missRanger)

# -------------------------
# Load raw data
# -------------------------
c_d <- read_csv("input/1_Cleaned_wide_Dataset.csv", show_col_types = FALSE)

# -------------------------
# Basic cleaning
# -------------------------
c_d <- c_d %>%
  select(-matches("^\\.\\.\\.|^X$|^Unnamed")) %>%
  distinct()

cat("Raw N:", nrow(c_d), "\n")

# -------------------------
# Impute missing data
# (paper: missRanger, Supplemental Appendix A.5)
# -------------------------
set.seed(123)
c_d_imputed <- missRanger(c_d, num.trees = 100, seed = 123, verbose = 0)

cat("Imputed N:", nrow(c_d_imputed), "\n")

# -------------------------
# Check key variables exist
# -------------------------
stopifnot("debt_neg" %in% names(c_d_imputed))
stopifnot("ohp_all_ever_inperson" %in% names(c_d_imputed))
stopifnot("eligibility" %in% names(c_d_imputed))

# -------------------------
# Summary statistics
# -------------------------
cat("\n=== Summary Statistics ===\n")
cat("N observations:        ", nrow(c_d_imputed), "\n")
cat("Mean debt_neg (Y):     ", round(mean(c_d_imputed$debt_neg, na.rm=TRUE), 4), "\n")
cat("Mean enrollment (W):   ", round(mean(c_d_imputed$ohp_all_ever_inperson, na.rm=TRUE), 4), "\n")
cat("Mean eligibility (Z):  ", round(mean(c_d_imputed$eligibility, na.rm=TRUE), 4), "\n")

# -------------------------
# Save to temp/
# -------------------------
write_csv(c_d_imputed, "temp/cleaned_data.csv")
cat("\nSaved to temp/cleaned_data.csv\n")
