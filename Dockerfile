FROM ivotron/texlive:20141024-2
MAINTAINER Ivo Jimenez <ivo.jimenez@gmail.com>

# install haskell and deps
RUN apt-get -yq update && apt-get install -qy \
      curl wget git fontconfig make haskell-platform && \
    apt-get -yq autoremove && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install pandoc
ENV PANDOCVERSION 1.13.2.1
RUN cabal update && \
    cabal install cabal-install && \
    ~/.cabal/bin/cabal update && \
    ~/.cabal/bin/cabal install \
        pandoc \
        pandoc-citeproc \
        pandoc-crossref

ENV PATH /root/.cabal/bin/:$PATH

ENTRYPOINT ["pandoc"]
CMD ["--help"]
