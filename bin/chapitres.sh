#!/bin/bash

find textes_des_reglements/ -name '*txt' -exec cat '{}' ';'  | tr '\n' '|' | sed 's/|Article/\n|Article/g' | sed 's/|\(chapitre\|titre\|section\|PREMIEREPARTIE\|DEUXIEME PARTIE\|TROISIEME PARTIE\)/\n\1/gi'  | grep -v '^|' | while read line ; do 
	cleaned=$(echo $line | sed 's/||*/ /g' | sed 's/ $//' )
	echo 's/|'$line'/||'$cleaned'||/g;';
done > /tmp/chapitre.sed

find textes_des_reglements/ -name '*txt' | while read txt ; do
	cat $txt | tr '\n' '|' | sed -f /tmp/chapitre.sed | sed 's/||*/\n\n/g' > $txt"."$$
	mv $txt"."$$ $txt
done

rm /tmp/chapitre.sed
