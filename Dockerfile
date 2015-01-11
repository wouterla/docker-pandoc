FROM phusion/baseimage:0.9.15

MAINTAINER Andreas Koch <andy@ak7.io>

# Set correct environment
ENV HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN /usr/sbin/enable_insecure_key

# Install pandoc
RUN apt-get -qy update && apt-get install -qy haskell-platform
RUN cabal update
RUN cabal install pandoc
RUN cabal install pandoc-citeproc
RUN ln -s /root/.cabal/bin/pandoc /bin/pandoc

RUN mkdir -p /source
WORKDIR /source

ENTRYPOINT ["/bin/pandoc"]
CMD ["--help"]

# cleanup
RUN cd ; rm -rf hdf5-vol .subversion
RUN apt-get -yq remove subversion
RUN apt-get -yq autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV PANDOCVERSION 1.13.2
