#!/usr/bin/env bash

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for i in $* ; do 
  cp -a "$i" "$i-goats"
  cd "$i-goats"
  for d in $(find . -type d)
  do
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
