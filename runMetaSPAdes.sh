#!bin/bash

INPUT_FILEPATH=""
METASPADES_PY_PATH="/grphome/grp_microsophila/SPAdes-3.15.5-Linux/bin/metaspades.py"
OUTPUT_DIR="/grphome/grp_microsophila/compute/mspades_output/"
INPUT_DIR="/grphome/grp_microsophila/compute/linvilla_frost/microbiome/"

INPUT_1_FILENAME="${INPUT_DIR}microbiome_reads.1.fastq"
INPUT_2_FILENAME="${INPUT_DIR}microbiome_reads.2.fastq"


full_cmd="$METASPADES_PY_PATH -o $OUTPUT_DIR -1 $INPUT_1_FILENAME -2 $INPUT_2_FILENAME"
echo $full_cmd
eval $full_cmd

