#!/usr/bin/env bash
#
# wrapper shell script
# copyright: @indianets
#

[[ -z $2 ]] && { echo "Usage: $(basename $0) zipfile partitions OR $(basename $0) zipfile --list"; exit 1; }

workdir="$PWD"
tooldir="$(dirname $0)"

[[ -f $workdir/$1 ]] || { echo "$1 is not a file"; exit 1; }

echo Extracting payload.bin ..
unzip $workdir/$1 payload.bin
[[ -f $workdir/payload.bin ]] || { echo "Failed extracting payload.bin from zip"; exit 1; }

if [[ $2 = "--list" ]]; then
  $tooldir/extract.py $workdir/payload.bin --list_partitions
else
  shift
  $tooldir/extract.py $workdir/payload.bin --output_dir $workdir --partitions $@
  for part in $@; do
    if [[ -e $part ]]; then
      mv $part $part.img
      ls -l $part.img
    fi
  done
fi

echo Deleting payload.bin ..
rm $workdir/payload.bin
