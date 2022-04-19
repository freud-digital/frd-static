# bin/bash
rm -rf ./data/editions
rm -rf ./data/indices
rm master.zip
rm -rf ./frd-data-main

wget https://github.com/freud-digital/frd-data/archive/refs/heads/master.zip
unzip master
rm master.zip
rm -rf ./frd-data-main