#!/bin/bash

#SBATCH --time=00:30:00   # walltime
#SBATCH --ntasks=6 # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=6GB # memory per CPU core

DEBUG_PFX="call_fasterq_dump.sh:"

# pass accession name as arg ...
accession_name="$1"
if [[ -z $1 ]]; then
  echo "USAGE ERROR: $DEBUG_PFX requires an accession number as its primary argument, but no accession number was provided."
  echo "$DEBUG_PFX Accessions must be prefetched and stored in the storage folder."
  echo "$DEBUG_PFX The current storage path is \"$MICROSOPHILA_STORAGE_PATH\"."
  echo "$DEBUG_PFX The expected storage folder path is \"$MICROSOPHILA_STORAGE_PATH/[accession number]\"."
  exit 1
fi

accession_path="$MICROSOPHILA_STORAGE_PATH/$accession_name"
sra_bin_path="$MICROSOPHILA_INSTALL_PATH/sratoolkit/bin"

"$sra_bin_path/fasterq-dump" "$accession_path/sra/$accession_name" \
                        -O "$accession_path/with_host" \
                        -t "$accession_path/with_host" \
                        -e 6
