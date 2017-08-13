#!/bin/bash

dfmt=`date +%Y_%m_%d`

zip bmcbio_ovas_paper_${dfmt}.zip\
    bmc_article.tex\
    fig{1,2,3,4}.png\
    bibliography.bib\
    spbasic.bst\
    bmcart.cls\
    bmcart-biblio.sty\
    "Reference PDF".pdf\
    Response-to-Reviewers.docx\
    manuscript_with_highlighted_changes.pdf
