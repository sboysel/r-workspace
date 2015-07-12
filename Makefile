# target1 target2: dep1 dep2 dep3
# 	cmd1
# 	cmd2
# 	...

# Variables
R_SCR = /usr/bin/Rscript
PROJ_NAME = myProject
PROJ_FILES = README.md Makefile data/ figures/ R/ tests/

# Targets
all: data_final.Rdata

data/raw_data.csv:
	$(R_SCR) 01-getdata.R

data/cleaned_data.Rdata: raw_data.csv
	$(R_SCR) 02-cleandata.R

data/final_data.Rdata: cleaned_data.Rdata
	$(R_SCR) 03-analysis.R

figures/fig1.pdf figures/fig2.pdf: final_data.Rdata
	$(R_SCR) 04-figures.R

tar:
	tar cfv $(PROJ_NAME) $(PROJ_FILES)

clean:
	rm raw_data.csv cleaned_data.Rdata
