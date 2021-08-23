#!/bin/bash

if [ ! -e $HOME/.drives-to-monitor ]; then
  echo ""
  echo "no drives to monitor"
  echo "if you want to monitor some drives, i.e. how much space is left,"
  echo "add some mountpoint names to $HOME/.drives-to-monitor"
  echo "names should be greppable from 'df -h'"
  echo ""
  exit 1
fi

rm -f $HOME/.drives-storage.log

while IFS="" read -r drive; do

  df -h | grep $drive | tr -s ' ' >> $HOME/.drives-storage.log

done < $HOME/.drives-to-monitor

exit 0
