# TOCE JARS Mixed Template (LaTeX)

A starting point for mixed methods papers submitted to [ACM Transactions on Computing
Education](https://dl.acm.org/journal/toce), structured around the APA [Journal
Article Reporting Standards](https://apastyle.apa.org/jars/) (JARS).

## What's here

| File | Purpose |
|---|---|
| `main.tex` | The template. Replace the placeholder prose with your own. |
| `bibliography.bib` | ACM's sample bibliography. Add your references here. |

## What's deliberately *not* here

There is no `acmart.cls`, `ACM-Reference-Format.bst`, or `.bbx` in this
archive, and you should not add one. Overleaf and current TeX Live installations
already provide the official ACM class, and a copy sitting next to `main.tex`
**shadows** it — which is how an earlier version of this template quietly pinned
authors to a class from 2018.

This template requires `acmart` **2.19 or later**.

## Getting started

**On Overleaf** (easiest): upload this zip via *New Project → Upload Project*,
then set the compiler to **LuaLaTeX** under *Menu → Compiler*.

**Locally:**

```sh
latexmk -lualatex main.tex
```

LuaLaTeX is required, not optional: PDF tagging comes from the compiler itself,
so pdfLaTeX will not produce an accessible PDF.

## What the template already sets up for you

- **Tagged, accessible PDFs.** TOCE requires submissions to be screen readable,
  and untagged PDFs may be returned before review. When you add figures, give
  each one an `alt` description:
  `\includegraphics[width=.5\linewidth,alt={A short description}]{figure.png}`
- **Double-anonymous review.** The `anonymous` and `review` class options hide
  your author block and acknowledgments. Hiding the author block is *not*
  sufficient on its own — work through the anonymization checklist in the
  [author guidelines](https://dl.acm.org/journal/toce/author-guidelines).
- **`[Author Year]` citations**, required by TOCE since May 2026.

For step-by-step accessibility instructions, see [How do I make my PDF
accessible?](https://github.com/acm-toce/documentation/wiki/How-do-I-make-my-PDF-accessible)

## Before you submit

Remove the `anonymous` and `review` options only *after* your paper is
accepted. Verify that every reference you cite actually exists and is described
correctly: TOCE requires authors to check bibliographies against the digital
library record for each citation.
