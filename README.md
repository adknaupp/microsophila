# microsophila

# How does this pipeline work?

This pipeline uses SRATools to pull reads from NCBI. It then uses Bowtie2 to filter out host contamination from these reads. After the filtering, it uses MetaPhlAn to identify the origin of the reads. The pipeline also includes python scripts that turn MetaPhlAn's output into readable graphs. 

# Getting started:

## Step 0: pick environment and set environment variables

To run microsophila, the you need to create two environment variables and update your PATH variable. The value the first variable depends on where you have installed the microsophila repository. We recommend choosing your home directory as the "install" location. The second variable (the "storage path") should be on a device with lots of space. If you are using the BYU ORC cluster, we recommend using your "compute" directory. If this works for you, to set the environment variables, simply add the following lines to your bashrc:  

export MICROSOPHILA_STORAGE_PATH="\~/compute"  
export MICROSOPHILA_INSTALL_PATH="\~"  
export PATH="$PATH:$MICROSOPHILA_INSTALL_PATH/bowtie2"  

Otherwise, just replace the values of the variables to fit your requirements.  

Your home directory is a good place to set as the install path. If you want, the storage and install paths can be the same. Once your .bashrc contains these lines, don't forget to "source" it (e.g. source ~/.bashrc).

## Step 1: clone repo

git clone https://github.com/adknaupp/microsophila.git  

## Step 2: run script "microsophila_install.sh"

The install script checks that you have exported the variables from step 1 before proceeding to install sratools, bowtie2, and MetaPhlAn (as well as the respective dependencies of each). This script may take upwards of 90 minutes to run.

## Common errors:

### Permission denied for "setup_filename.sh":

If this error pops up during the execution of microsophila_install.sh, then the bash script doesn't have the appropriate permissions to execute the other bash scripts it's calling. Execute "chmod755 setup_filename.sh" on each file that had its permission denied.

### Failed to build numpy / ERROR: Could not build wheels for numpy which use PEP 517 and cannot be installed directly

This is caused by an error with pip, which appears to be a versioning error. Be sure that your pip version is up to date and that your virtual environment started properly. If the error persists, run "pip install --upgrade pip".

## Step 3: run script "create_dummy_accession.sh"

To avoid having to generate real data, this script creates a child directory of $MICROSOPHILA_STORAGE_PATH to use for testing. So far, it contains some empty directories and a MetaPhlAn profile file.

# Using the Pipeline

## Main Pipeline

The main script is "microsophila_pipeline.sh", which accepts a single argument: the accession number. You must give microsophila_pipeline.sh a valid NCBI accession number, which typically begins with "SRR". An example accession is SRR1525774.

ex: "bash microsophila_pipeline.sh SRR1525774"

Running the full pipeline may take several hours. The pipeline has several stages:
* First, it download the reads for the accession, and stores them in the storage folder specified in the ~/.bashrc. These files are stored as a prefetch.
* Second, it calls fasterq-dump on the prefetch files, turning them into fastq files.
* Third, it calls Bowtie2 to remove host contamination from those reads.
* Finally, it calls MetaPhlAn on the filtered reads to determine their species.

## Generating the Graph

The main script for generating the graph is figure_2.py. Currently, figure_2.py operates using the sample MetaPhlAn outputs stored in the "test" directory as its inputs, although it can be run on any valid output file (or files) from MetaPhlAn. figure_2.py current generates two things:

* Data about the relative species composition of the reads
* A graph displaying that information.

figure_2.py currently does not accept arguments. To run it, simply use "python figure_2.py", which will generate the data files and put them in the local directory. To see the graphs, we recommend running the program in a Jupyter notebook or other IDE. Note that figure_2.py requires both matplotlib and numpy. The pipeline process should automatically install both, but if figure_2.py is moved to a new environment, be sure both dependencies are properly set up.
