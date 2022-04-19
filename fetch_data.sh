# bin/bash
rm -rf ./data/editions
mkdir ./data/editions
rm -rf ./data/indices
rm master.zip
rm -rf ./frd-data-main

wget https://github.com/freud-digital/frd-data/archive/refs/heads/master.zip
unzip master
rm master.zip
find ./ -name '*.xml' -exec cp -prv '{}' '/path/to/targetDir/' ';'
find -path "./frd-data-main/werke/*/*.xml" -exec cp -prv '{}' './data/editions' ';'
rm -rf ./frd-data-main