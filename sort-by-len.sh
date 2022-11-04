#!/bin/bash
# I got this first bit of code from the previous solution given and from what me and some of the other classmates could tell 
# the set command will set options for the whole bash script. the -eu is a shortening of -e and -u and they 
# both seem to help with finding typos and exiting the script if you get an error.
# This could be entirely all wrong, but I didnt see it doing any harm in the final result, so I decided to keep it.
set -eu
# I know I don't need to make a variable for this, but for my own readiability I decided to add it.
FILE=$1
# First off i'm making a variables to read the list, get the first word in the list with the head command and get the total amount of words in the list using the wc command
LIST=$(cat $FILE)
FIRST_WORD=$(cat $FILE | head -n 1)
WORDCOUNT=$(cat $FILE | wc -w)
# Secondly, this checks if the first word in the input file has a vowel as the first character or not and I then store the output for later use.
if (echo $FIRST_WORD | grep -Eq "^[aeiou]") ; then
VOWEL=true
else
VOWEL=false
fi
# I make a for loop for every word in the list by by having it loop from 1 to the amount of words in the list
# I then find the word it's on($word), count the amount of characters are in that word, put them together in a single string and echo it to a new temporary file.
# You can also pipeline the wc command, but from my attempts, this seemed to not work due to the cat command counting new lines(\n) as a character
# and since the last word in the input files doesn't have a new line I found it easier to use ${#parameter} to count each character of the word given
# I found this information on https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html under 3.5.3 Shell Parameter Expansion
for ((word=1; word<=$WORDCOUNT; word++)) do
    newword=$(echo $LIST | sed -n "$word"p $FILE)
    numword=$(echo ${#newword})
    # Initially I wanted to not have a temporary file at all, so I wrote this piece of code which checks if this is the first word in the list and overwrites the words-sorted.txt
    # so that it wouldn't add the words onto an existing "words-sorted.txt" file on multiple uses, but with a temporary file that deletes itself I had no need for it.
    # if (($word==1)) ; then
    # echo "$numword $newword" > "tmp.txt"
    # else
    echo "$numword $newword" >> "tmp.txt"
    # fi
done
# I make a variable that reads the temporary file back, so I can sort it by number(-n) in reverse(-r). -r -n could be shortened to -rn, but again.
# It's' easier for me to read and understand what I've written later when I keep these options seperated.
NUM_WORD_LIST=$(cat ./tmp.txt);
echo "$NUM_WORD_LIST" | sort -r -n > "tmp.txt"
#This is where I make use of the output from the first if and else statements to determine if I should only echo the first 10 or 15 words in the temporary .txt file to the "words-sorted.txt" file.
#If VOWEL is true, then the first word has a vowel at the beginning of the word. If not it has a consonant.
if $VOWEL ; then 
    echo "$(cat ./tmp.txt)" | head -n 10 > "words-sorted.txt"
else
    echo "$(cat ./tmp.txt)" | head -n 15 > "words-sorted.txt"
fi
#Lastly I remove the temporary file.
rm ./tmp.txt