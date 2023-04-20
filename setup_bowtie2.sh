# see also: offical docs: https://bowtie-bio.sourceforge.net/bowtie2/index.shtml

DEBUG_PFX="setup_bowtie2.sh:"

BOWTIE_PATH="$MICROSOPHILA_INSTALL_PATH"

# download pre-built binaries
echo "$DEBUG_PFX Downloading pre-built binaries..."
wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.5.1/bowtie2-2.5.1-linux-x86_64.zip/download

# extract pre-built binaries
unzip download

# get the name of the directory that was just extracted (e.g. bowtie2-2.5.1-linux-x86_64)
name_to_replace=$(unzip -l download | head -4 | tail -1 | awk '{print $4}')

# rename package to bowtie2
mv $name_to_replace ${BOWTIE_PATH}/bowtie2

# remove .zip file
rm download
echo "$DEBUG_PFX Downloaded pre-built binaries."

echo "$DEBUG_PFX Creating reference directories..."
mkdir "$MICROSOPHILA_STORAGE_PATH/ref"
DM_REF_PATH="$MICROSOPHILA_STORAGE_PATH/ref/d_melanogaster"
mkdir "$DM_REF_PATH"
echo "$DEBUG_PFX Created reference directories."

echo "$DEBUG_PFX Fetching references..."
wget --directory-prefix=${DM_REF_PATH} https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/215/GCF_000001215.4_Release_6_plus_ISO1_MT/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna.gz

echo "$DEBUG_PFX Unzipping references..."
gunzip "$DM_REF_PATH/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna.gz"

echo "$DEBUG_PFX Removing .gz file..."
rm GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna.gz

echo "$DEBUG_PFX Building index..."
bowtie2-build -f "$DM_REF_PATH/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna" "$DM_REF_PATH/bt2_index"

echo "$DEBUG_PFX Done."
