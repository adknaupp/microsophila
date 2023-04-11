#!/bin/bash

#SBATCH --time=01:00:00   # walltime
#SBATCH --ntasks=16 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=4GB # memory per CPU core

DEBUG_PFX="call_metaphlan.sh"

# pass accession name as arg ...
accession_name="$1"
if [[ -z $1 ]]; then
  echo "USAGE ERROR: $DEBUG_PREFIX This script requires an accession number as its first argument, but none was provided."
  exit 1
fi

database_folder="$MICROSOPHILA_STORAGE_PATH/metaphlan_database"
metaphlan_index_name=$(cat "$database_folder/mpa_latest" )

accession_path="$MICROSOPHILA_STORAGE_PATH/$accession_name"

paired_1="$accession_path/microbiome/microbiome_reads.1.fastq"
paired_2="$accession_path/microbiome/microbiome_reads.2.fastq"
unpaired="$accession_path/microbiome/microbiome_reads.fastq"
microbiome_files="$paired_1,$paired_2,$unpaired"

# check that input files exist
[[ ! -f "$paired_1" ]] && echo "$DEBUG_PFX Missing input file ${paired_1}." && exit 1
[[ ! -f "$paired_2" ]] && echo "$DEBUG_PFX Missing input file ${paired_2}." && exit 1
[[ ! -f "$unpaired" ]] && echo "$DEBUG_PFX Missing input file ${unpaired}." && exit 1

# somewhere to put bowtie2 output
if [[ ! -d "$accession_path/metaphlan" ]]; then
  mkdir "$accession_path/metaphlan"
fi

# activate metaphlan venv
source "$MICROSOPHILA_INSTALL_PATH/metaphlan_env/bin/activate"

# call metaphlan
"$MICROSOPHILA_INSTALL_PATH/metaphlan_env/bin/metaphlan" "$microbiome_files" \
                                --index "$metaphlan_index_name" \
                                --bowtie2db "$database_folder" \
                                --bowtie2out "$accession_path/metaphlan/bowtie2_output.bz2" \
                                --nproc 16 \
                                --input_type fastq \
                                -o "$accession_path/microbiome_profile.txt"

# clean up if metaphlan fails
exit_code=$?
if [[ $exit_code -ne 0 ]]; then
  echo "$DEBUG_PFX MetaPhlan exited with a non-zero exit code of: $exit_code."
  rm "$accession_path/metaphlan/bowtie2_output.bz2"
fi
