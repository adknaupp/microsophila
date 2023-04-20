#!/bin/bash

DEBUG_PFX="setup_quast.sh:"

cd $MICROSOPHILA_STORAGE_PATH
echo"$DEBUG_PFX Moving to storage path... $MICROSOPHILA_STORAGE_PATH"

# Download QUAST source code tarball
wget https://github.com/ablab/quast/releases/download/quast_5.2.0/quast-5.2.0.tar.gz
echo "${DEBUG_PFX} Downloaded QUAST tarball."

# Extract from tarball
tar -xzf quast-5.2.0.tar.gz
echo "${DEBUG_PFX} Extracted QUAST tarball."

rm quast-5.2.0.tar.gz
echo "${DEBUG_PFX} Removed QUAST tarball."
