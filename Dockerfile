FROM ubuntu:14.04
MAINTAINER Ivo Jimenez <ivo.jimenez@gmail.com>

RUN apt-get -yq update

# install latex
RUN apt-get install -qy texlive-latex-base \
    texlive-xetex latex-xcolor texlive-math-extra texlive-latex-extra \
    texlive-fonts-extra texlive-bibtex-extra \
    curl wget git fontconfig make

# install haskell
RUN apt-get install -yq haskell-platform

# install pandoc
ENV PANDOCVERSION 1.13.2
RUN cabal update && \
    cabal install pandoc && \
    cabal install pandoc-citeproc
ENV PATH /root/.cabal/bin/:$PATH

ENTRYPOINT ["pandoc"]
CMD ["--help"]

# cleanup
RUN apt-get -yq autoremove && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
