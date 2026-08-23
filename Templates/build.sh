#!/usr/bin/env bash
#
# Rebuild the downloadable JARS LaTeX template zips from the sources in latex/.
#
# The zips in dist/ are what authors download from the TOCE author guidelines,
# so they are committed to this repository rather than built on demand. Run this
# after changing anything under latex/ -- or just push, and the
# .github/workflows/build-templates.yml action will run it for you.
#
# Output is byte-reproducible: entries are written in a fixed order with a fixed
# timestamp, so an unchanged template produces an unchanged zip and does not
# churn the git history.

set -euo pipefail
cd "$(dirname "$0")"

mkdir -p dist

for kind in quant:Quant qual:Qual mixed:Mixed; do
    src="latex/${kind%%:*}"
    out="dist/TOCE_JARS_${kind##*:}_Template.zip"

    python3 - "$src" "$out" <<'PY'
import sys, zipfile, pathlib

src, out = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
# Deliberately NOT bundled: acmart.cls, ACM-Reference-Format.bst/.bbx. Shipping a
# copy of the class shadows the current one that Overleaf and TeX Live provide,
# which is exactly how these templates went eight years out of date.
names = ['main.tex', 'bibliography.bib', 'README.md']

with zipfile.ZipFile(out, 'w', zipfile.ZIP_DEFLATED) as z:
    for name in names:
        p = src / name
        if not p.exists():
            raise SystemExit(f'{p}: missing')
        info = zipfile.ZipInfo(name, date_time=(1980, 1, 1, 0, 0, 0))
        info.compress_type = zipfile.ZIP_DEFLATED
        info.external_attr = 0o644 << 16
        z.writestr(info, p.read_bytes())
print(f'{out}  <-  {src}')
PY
done
