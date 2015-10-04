#!/bin/bash
set -x
mkdir -p /target
cd /target
ln -s /images /target/images

rm *.txt
cp /manuscript/*.tex /manuscript/*.yml /target

ls -1 /manuscript/*.txt | while read line; do cat $line |sed -e "s/^I>/> /" | sed -e "s/^A>/> /" > /target/$(basename $line).converted.md; done
ls -1 *.md | while read line ; do mv $line $(echo $line | sed -e "s/txt.converted.md/txt/"); done

pandoc --template=${1}.latex -V documentclass=book --toc -o /target/${2}.pdf ${@:3}
echo "Done!"
