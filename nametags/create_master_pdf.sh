#!/bin/bash

COUNTER=0

HEADSTART=1
HEADEND=28
TAILSTART=0
TAILEND=0

while read p; do 
        FIRSTNAME=`echo $p | awk 'BEGIN {FS=","} {print $1}'`;
        LASTNAME=`echo $p | awk 'BEGIN {FS=","} {print $2}'`;
        AFFILIATION=`echo $p | awk 'BEGIN {FS=","} {print $3}'`;


        sed -n '1,28 p' a7-60.tex > badge$COUNTER.tex
        echo "\\Large\\textbf{$FIRSTNAME $LASTNAME} \\\\
\\large\\textit{$AFFILIATION}" >> badge$COUNTER.tex
        sed -n '31,40 p' a7-60.tex >> badge$COUNTER.tex

        pdflatex badge$COUNTER.tex
        #> badge$COUNT.tex

        COUNTER=`echo $COUNTER +1 | bc`
done < data.csv

pdftk badge*.pdf cat output masterbadge.pdf
