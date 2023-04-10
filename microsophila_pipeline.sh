#!/bin/bash

DEBUG_PFX="metaphlan_pipeline.sh:"

accession_number=$1

echo "$DEBUG_PFX Initiating prefetch with ${accession_number}..."
./call_prefetch.sh $accession_number

echo "$DEBUG_PFX Initiating FasterQ dump with ${accession_number}..."
./call_fasterq-dump.sh $accession_number

echo "$DEBUG_PFX Initiating Bowtie2 with ${accession_number}..."
./call_bowtie2.sh $accession_number

echo "$DEBUG_PFX Initiating MetaPhlan with ${accession_number}..."
./call_metaphlan.sh $accession_number

echo "$DEBUG_PFX Completed pipeline."
