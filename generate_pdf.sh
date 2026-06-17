#!/bin/bash
set -e

# Asegurarse de que el directorio de salida exista
mkdir -p output

echo "Construyendo archivos .md y .tex a partir de cv_data.yaml y cover_letter_data.yaml..."
python build_cv.py

echo "Generando PDFs..."

# ----------------- ESPAÑOL -----------------
echo "Compilando Español..."
# Pandoc
pandoc build/es/CV_Sebastian_Mesch_Henriques.md -H assets/disable_hyphens.tex -V geometry:margin=1in -o output/CV_Sebastian_Mesch_Henriques_ES_Pandoc.pdf

# LaTeX
cd build/es
pdflatex -interaction=nonstopmode -output-directory=../../output CV_Sebastian_Mesch_Henriques.tex
pdflatex -interaction=nonstopmode -output-directory=../../output Cover_Letter_Sebastian_Mesch.tex
cd ../..

# ----------------- INGLÉS -----------------
echo "Compilando Inglés..."
# Pandoc
pandoc build/en/CV_Sebastian_Mesch_Henriques_EN.md -H assets/disable_hyphens.tex -V geometry:margin=1in -o output/CV_Sebastian_Mesch_Henriques_EN_Pandoc.pdf

# LaTeX
cd build/en
pdflatex -interaction=nonstopmode -output-directory=../../output CV_Sebastian_Mesch_Henriques_EN.tex
pdflatex -interaction=nonstopmode -output-directory=../../output Cover_Letter_Sebastian_Mesch_EN.tex
cd ../..

echo "✅ PDFs generados exitosamente en la carpeta 'output/':"
echo "  - output/CV_Sebastian_Mesch_Henriques_ES_Pandoc.pdf"
echo "  - output/CV_Sebastian_Mesch_Henriques_EN_Pandoc.pdf"
echo "  - output/CV_Sebastian_Mesch_Henriques.pdf (LaTeX ES)"
echo "  - output/CV_Sebastian_Mesch_Henriques_EN.pdf (LaTeX EN)"
echo "  - output/Cover_Letter_Sebastian_Mesch.pdf (LaTeX ES)"
echo "  - output/Cover_Letter_Sebastian_Mesch_EN.pdf (LaTeX EN)"
