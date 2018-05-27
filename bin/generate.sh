unzip origin/textes_des_reglements.zip
mv 'textes des règlements' textes_des_reglements
mv 'textes_des_reglements/2nd Empire'  textes_des_reglements/001_2nd-Empire
mv 'textes_des_reglements/III° République'  textes_des_reglements/003_IIIeme-République
mv 'textes_des_reglements/II° République'  textes_des_reglements/002_IIeme-République
mv 'textes_des_reglements/IV° République'  textes_des_reglements/004-IVeme-République
mv 'textes_des_reglements/V° République'  textes_des_reglements/005-Veme-République


find textes_des_reglements/* -type d | while read rep; do
	cd "$rep" > /dev/null
	rename 's/[_ ]/-/g' *odt
	ls *odt | while read file ; do 
		predate=$(echo $file | sed 's/.*_//' | sed 's/.odt//' | sed 's/1er/1/' | sed 's/°//'); 
		date=$( echo $predate | sed 's/-/ /g' | sed 's/janvier/JAN/i' | sed 's/février/FEB/i' | sed 's/mars/MAR/i' | sed 's/avril/APR/i' | sed 's/mai/MAY/i' | sed 's/juin/JUN/i' | sed 's/juillet/JUL/i' | sed 's/aout/AUG/i' | sed 's/septembre/SEP/i' | sed 's/octobre/OCT/i' | sed 's/novembre/NOV/i' | sed 's/décembre/DEC/i') ; 
		iso=$(date -d"$date" "+%Y%m%d") ;  
		mv $file $iso"_"$predate".odt" ; 
	done
	cd - > /dev/null
done

mv textes_des_reglements/005-Veme-République/_Règlement-provisoire-de-1959.odt textes_des_reglements/005-Veme-République/19590000_Règlement-provisoire-de-1959.odt
mv textes_des_reglements/004-IVeme-République/_Règlement-Assemblées-Constituantes-de-la-IV-République.odt textes_des_reglements/004-IVeme-République/19451122_Règlement-Assemblées-Constituantes-de-la-IV-République.odt
mv ./textes_des_reglements/004-IVeme-République/Règlements*provisoir* ./textes_des_reglements/004-IVeme-République/Règlements_de_l_Assemblée_consultative_provisoire_CFLN-GPRF
mv ./textes_des_reglements/003_IIIeme-République/Règlement* ./textes_des_reglements/003_IIIeme-République/Règlement_provisoire_de_1873

find . -name '*odt' | while read odt ; do 
        txt=$(echo $odt | sed 's/odt$/txt/');
	pandoc $odt -o $txt ; 
        md=$(echo $odt | sed 's/odt$/md/');
	mv "$txt" "$md"
	bash bin/homogenize.sh "$md"
	rm $odt ; 
done 

bash bin/chapitres.sh
