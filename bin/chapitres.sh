#!/bin/bash

find textes_des_reglements/ -name '*md' -exec cat '{}' ';'  | tr '\n' '|' | sed 's/|# Article/\n|# Article/g' | sed 's/|\(chapitre\|titre\|section\|PREMIEREPARTIE\|DEUXIEME PARTIE\|TROISIEME PARTIE\)/\n \1/gi'  | grep -v '^|' | while read line ; do 
	cleaned=$(echo $line | sed 's/||*/ /g' | sed 's/ $//' )
	echo 's/'$line'/||# '$cleaned'||/g;';
done | sort -ur | grep -v "création d'une commission d'enquête ou de contrôle par l'Assemblée résulte"  > /tmp/chapitre.sed

echo 's/Dispositions diverses\./# Dispositions diverses/' >> /tmp/chapitre.sed
echo 's/Dispositions transitoires\./# Dispositions transitoires/' >> /tmp/chapitre.sed


find textes_des_reglements/ -name '*md' | while read txt ; do
	cat $txt | tr '\n' '|' | sed -f /tmp/chapitre.sed | sed 's/||*/\n\n/g' | sed 's/# Article/## Article/' | sed 's/CHAPITRE XXI # Dispositions/CHAPITRE XXI Dispositions/' > $txt"."$$
	mv $txt"."$$ $txt
done

#rm /tmp/chapitre.sed
