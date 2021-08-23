#!/bin/bash

BIN="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
$BIN/how-much-data.sh
if [ $? -ne 0 ]; then
  exit 1;
fi

while IFS="" read -r drive; do

  echo ""

  SIZE=$(echo $drive  | cut -d ' ' -f 2)
  USED=$(echo $drive  | cut -d ' ' -f 3)
  FREE=$(echo $drive  | cut -d ' ' -f 4)
  PERC=$(echo $drive  | cut -d ' ' -f 5 | sed 's/%//')
  SHARE=$(echo $drive | cut -d ' ' -f 6 | sed 's_.*/__')

  if [ $PERC -lt 50 ]; then
    echo -e '\033[0;32m' $SHARE": "$PERC"% of "$SIZE" are used. Used: "$USED". Available: "$FREE '\033[0m'
  elif [ $PERC -lt 80 ]; then
    echo -e '\033[0;36m' $SHARE": "$PERC"% of "$SIZE" are used. Used: "$USED". Available: "$FREE '\033[0m'
  elif [ $PERC -lt 90 ]; then
    echo -e '\033[1;34m' $SHARE": "$PERC"% of "$SIZE" are used. Used: "$USED". Available: "$FREE '\033[0m'
  elif [ $PERC -lt 95 ]; then
    echo -e '\033[1;31m' $SHARE": "$PERC"% of "$SIZE" are used. Used: "$USED". Available: "$FREE '\033[0m'
  else
    echo -e '\033[7;31m' $SHARE": "$PERC"% of "$SIZE" are used. Used: "$USED". Available: "$FREE '\033[0m'
  fi

  echo ""

done < $HOME/.drives-storage.log

exit 0
