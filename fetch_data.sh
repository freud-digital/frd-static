# bin/bash
rm -rf ./data/editions
mkdir ./data/editions
rm -rf ./data/indices
rm -rf ./data/tmp
mkdir ./data/tmp
rm master.zip
rm -rf ./frd-data-main

wget https://github.com/freud-digital/frd-data/archive/refs/heads/master.zip
unzip master
rm master.zip
find -path "./frd-data-main/werke/*/*.xml" -exec cp -prv '{}' './data/editions' ';'
find -path "./frd-data-main/werke/*/*.html" -exec cp -prv '{}' './data/tmp' ';'

rm -rf ./frd-data-main