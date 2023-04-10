#!bin/bash/

SPADES_PATH=$1

if [ -z "$SPADES_PATH"]
  then
    echo "No path specified. Defaulting to: \"$PWD/spades/\"."
    SPADES_PATH="$PWD/spades/"
fi    

# create directory if not exists

# wget

# unpack tarball

# config

echo "$SPADES_PATH"
