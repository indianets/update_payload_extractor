#!/bin/sh
#
# wrapper shell script
# copyright: @indianets
#

[[ -z $1 ]] || { echo "Usage: $0 partitions OR $0 --list"; exit 1; }

dir="$PWD"
if [[ $1 = --list ]]; then
  $dir/extract.py --list_partitions
else
  $dir/extract.py payload.bin --output_dir $dir --partitions $@
  for part in $@; do
    if [[ -e $part ]]; then
      \mv $part $part.img
      ls -l $part.img
    fi
  done
fi
