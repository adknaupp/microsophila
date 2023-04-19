#!bin/bash/

DEBUG_PFX="DownloadSPAdes.sh:"
SPADES_PATH=$1

if [ -z "$SPADES_PATH"]
  then
    echo "$DEBUG_PFX No path specified. Defaulting to: \"$PWD/spades/\"."
    SPADES_PATH="$PWD/spades/"
fi    

# create directory if not exists
mkdir -p $SPADES_PATH
cd $SPADES_PATH

# wget
echo "$DEBUG_PFX Downloading SPAdes tar.gz..."
wget http://cab.spbu.ru/files/release3.15.5/SPAdes-3.15.5-Linux.tar.gz

# unpack tarball
echo "$DEBUG_PFX Unpacking tar.gz..."
tar -xzf SPAdes-3.15.5-Linux.tar.gz
rm SPAdes-3.15.5-Linux.tar.gz

echo "$DEBUG_PFX Finished."
