FROM ivotron/texlive:20141024-2
MAINTAINER Ivo Jimenez <wouter@lagerweij.com> # Based on Ivo Jiminez' image on https://github.com/ivotron/docker-pandoc

# install haskell and deps
RUN apt-get -yq update && apt-get install -qy \
      curl wget git fontconfig make haskell-platform imagemagick && \
    apt-get -yq autoremove && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# install pandoc
ENV PANDOCVERSION 1.14.0.1
RUN cabal update && \
    cabal install cabal-install && \
    ~/.cabal/bin/cabal update && \
    ~/.cabal/bin/cabal install \
        pandoc \
        pandoc-citeproc \
        pandoc-crossref

ENV PATH /root/.cabal/bin/:$PATH
RUN mkdir -p /root/.pandoc/templates
ADD pandoc/* /root/.pandoc/templates/

ADD script /script

VOLUME /manuscript
VOLUME /images
VOLUME /target

WORKDIR /manuscript

ENTRYPOINT ["/script/create_book.sh"]
CMD ["twinspiratie", "twinspiratie", "01_voorwoord.txt", "02_introductie.txt", "03_tweelingbaby_het_eerste_jaar.txt", "04_tweelingdreumes_van_1_tot_2_5_jaar.txt", "05_tweelingpeuter_van_2_5_tot_4_jaar.txt", "06_tweelingkleuter_van_4_tot_6_jaar.txt", "07_tweelingkind_van_6_tot_12_jaar.txt", "08_grote_tweelingking_van_12_tot_18_jaar.txt", "09_zwanger_van_een_tweeling.txt", "10_bevallen_van_een_tweeling.txt", "11_tweelingen_met_beperkingen.txt", "12_verlies_van_een_tweelingkind.txt", "13_drie_en_meer.txt", "14_nawoord.txt", "15_geraadpleegde_lliteratuur.txt", "16_interessante_websites_over_tweelingen.txt", "17_interessante_boeken.txt"]
