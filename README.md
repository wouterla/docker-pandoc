# Pandoc Docker Image

A docker image for running the latest version of 
[Pandoc](https://github.com/jgm/pandoc) (as seen by `cabal update`) 
built from source. The image includes:

  * ubuntu
  * latex
  * pandoc
  * [pandoc-citeproc](https://github.com/jgm/pandoc-citeproc)
  * [pandoc-filters](https://github.com/jgm/pandocfilters)

## Usage

### Basic

```bash
docker run -v `pwd`/input.pd:/root/input.pd ivotron/pandoc <... options ...>
```

### Advanced

This passes paths to specific latex files, bibliography style, bibtex 
file and pandoc templates

```bash
docker run \
  -v `pwd`/pandoc-templates:/root/.pandoc/templates \
  -v `pwd`/pandoc-filters/root/.pandoc/filters \
  -v `pwd`/latex-files:/root/texmf/tex/xelatex \
  -v `pwd`/bibtools/ieee.csl:/root/ieee.csl \
  -v `pwd`/bibfile/zotero.bib:/root/citations.bib \
  -v `pwd`/main.pdc:/root/main.pdc \
  -v `pwd`/out:/root/out \
  ivotron/pandoc:1.13.2 \
    --standalone \
    --latex-engine=xelatex \
    --self-contained \
    --csl=/root/ieee.csl \
    --bibliography=/root/citations.bib \
    --filter=/root/.pandoc/filters/foo.py \
    --reference-links \
    --metadata=acm-sig-alternate:'yes' \
    --output=/root/out/main.pdf /root/main.pdc
```

## Version Info

### 1.13.2

  * Ubuntu Trusty (stackbrew/ubuntu:14.04)
  * TexLive 2013.20140215-1
  * pandoc (1.13.2)
  * pandoc-citeproc (0.6)
  * pandoc-filters (1.2.3)
