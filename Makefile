NAME := Memoria
SOURCE := $(NAME).org
TARGET := $(NAME).pdf
TEX := $(NAME).tex
GLOSSARY := glosario.sty
CONFIG := ~/.emacs

OPTS := -shell-escape

.PHONY: all clean noclean
all: clean $(TARGET)
	@$(MAKE) clean

noclean: clean $(TARGET)
	@

$(TARGET): $(TEX) $(GLOSSARY)
	pdflatex $(OPTS) $(TEX)
	makeglossaries $(NAME)
	bibtex $(NAME)
	dot -Tpdf -o colab.pdf colab.dot
	pdflatex $(OPTS) $(TEX)
	pdflatex $(OPTS) $(TEX)

$(TEX): $(SOURCE) $(CONFIG)
	emacs -batch \
		-load $(CONFIG) \
		--visit=$(SOURCE) \
		-f org-latex-export-to-latex

clean:
	rm -f Memoria.tex
	rm -f Memoria.{bbl,blg,aux,log,toc,out,alg,ist}
	rm -f Memoria.{gls,glo,glg,acr,acn}
	rm -f Memoria.{lof,lot}
	rm -f colab.pdf colab.dot
	rm -rf svg-inkscape
