#!/bin/bash

ref=main
browse=firefox

# when in doubt, throw hammers...
(
    pdflatex -synctex=1 -interaction=nonstopmode $ref.tex
    bibtex $ref.aux
    bibtex $ref.aux
    pdflatex -synctex=1 -interaction=nonstopmode $ref.tex
    pdflatex -synctex=1 -interaction=nonstopmode $ref.tex

) && $browse $ref.pdf


#ps aux \
# | grep -P "^(pdf|chrom|fire)"\
# | awk -F '\t' '{print $2"\t"$NF}'\
# | sed 's/chrom/fire/'\
# 2> /dev/null > /tmp/out \
# && cat /tmp/out\
#     | cut -f 2\
#     | 
 
