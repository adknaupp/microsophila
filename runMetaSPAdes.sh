#!bin/bash

DEBUG_PFX="runMetaSPAdes.sh:"

INPUT_PATH=$1
OUTPUT_PATH=$2
INPUT_1_FILENAME=$3
INPUT_2_FILENAME=$4

METASPADES_PY_PATH="$PWD/spades/SPAdes-3.15.5-Linux/bin/metaspades.py"
OUTPUT_DIR="/grphome/grp_microsophila/compute/mspades_output/"
INPUT_DIR="/grphome/grp_microsophila/compute/linvilla_frost/microbiome/"

if [ -z INPUT_1_FILENAME ] then
  echo "$DEBUG_PFX Specific output path NOT specified. Defaulting to \"${PWD}/spades_out\"."
  mkdir -p ${PWD}/spades_out
  OUTPUT_PATH="${PWD}/spades_out"
fi

if [ -z INPUT_1_FILENAME ] then
  echo "$DEBUG_PFX Specific filename for input 1 NOT specified. Defaulting to \"microbiome_reads.1.fastq\"."
  INPUT_1_FILENAME="microbiome_reads.1.fastq"
fi

if [ -z INPUT_2_FILENAME ] then
  echo "$DEBUG_PFX Specific filename for input 2 NOT specified. Defaulting to \"microbiome_reads.2.fastq\"."
  INPUT_2_FILENAME="microbiome_reads.2.fastq"
fi

INPUT_1_FILENAME="${INPUT_PATH}/${INPUT_1_FILENAME}"
INPUT_2_FILENAME="${INPUT_PATH}/${INPUT_2_FILENAME}"


full_cmd="$METASPADES_PY_PATH -o $OUTPUT_PATH -1 $INPUT_1_FILENAME -2 $INPUT_2_FILENAME"
echo $full_cmd
eval $full_cmd

