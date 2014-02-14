.SUFFIXES: .tex .pdf .Rnw .R

MAIN = talk

$(MAIN).pdf: *.Rnw

R: $(RFILES)

view: $(MAIN).pdf
	evince $(MAIN).pdf &

.Rnw.R:
	R CMD Stangle $<

.Rnw.pdf:
	Rscript -e "require(knitr); knit('$*.Rnw') "
	pdflatex $*.tex; pdflatex $*.tex;

clean:
	rm -fv $(MAIN).pdf $(MAIN).tex
	rm -fv *.aux *.dvi *.log *.toc *.bak *~ *.blg *.bbl *.lot *.lof
	rm -fv  *.nav *.snm *.out *.pyc \#*\# _region_* _tmp.* *.vrb
	rm -fv Rplots.pdf example.RData d.csv.gz mygraph.*
	rm -fvr knitr_* knitr.sty .Rhistory

cleaner:
	make clean
	rm -fvr auto/ 

