@echo off
setlocal

if not exist "output" mkdir output

echo Construyendo archivos .md y .tex a partir de yaml...
python build_cv.py

echo Compilando Espanol...
:: Pandoc
pandoc build\es\CV_Sebastian_Mesch_Henriques.md -H assets\disable_hyphens.tex -V geometry:margin=1in -o output\CV_Sebastian_Mesch_Henriques_ES_Pandoc.pdf

:: LaTeX
cd build\es
pdflatex -interaction=nonstopmode -output-directory=../../output CV_Sebastian_Mesch_Henriques.tex
pdflatex -interaction=nonstopmode -output-directory=../../output Cover_Letter_Sebastian_Mesch.tex
cd ..\..

echo Compilando Ingles...
:: Pandoc
pandoc build\en\CV_Sebastian_Mesch_Henriques_EN.md -H assets\disable_hyphens.tex -V geometry:margin=1in -o output\CV_Sebastian_Mesch_Henriques_EN_Pandoc.pdf

:: LaTeX
cd build\en
pdflatex -interaction=nonstopmode -output-directory=../../output CV_Sebastian_Mesch_Henriques_EN.tex
pdflatex -interaction=nonstopmode -output-directory=../../output Cover_Letter_Sebastian_Mesch_EN.tex
cd ..\..

echo Exito! PDFs generados en la carpeta output\
