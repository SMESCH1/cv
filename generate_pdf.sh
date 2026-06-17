#!/bin/bash

echo "🔄 Construyendo archivos Markdown y LaTeX desde cv_data.yaml..."
python3 src/build_cv.py

echo "🔄 Generando CVs en progreso..."

mkdir -p output

# Generar PDF clásico del CV con Pandoc (Español)
pandoc src/CV_Sebastian_Mesch_Henriques.md \
    -H assets/disable_hyphens.tex \
    -V geometry:margin=1in \
    -o output/CV_Sebastian_Mesch_Henriques_ES_Pandoc.pdf

# Generar PDF clásico del CV con Pandoc (Inglés)
pandoc src/english/CV_Sebastian_Mesch_Henriques_EN.md \
    -H assets/disable_hyphens.tex \
    -V geometry:margin=1in \
    -o output/CV_Sebastian_Mesch_Henriques_EN_Pandoc.pdf

# Generar PDF moderno del CV con pdflatex (Español)
cd src
pdflatex -interaction=nonstopmode -output-directory=../output CV_Sebastian_Mesch_Henriques.tex
pdflatex -interaction=nonstopmode -output-directory=../output Cover_Letter_Sebastian_Mesch.tex
cd ..

# Generar PDF moderno del CV con pdflatex (Inglés)
cd src/english
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
