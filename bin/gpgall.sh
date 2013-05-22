#!/usr/bin/env bash

# i wouldn't think the ifs setting would live past the script,
# but this SAVEIFS stuff was in the template I used
SAVEIFS=$IFS

# set IFS to support bash loops given filenames with spaces
IFS=$(echo -en "\n\b")

for i in $* ; do 
for f in $(find $i -type f) ; do
gpg --encrypt --recipient awaxa "$f"
done
done
IFS=$SAVEIFS
