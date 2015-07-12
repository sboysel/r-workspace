# target1 target2: dep1 dep2 dep3
# 	cmd1
# 	cmd2
# 	...

# Variables
R_SCR=/usr/bin/Rscript

# Targets
all: data_final.Rdata

raw_data.csv:
	$(R_SCR) 01-getdata.R

cleaned_data.Rdata: raw_data.csv
	$(R_SCR) 02-cleandata.R

final_data.Rdata: cleaned_data.Rdata
	$(R_SCR) 03-analysis.R

fig1.pdf fig2.pdf: final_data.Rdata
	$(R_SCR) 04-figures.R

clean:
	rm raw_data.csv cleaned_data.Rdata
