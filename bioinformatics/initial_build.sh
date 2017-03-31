#!/bin/bash

ref=main
browse=firefox

(
    pdflatex -synctex=1 -interaction=nonstopmode $ref.tex
    bibtex $ref.aux
    bibtex $ref.aux
    pdflatex -synctex=1 -interaction=nonstopmode $ref.tex
    pdflatex -synctex=1 -interaction=nonstopmode $ref.tex

) && $browse $ref.pdf
