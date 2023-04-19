#!/bin/bash

DEBUG_PFX="setup_quast.sh:"

# Download QUAST source code tarball
wget https://github.com/ablab/quast/releases/download/quast_5.2.0/quast-5.2.0.tar.gz
echo "${DEBUG_PFX} Downloaded QUAST tarball."

# Extract from tarball
tar -xzf quast-5.2.0.tar.gz
echo "${DEBUG_PFX} Extracted QUAST tarball."

