#!/bin/bash

DEBUG_PFX="setup_quast.sh:"

# create and activate virtual env
echo "$DEBUG_PFX Creating virtual environment..."
python -m venv "$MICROSOPHILA_INSTALL_PATH/metaphlan_env"
source "$MICROSOPHILA_INSTALL_PATH/metaphlan_env/bin/activate"
echo "$DEBUG_PFX Created virtual environment."

# upgrade pip
echo "$DEBUG_PFX Installing QUAST via PIP..."
pip install quast

echo "$DEBUG_PFX done."
