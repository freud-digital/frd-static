# bin/bash
rm -rf ./data/editions
mkdir ./data/editions
mkdir ./data/editions/critical
mkdir ./data/editions/plain
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
  b=$(basename $f); cp -v $f ./data/editions/plain/${b%}
done
mv ./frd-data-main/indices ./data

rm -rf ./frd-data-main

wget https://github.com/freud-digital/frd-working-data/archive/refs/heads/main.zip
unzip main
rm main.zip

for f in  $(find -path "./frd-working-data-main/werke/*/*.xml" | grep __); do
  b=$(basename $f); cp -v $f ./data/editions/critical/${b%__*}.xml
done
rm -rf ./frd-working-data-main


add-attributes -g "./data/editions/*.xml" -b "https://id.acdh.oeaw.ac.at/freud-hka"
add-attributes -g "./data/indices/*.xml" -b "https://id.acdh.oeaw.ac.at/freud-hka"

denormalize-indices -f "./data/editions/*.xml" -i "./data/indices/*.xml" -m ".//*[@ref]/@ref | .//*/@source" -x ".//tei:titleStmt/tei:title[1]/text()" 

echo "done"