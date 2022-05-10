# bin/bash
rm -rf ./data/editions
mkdir ./data/editions
rm -rf ./data/indices
mkdir ./data/indices
rm -rf ./data/tmp
mkdir ./data/tmp
rm master.zip
rm -rf ./frd-data-main

wget https://github.com/freud-digital/frd-data/archive/refs/heads/master.zip
unzip master
rm master.zip
for f in  $(find -path "./frd-data-main/werke/*/*.xml" | grep __); do
  b=$(basename $f); cp -v $f ./data/editions/${b%}
done
mv ./frd-data-main/indices ./data/indices

rm -rf ./frd-data-main

wget https://github.com/freud-digital/frd-working-data/archive/refs/heads/main.zip
unzip main
rm main.zip

for f in  $(find -path "./frd-working-data-main/werke/*/*.xml" | grep __); do
  b=$(basename $f); cp -v $f ./data/editions/${b%__*}.xml
done
rm -rf ./frd-working-data-main
