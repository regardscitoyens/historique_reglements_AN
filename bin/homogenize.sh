#!/bin/bash

txt=$1

cat $txt | sed 's/\*\**//g' | sed 's/[\*^]//g' | sed 's/_//g' | sed 's/\\//g'  | sed 's/^[ \.] *//'  | sed 's/^\(Artfide\|Artcile\) /Article /' | sed 's/Art \. /Article /' | sed 's/ \(1\|premi\|I\)er-*/ 1/' | sed 's/Art[^i] */Article /i' | sed 's/^Articles /Article /' | sed 's/^Article\.* \([0-9][0-9\-]*\) *[\.\-\—]* */Article \1\n\n/i' | tr '\n' '|' | sed 's/\([0-9]\)||*\(bis\|ter\)\.*/\1 \2||/gi' | sed 's/|||*/\n\n/g'  | sed 's/|/ /g'  | sed 's/^[—  ]*//' > $txt"."$$
mv $txt"."$$ $txt

