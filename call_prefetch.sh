#!/bin/bash

DEBUG_PFX="call_prefetch.sh:"

# pass accession name as arg ...
accession_name="$1"

if [[ -z $1 ]]; then
  echo "USAGE ERROR: $DEBUG_PFX requires an accession number as its primary argument, but none was provided."
  echo "$DEBUG_PFX For a sample accession, try SRR1525774. Example: \"$DEBUG_PFX SRR1525774\""
  exit 1
fi

# if this is a new accession, create accession directory and prefetch reads.
# tolerate case where accession directory exists, but SRA files aren't contained therein.
if [[ ! -d "$MICROSOPHILA_STORAGE_PATH/$accession_name/sra" ]]; then
  if [[ ! -d "$MICROSOPHILA_STORAGE_PATH/$accession_name" ]]; then
    mkdir "$MICROSOPHILA_STORAGE_PATH/$accession_name"
  fi
  mkdir "$MICROSOPHILA_STORAGE_PATH/$accession_name/sra"
  echo "$DEBUG_PFX Created directory \"${MICROSOPHILA_STORAGE_PATH}/${accession_name}/sra\"."
else
  # the reads have probably already been prefetch'd
  echo "$DEBUG_PFX Failed to prefetch reads. Directory \"$accession_name/sra\" already exists."
  echo "$DEBUG_PFX Check whether this accession's reads already been prefetched."
  exit 1
fi

output_path="$MICROSOPHILA_STORAGE_PATH/$accession_name/sra"

#Not clear what this does.
"$MICROSOPHILA_INSTALL_PATH/sratoolkit/bin/prefetch" $accession_name -O "$output_path"

# check prefetch's exit status to confirm that download was successful
if [[ $? -ne 0 ]]; then
  echo "*!*!* ERROR: $DEBUG_PFX prefetch returned non-zero exit code. Considering task unsuccessful. *!*!*"
  rmdir "$output_path" || echo "$DEBUG_PFX Couldn't clean up ${output_path}! ${output_path} removed."
fi
