# /bin/bash

shopt -s extglob
latexmk -pdf
rm -v !(*.tex|*.sh|*.pdf)
xdg-open *.pdf