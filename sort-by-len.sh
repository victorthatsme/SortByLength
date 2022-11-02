#!/bin/bash
set -eu

FILE=$1
#First off i'm getting the first name in the list
LIST=$(cat $FILE)
FIRST_NAME=$(cat $FILE | head -n 1)
WORDCOUNT=$(cat $FILE | wc -w)

if (echo $FIRST_NAME | grep -Eq "^[aeiou]") ; then

#VOWEL is true
VOWEL=true
# echo "vowel"; 
else
VOWEL=false
fi

for ((word=1; word<=$WORDCOUNT; word++)) do
    newword=$(echo $LIST | sed -n "$word"p $FILE)
    numword=$(echo ${#newword})
    if (($word==1)) ; then
    echo "$numword $newword" > "tmp.txt"
    else
    echo "$numword $newword" >> "tmp.txt"
    fi
done

NUM_WORD_LIST=$(cat ./tmp.txt);
echo "$NUM_WORD_LIST" | sort -r -n > "tmp.txt"
#If VOWEL is true, then
sleep 3
if $VOWEL ; then 
    echo "$(cat ./tmp.txt)" | head -n 10 > "words-sorted.txt"
else
    echo "$(cat ./tmp.txt)" | head -n 15 > "words-sorted.txt"
fi
rm ./tmp.txt