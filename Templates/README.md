# TOCE JARS Templates

Manuscript templates for [ACM Transactions on Computing Education](https://dl.acm.org/journal/toce)
built around the APA [Journal Article Reporting Standards](https://apastyle.apa.org/jars/) (JARS),
in LaTeX and Microsoft Word, for quantitative, qualitative, and mixed methods studies.

## ⚠️ These paths are published — do not rename or move them

The TOCE author guidelines link **directly at this repository**. The six URLs below are what
authors click. Renaming a file, renaming a directory, or reorganizing `Templates/` breaks the
downloads on `dl.acm.org` with no warning and no redirect.

| Author-facing download | Path here |
|---|---|
| LaTeX Quantitative | `Templates/dist/TOCE_JARS_Quant_Template.zip` |
| LaTeX Qualitative  | `Templates/dist/TOCE_JARS_Qual_Template.zip` |
| LaTeX Mixed        | `Templates/dist/TOCE_JARS_Mixed_Template.zip` |
| Word Quantitative  | `Templates/word/TOCE_JARS_Quant_Template.docx` |
| Word Qualitative   | `Templates/word/TOCE_JARS_Qual_Template.docx` |
| Word Mixed         | `Templates/word/TOCE_JARS_Mixed_Template.docx` |

Each is served as `https://github.com/acm-toce/documentation/raw/main/<path>`.

If a path genuinely has to change, update the six anchors in the author guidelines
(`#reporting`) in the ACM DL PB Editor in the same sitting — see
[Editing Journal Pages in the ACM DL PB Editor](../Process/Editing-Journal-Pages-in-the-ACM-DL-PB-Editor.pdf).

## Layout

```
Templates/
├── latex/{quant,qual,mixed}/   main.tex + bibliography.bib + README.md  <- edit these
├── word/                       the three .docx templates                <- edit these
├── dist/                       built zips (committed; authors download these)
└── build.sh                    latex/<kind>/ -> dist/TOCE_JARS_<Kind>_Template.zip
```

## Updating a template

**LaTeX:** edit the files under `latex/`, then push. The
[build-templates workflow](../.github/workflows/build-templates.yml) reruns `build.sh` and commits
the rebuilt zip, so `dist/` can never drift from the source. Run `./build.sh` yourself if you want
to check the zip locally first; it is byte-reproducible, so an unchanged template produces an
unchanged zip.

**Word:** edit the `.docx` in place. Keep the style definitions as they are — they match ACM's
official `acm_submission_template.docx` exactly, and that is what makes these templates convert
cleanly through TAPS after acceptance.

Nothing needs to be uploaded to the ACM CMS. That was the old workflow, and it is why these
templates sat unrevised from January 2021 to August 2026.

## Design decisions worth preserving

**The LaTeX zips deliberately do not bundle `acmart.cls`.** The 2021 versions shipped a copy of
the class from December 2018 (v1.57). Because a local copy *shadows* the one Overleaf and TeX Live
provide, every author using the template was silently pinned to an eight-year-old class — which is
how the templates ended up predating tagged-PDF support, the `[Author Year]` requirement, and the
`anonymous` review workflow. Do not re-add `acmart.cls`, `ACM-Reference-Format.bst`, or `.bbx`.

**The templates require `acmart` 2.19 or later** (for PDF tagging) and must be compiled with
LuaLaTeX.

**Two dead URLs remain in the Word templates' sample reference list**
(`iesl.cs.umass.edu`, `wwtug.org`). Both are inherited verbatim from ACM's own official Word
template, where they illustrate ACM Reference Format rather than pointing authors anywhere. They
are left as-is so this template stays diffable against ACM's.

## Testing a change

```sh
./build.sh
cd /tmp && rm -rf t && mkdir t && cd t
unzip -q ~/Code/documentation/Templates/dist/TOCE_JARS_Quant_Template.zip
docker run --rm -v "$PWD:/w" -w /w texlive/texlive latexmk -lualatex main.tex
```

The resulting PDF should be tagged, cite as `[Baker 2017]` rather than `[1]`, and contain no author
names. `Archive/Templates/` holds the January 2021 originals for comparison.
