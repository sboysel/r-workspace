## Makefile for knitr document ##
# http://www.jonzelner.net/make/latex/knitr/2015/06/19/make-watchman/
# https://drewsilcock.co.uk/using-make-and-latexmk/
# https://github.com/facebook/watchman/issues/184

## Main Options
R=/usr/bin/Rscript
MAIN := $(shell pwd)/docs/sample
KNITRFILE := $(MAIN).Rnw
TEXFILE := $(MAIN).tex
PDFFILE := $(MAIN).pdf

## latexmk Options
LATEX=pdflatex
LATEXOPT=--shell-escape
NONSTOP=--interaction=nonstopmode
LATEXMK=latexmk
LATEXMKOPT=-pdf -output-directory=$(shell pwd)/docs 

## watchman Options
WATCHMAN=/usr/local/bin/watchman

## Run
all: tex pdf

tex : $(KNITRFILE)
	$(info ************  CONVERTING KNITR TO TEX  ************)
	$(R) -e "require(knitr); knit(input = '$(KNITRFILE)', output = '$(TEXFILE)')"

pdf : $(TEXFILE)
	$(info ************  COMPILING PDF  ************)
	$(LATEXMK) $(LATEXMKOPT) \
   		-pdflatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(TEXFILE)

watch:
	$(info ************  WATCHING FOR CHANGES  ************)
	$(WATCHMAN) watch $(shell pwd)
	$(WATCHMAN) -- trigger $(shell pwd) remake 'docs/*.Rnw' -- python $(shell pwd)/make.py

unwatch:
	$(info ************  CANCELLING WATCH  ************)
	$(WATCHMAN) watch-del $(shell pwd)

clean:
	$(LATEXMK) -C $(MAIN)
	rm -f docs/$(MAIN).pdfsync
	rm -rf docs/{*~,*.tmp}
	rm -f docs/{*.bbl,*.blg,*.aux,*.end,*.fls,*.log,*.out,*.fdb_latexmk,*tikzDictionary}

# # Variables
# R_SCR = /usr/bin/Rscript
# PROJ_NAME = myProject
# PROJ_FILES = README.md Makefile data/ figures/ R/ tests/

# # Targets
# all: data_final.Rdata

# data/raw_data.csv:
# 	$(R_SCR) 01-getdata.R

# data/cleaned_data.Rdata: raw_data.csv
# 	$(R_SCR) 02-cleandata.R

# data/final_data.Rdata: cleaned_data.Rdata
# 	$(R_SCR) 03-analysis.R

# figures/fig1.pdf figures/fig2.pdf: final_data.Rdata
# 	$(R_SCR) 04-figures.R

# tar:
# 	tar cfv $(PROJ_NAME) $(PROJ_FILES)

# clean:
# 	rm raw_data.csv cleaned_data.Rdata
