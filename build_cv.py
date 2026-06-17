import yaml
from jinja2 import Environment, FileSystemLoader
import os

# Define paths relative to this script
ROOT_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(ROOT_DIR, "src", "data")
TEMPLATE_DIR = os.path.join(ROOT_DIR, "src", "templates")
BUILD_DIR = os.path.join(ROOT_DIR, "build")

# Data files
DATA_FILE = os.path.join(DATA_DIR, "cv_data.yaml")
CL_DATA_FILE = os.path.join(DATA_DIR, "cover_letter_data.yaml")

# Markdown templates and outputs
MD_TEMPLATE_FILE = "cv_template.md.j2"
MD_OUT_ES = os.path.join(BUILD_DIR, "es", "CV_Sebastian_Mesch_Henriques.md")
MD_OUT_EN = os.path.join(BUILD_DIR, "en", "CV_Sebastian_Mesch_Henriques_EN.md")

# LaTeX CV templates and outputs
TEX_TEMPLATE_FILE = "cv_template.tex.j2"
TEX_OUT_ES = os.path.join(BUILD_DIR, "es", "CV_Sebastian_Mesch_Henriques.tex")
TEX_OUT_EN = os.path.join(BUILD_DIR, "en", "CV_Sebastian_Mesch_Henriques_EN.tex")

# LaTeX Cover Letter templates and outputs
CL_TEMPLATE_FILE = "cover_letter_template.tex.j2"
CL_OUT_ES = os.path.join(BUILD_DIR, "es", "Cover_Letter_Sebastian_Mesch.tex")
CL_OUT_EN = os.path.join(BUILD_DIR, "en", "Cover_Letter_Sebastian_Mesch_EN.tex")


def build_cvs():
    # Ensure build directories exist
    os.makedirs(os.path.join(BUILD_DIR, "es"), exist_ok=True)
    os.makedirs(os.path.join(BUILD_DIR, "en"), exist_ok=True)

    # Load YAML data
    with open(DATA_FILE, "r", encoding="utf-8") as f:
        data = yaml.safe_load(f)

    with open(CL_DATA_FILE, "r", encoding="utf-8") as f:
        cl_data = yaml.safe_load(f)

    # Pre-render paragraphs in cover letter to resolve internal {{ variables }}
    from jinja2 import Template
    for lang in ['en', 'es']:
        cl_data['paragraphs'][lang] = [
            Template(p).render(position=cl_data['position'], company=cl_data['company'])
            for p in cl_data['paragraphs'][lang]
        ]

    # Set up Jinja2 environment (load templates from the templates directory)
    env = Environment(loader=FileSystemLoader(TEMPLATE_DIR))
    
    # ---------------- MARKDOWN ----------------
    md_template = env.get_template(MD_TEMPLATE_FILE)

    # Render Spanish MD
    md_es = md_template.render(lang="es", **data)
    with open(MD_OUT_ES, "w", encoding="utf-8") as f:
        f.write(md_es)
    print(f"OK Generated Spanish Markdown CV: {MD_OUT_ES}")

    # Render English MD
    md_en = md_template.render(lang="en", **data)
    with open(MD_OUT_EN, "w", encoding="utf-8") as f:
        f.write(md_en)
    print(f"OK Generated English Markdown CV: {MD_OUT_EN}")

    # ---------------- LATEX CV ----------------
    tex_template = env.get_template(TEX_TEMPLATE_FILE)

    # Render Spanish TEX
    tex_es = tex_template.render(lang="es", **data)
    with open(TEX_OUT_ES, "w", encoding="utf-8") as f:
        f.write(tex_es)
    print(f"OK Generated Spanish LaTeX CV: {TEX_OUT_ES}")

    # Render English TEX
    tex_en = tex_template.render(lang="en", **data)
    with open(TEX_OUT_EN, "w", encoding="utf-8") as f:
        f.write(tex_en)
    print(f"OK Generated English LaTeX CV: {TEX_OUT_EN}")

    # ---------------- LATEX COVER LETTER ----------------
    cl_template = env.get_template(CL_TEMPLATE_FILE)

    # Render Spanish Cover Letter
    cl_es = cl_template.render(lang="es", cv=data, cl=cl_data)
    with open(CL_OUT_ES, "w", encoding="utf-8") as f:
        f.write(cl_es)
    print(f"OK Generated Spanish LaTeX Cover Letter: {CL_OUT_ES}")

    # Render English Cover Letter
    cl_en = cl_template.render(lang="en", cv=data, cl=cl_data)
    with open(CL_OUT_EN, "w", encoding="utf-8") as f:
        f.write(cl_en)
    print(f"OK Generated English LaTeX Cover Letter: {CL_OUT_EN}")

if __name__ == "__main__":
    build_cvs()
