.PHONY: all clean

all: paper/paper.pdf

# Step 1: Preprocessing
temp/cleaned_data.csv: input/1_Cleaned_wide_Dataset.csv code/preprocess.R
	mkdir -p temp
	Rscript code/preprocess.R

# Step 2: Analysis — produces table and figure
output/tables/main_result.tex output/tables/macros.tex output/figures/figure_f1.png: temp/cleaned_data.csv code/analysis.R
	Rscript code/analysis.R

# Step 3: Compile paper
paper/paper.pdf: paper/paper.tex output/tables/main_result.tex output/figures/figure_f1.png
	cd paper && pdflatex paper.tex && pdflatex paper.tex

clean:
	rm -f temp/cleaned_data.csv
	rm -f output/tables/main_result.tex
	rm -f output/figures/figure_f1.png
	rm -f paper/paper.pdf paper/paper.aux paper/paper.log
