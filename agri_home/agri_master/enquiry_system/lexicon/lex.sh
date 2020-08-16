#!/bin/bash

for i in `seq $1 $2`; do
	#line 1
	echo "lex$i Done"
	echo "\$sil = SIL;" > lex$i/syntax
	
	#line 2
	echo -n "\$kw = " >> lex$i/syntax
	
	lines=`cat lex$i/dictionary | cut -d " " -f1 | sort | uniq | wc -l` 
	word=""
	for j in `seq 1 $lines`; do
		checkword=`cat lex$i/dictionary | cut -d " " -f1 | sort | uniq | head -$j | tail -1 `
		if [ $checkword != "SIL" ]; then
			word="$word `cat lex$i/dictionary | cut -d " " -f1 | sort | uniq | head -$j | tail -1`"
			word="$word | "
		fi		
	done
	
	sendword=${word::-3}
	sendword="$sendword;"
	echo $sendword >> lex$i/syntax
	
	#line3
	echo "(<\$sil> (\$kw) <\$sil>)" >> lex$i/syntax
	
	#HParse for Network
	HParse lex$i/syntax lex$i/network
done
