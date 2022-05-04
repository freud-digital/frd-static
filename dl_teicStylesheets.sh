# bin/bash

echo "downloading TEIC stylesheets"
wget https://github.com/TEIC/Stylesheets/archive/refs/heads/dev.zip && unzip dev.zip -d TEI-Stylesheets && rm -rf dev.zip
