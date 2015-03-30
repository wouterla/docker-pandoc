FROM ivotron/texlive:20140215-1
MAINTAINER Ivo Jimenez <ivo.jimenez@gmail.com>

RUN apt-get -yq update

# install haskell and deps
RUN apt-get install -qy curl wget git fontconfig make haskell-platform

# install pandoc
ENV PANDOCVERSION 1.13.2
RUN cabal update && \
    cabal install pandoc && \
    cabal install pandoc-citeproc
ENV PATH /root/.cabal/bin/:$PATH

# install python
RUN apt-get install -qy python

# install filters
RUN cd /tmp/ && \
    git clone https://github.com/jgm/pandocfilters.git && \
    cd pandocfilters && \
    python setup.py install

ENTRYPOINT ["pandoc"]
CMD ["--help"]

# cleanup
RUN apt-get -yq autoremove && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
