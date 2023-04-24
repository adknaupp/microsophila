#!/bin/bash

DEBUG_PFX="run_quast.sh:"

QUAST_PY_PATH="$MICROSOPHILA_INSTALL_PATH/metaphlan_env/bin/metaquast.py"

INPUT_PATH=$1
OUTPUT_PATH=$2
INPUT_FILENAME=$3

INPUT_FILE="$INPUT_PATH/$INPUT_FILENAME"

full_cmd="$QUAST_PY_PATH -o $OUTPUT_PATH $INPUT_FILE"
echo "$DEBUG_PFX Running $full_cmd"
eval $full_cmd

echo "$DEBUG_PFX Done."
