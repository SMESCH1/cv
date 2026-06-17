# 🚀 CV & Cover Letter Automation Pipeline
**Por Sebastián Mesch Henriques**

Este repositorio contiene la arquitectura completa para generar automáticamente múltiples versiones y formatos de mi Currículum Vitae y Cartas de Presentación, manteniendo sincronizados los idiomas Español e Inglés sin duplicar esfuerzos.

El pipeline separa completamente los **datos** (el contenido) del **diseño** (las plantillas), permitiendo compilar diseños radicalmente distintos a partir de la misma fuente de información.

---

## 📂 Estructura de Datos (Tu Fuente de Verdad)

Para actualizar tu información, **nunca debes editar los archivos PDF o `.tex` / `.md` generados**. Todo el contenido vive en la carpeta `src/data/`:

1. `src/data/cv_data.yaml`: Contiene tu perfil, experiencias, educación, publicaciones y habilidades.
2. `src/data/cover_letter_data.yaml`: Contiene la información específica de la empresa a la que estás aplicando (puesto, nombre de la empresa, párrafos de la carta).

*Ambos archivos soportan diccionarios bilingües (`en` y `es`) para cada entrada de texto.*

---

## 🎨 Las Plantillas (Templates)

El motor utiliza **Jinja2** para inyectar tus datos en las plantillas maestras ubicadas en `src/templates/`:

- `src/templates/cv_template.tex.j2`: Plantilla LaTeX de diseño moderno ("One-Pager") ideal para impresionar a reclutadores humanos.
- `src/templates/cv_template.md.j2`: Plantilla Markdown estructurada que Pandoc convierte en un PDF de texto plano (formato clásico ATS).
- `src/templates/cover_letter_template.tex.j2`: Plantilla LaTeX para la carta de presentación.

---

## ⚙️ ¿Cómo actualizar y generar nuevos PDFs?

Tienes dos opciones para compilar tus PDFs:

### Opción 1: Compilación Automática en la Nube (Recomendada)
Este repositorio cuenta con un flujo de **GitHub Actions** (`.github/workflows/generate_cv.yml`).
1. Edita el archivo `cv_data.yaml` o `cover_letter_data.yaml` directamente en GitHub (o haz commit localmente y haz `git push`).
2. La nube de GitHub automáticamente instalará Python, LaTeX (MiKTeX) y Pandoc.
3. Generará 6 archivos PDF nuevos y los subirá a la carpeta `output/`.
4. ¡Listo! Solo descarga tus PDFs actualizados.

### Opción 2: Compilación Local
Si deseas probar cómo se ven los cambios en tu computadora antes de subirlos:
1. Instala Python 3, [Pandoc](https://pandoc.org/) y [MiKTeX](https://miktex.org/).
2. Instala las librerías de Python:
   ```bash
   pip install pyyaml jinja2
   ```
3. Ejecuta el script maestro:
   ```bash
   ./generate_pdf.sh
   ```
   *(Si estás en Windows, puedes correr `python build_cv.py` en la raíz para generar los `.tex` y `.md` temporales en la carpeta `build/`).*

---

## 📁 Archivos Generados (`output/`)

Tras una compilación exitosa, la carpeta `output/` contendrá:
- **CV_Sebastian_Mesch_Henriques.pdf** (Diseño LaTeX - ES)
- **CV_Sebastian_Mesch_Henriques_EN.pdf** (Diseño LaTeX - EN)
- **CV_Sebastian_Mesch_Henriques_ES_Pandoc.pdf** (Formato ATS - ES)
- **CV_Sebastian_Mesch_Henriques_EN_Pandoc.pdf** (Formato ATS - EN)
- **Cover_Letter_Sebastian_Mesch.pdf** (LaTeX - ES)
- **Cover_Letter_Sebastian_Mesch_EN.pdf** (LaTeX - EN)

---

## 💡 Estrategia de Aplicación
- **Para Portales de Empleo Automáticos (ATS):** Utiliza los PDFs generados con **Pandoc**. Los robots pueden extraer el texto a la perfección porque es un documento de una sola columna sin gráficos complejos.
- **Para Correos Directos o Entrevistas:** Utiliza los PDFs generados con **LaTeX**. El diseño en columnas e imágenes causa un excelente impacto visual.
