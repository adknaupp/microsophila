#!/bin/bash
#!/bin/sh 
cd Pipeline
mkdir Reads 
# running ReadTaxon.perl generates a file with contents similar to above ^^^ called "GenerateSimulatedData.sh"

# several of the lines above display instances of what is hopefully a single logic error.
# I believe this is because the script was written to parse an earlier version of a metaphlan "profile.txt" file 
# e.g. of the error: line 11 (above) "WolbachiaPipientis|t.fa" 
# looks to me like they're meaning to isolate a species name, but an extra bit '|t' gets grabbed.


fileIn=$1
fileOut="GenerateSimulatedData.sh"
taxon=()
index=0
array=()
array2=()
array3=()
path=$2
pathDWGSIM=$3
cov=$4

# get all lines from input file (metaphlan profile) containing "s__"
# I suppose "s__" is the prefix of a species, so we want to ultimately
# extract species names, as well as other values, like (probably) relative abundance, etc.
num_taxa=0
max_taxa=20
while read -r line; do
  if [[ $line =~ s__ ]]; then
    taxon+=("$line")
  fi
  num_taxa=$((num_taxa+1))
  if [[ $num_taxa -gt $max_taxa ]]; then
    break # only take the top 20 taxa
  fi
done < "$fileIn"

# parse lines collected above from metaphlan profile (see above for details of line contents).
# with parsed out data, assemble a dwgsim command for each of the taxa
# also, build a string consisting of space-delimited paths to the reference
# genome of each of the taxa
dwgsim_cmds=()
references=""
for ((index=0; index<${#taxon[@]}; index++)); do
  # FIXME: something in the next 3 lines is the culprit
  array=($(echo "${taxon[$index]}" | awk -F"__" '{print $1, $8}'))
  array2=($(echo "${array[1]}" | awk -F"\t" '{print $1, $2}'))
  array3=($(echo "${array2[0]}" | awk -F"_" '{print $1, $2}'))
  # assemble a dwgsim command
  dwgsim_cmds+=("./$pathDWGSIM/dwgsim -1 80 -2 80 -e 0.01 -E 0.01 -C $((array2[1]*cov)) $path/ReferenceGenome/${array3[0]}${array3[1],,}.fa $path/Reads/${array3[0]}${array3[1],,}")
  # add the reference for this species for concatenation with others
  # FIXME: reference genomes will be stored somewhere else. modify the next line accordingly.
  references="$references $path/ReferenceGenome/${array3[0]}${array3[1],,}.fa"
done

# write the "GenerateSimulatedData.sh" file
touch $fileOut
echo "#!/bin/sh" >> $fileOut
echo "cd $path" >> $fileOut
echo "mkdir Reads" >> $fileOut
for cmd in ${dwgsim_cmds[@]}; do
  echo "$cmd" >> $fileOut
done
echo "cat $references > ReferenceGenomes.fasta" >> $fileOut
