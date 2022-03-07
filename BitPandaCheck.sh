#!/bin/bash

## Usage : ./BitPandaCheck.sh "AMZN,GOOGL,AAPL"
link="https://api.bitpanda.com/v2/assets/prices?assetIds="
input=$1
onlyComma="${input//[^,]}"
nComma=${#onlyComma}
allLines=""

for i in `seq 1 $((nComma+1))`
do
	current=$(echo "${input}" | cut -d',' -f${i})
	fullLine=$(grep ${current} ./BitPanda_all_id.txt)
	id=$(echo $fullLine | cut -d';' -f3)
	link="$link$id,"
	allLines="$allLines|$fullLine"
done
echo "AllLine :: $allLines"
link="$link&page_size=$((nComma+1))"
echo $link
tmpfile=$(mktemp /tmp/BitPandaOut.script_.XXXXXX)
tmpfile2=$(mktemp /tmp/BitPandaOut2.script_.XXXXXX)
curl $link -o $tmpfile
sed -i -e 's/{"type":"asset","attributes":{"price":"/\n/g' $tmpfile
sed -i -e 's/","price_changes":{"day":"/,/g' $tmpfile
sed -i -e 's/","week":"/,/g' $tmpfile
sed -i -e 's/","month":"/,/g' $tmpfile
sed -i -e 's/","year":"/,/g' $tmpfile
sed -i -e 's/"},"circulating_supply":"/,/g' $tmpfile
sed -i -e 's/"},"/\n/g' $tmpfile
cat $tmpfile | grep -v '"' > $tmpfile2
echo "Id, Name, Price, Daily Price Change, Weekly Price Change, Monthly Price Change, Yearly Price Change, Circulating Supply"

iterator=2
while read Line
do
	currentLine=$(echo $allLines | cut -d'|' -f$iterator)
	currentCred=$(echo $currentLine | cut -d';' -f1)
	currentName=$(echo $currentLine | cut -d';' -f2)
	currentLine="$currentCred,$currentName,$Line"
	echo $currentLine
	iterator=$((iterator+1))
done < $tmpfile2