#!/usr/bin/env bash

# i wouldn't think the ifs setting would live past the script,
# but this SAVEIFS stuff was in the template I used
SAVEIFS=$IFS

# set IFS to support bash loops given filenames with spaces
IFS=$(echo -en "\n\b")

for i in $* ; do 
  cp -a "$i" "$i-goats"
  cd "$i-goats"
  for d in $(find . -type d)
  do
    # rmdir fails unless the dir is empty
    rmdir "$d"
  done
  tar czvf ../$i.tar.gz *
  tar tvzf ../$i.tar.gz | gzip -c > ../$i.list.gz
  cd ..
  for p in "$i.tar.gz" "$i.list.gz"
  do
    gpg --encrypt --recipient 'awaxa' "$p"
  done
  rm -rf "$i-goats" "$i.tar.gz" "$i.list.gz"
done
IFS=$SAVEIFS
