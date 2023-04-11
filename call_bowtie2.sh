#!/bin/bash

#SBATCH --time=01:00:00   # walltime
#SBATCH --ntasks=32 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=1GB # memory per CPU core

DEBUG_PFX="call_bowtie2.sh:"

# pass accession name as arg ...
accession_name="$1"
if [[ -z $1 ]]; then
  echo "USAGE ERROR: $DEBUG_PFX Requires an accession number as its primary argument, but no accession number was provided."
  exit 1
fi

echo "$DEBUG_PFX running with accession number: $accession_name"

bowtie_bin_path="$MICROSOPHILA_INSTALL_PATH/bowtie2"
input_path="$MICROSOPHILA_STORAGE_PATH/$accession_name/with_host"
output_path="$MICROSOPHILA_STORAGE_PATH/$accession_name/microbiome"

# TODO:
# provide read length, fragment size (probably unnecessary since we only care about unmapped reads)
# may want to do some tuning for targeting microbiome reads.

# output directory must exist
if [[ ! -d "$output_path" ]]; then
  mkdir "$output_path"
fi

"$bowtie_bin_path/bowtie2" --threads 32 \
                         -x "$MICROSOPHILA_STORAGE_PATH/ref/d_melanogaster/bt2_index" \
                         -1 "$input_path/${accession_name}_1.fastq" \
                         -2 "$input_path/${accession_name}_2.fastq" \
                         -U "$input_path/${accession_name}.fastq" \
                         -S /dev/null \
                         --un-conc "$output_path/microbiome_reads.fastq" \
                         --un "$output_path/microbiome_reads.fastq" \
                         > "$output_path/alignment_stats.txt" # if run in SLURM, redirect doesn't work. Handled below.

# if successful, copy bowtie2 output to output directory
if [[ $? -eq 0 && -n $SLURM_JOB_ID ]]; then
  echo "$DEBUG_PFX Success, copying output to $output_path"
  cp slurm-${SLURM_JOB_ID}.out "$output_path/alignment_stats.txt"
fi
