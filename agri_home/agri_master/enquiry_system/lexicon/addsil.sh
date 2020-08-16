for i in `seq 6 42`; do
	if ! grep --quiet SIL lex$i/dictionary; then
		echo "SIL not present in $i"
		echo "SIL SIL" >> lex$i/dictionary
	fi
done
