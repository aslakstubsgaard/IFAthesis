# Name of manuscript
manuscript = thesis

# Source files
sources = $(wildcard *.tex) references.bib ifathesis.cls

# PdfLaTeX compilation options
latexopt = -halt-on-error -file-line-error

#=================================================================
# Generate PDF of manuscript using PdfLaTeX
#=================================================================

.PHONY: all
all: $(manuscript).pdf
$(manuscript).pdf: $(sources)
	pdflatex $(latexopt) $(manuscript).tex
	notify-send compiled

.PHONY: full
full: $(manuscriptFULL).pdf

$(manuscriptFULL).pdf: $(sources)
	pdflatex $(latexopt) $(manuscript).tex
	bibtex -terse $(manuscript).aux
	pdflatex $(latexopt) $(manuscript).tex
	pdflatex $(latexopt) $(manuscript).tex
	notify-send compiled

#=================================================================
# Clean
#=================================================================

.PHONY: clean
clean:
	@rm -f *.aux *.bbl *.blg *.log *.out *.spl *.lof *.lot *.toc \
	$(manuscript).pdf
