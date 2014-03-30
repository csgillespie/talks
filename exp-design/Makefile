## $* = filename without extension
## $@ = the output file
## $< = the input file

.SUFFIXES: .tex .pdf .Rnw .R

MAIN = lecture


$(MAIN).pdf:  $(MAIN).tex graphics/*.pdf
	pdflatex $*.tex

view: $(MAIN).pdf
	evince $(MAIN).pdf &

clean:
	rm -fv $(TEX) $(RFILES)
	rubber --clean --pdf $(MAIN)
	rm -fv *~ \#*\' *.dvi
	rm -fv Rplots.pdf *.RData

cleaner:
	make clean
	rm -fvr auto/
#	rm -fv ../graphics/*.pdf
