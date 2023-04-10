# microsophila

## getting started

### Step 0: pick environment and set environment variables

To run microsophila, the you need to create two environment variables and update your PATH variable. The value the first variable depends on where you have installed the microsophila repository. We recommend choosing your home directory as the "install" location. The second variable (the "storage path") should be on a device with lots of space. If you are using the BYU ORC cluster, we recommend using your "compute" directory. If this works for you, to set the environment variables, simply add the following lines to your bashrc:  

export MICROSOPHILA_STORAGE_PATH="\~/compute"  
export MICROSOPHILA_INSTALL_PATH="\~"  
export PATH="$PATH:$MICROSOPHILA_INSTALL_PATH/bowtie2"  

Otherwise, just replace the values of the variables to fit your requirements.  

Your home directory is a good place to set as the install path. If you want, the storage and install paths can be the same. Once your .bashrc contains these lines, don't forget to "source" it (e.g. source ~/.bashrc).

### Step 1: clone repo

git clone https://github.com/adknaupp/microsophila.git  

### Step 2: run script "microsophila_install.sh"

The install script checks that you have exported the variables from step 1 before proceeding to install sratools, bowtie2, and MetaPhlAn (as well as the respective dependencies of each).

### Step 3: run script "create_dummy_accession.sh"

To avoid having to generate real data, this script creates a child directory of $MICROSOPHILA_STORAGE_PATH to use for testing. So far, it contains some empty directories and a MetaPhlAn profile file.
