#!/bin/bash

set -eu

# First, the list of people and facts is read,
N=$(cat people.txt | head -n 1)
NAMES=$(cat people.txt | head -n $((N + 1)) | tail -n $N)
NUM_LINES=$(cat people.txt | wc -l)
FACTS=$(cat people.txt | tail -n $((NUM_LINES - N - 1)))

# clean names up
NAMES=$(echo "$NAMES" | sed -E -e 's/[*!#/@0-9]//g' | tr '[A-Z]' '[a-z]')

# Second, some people are filtered away from the list,

# A-H
#NAMES=$(echo "$NAMES" | grep -v -E "^.{1,4}$")
# I-P
#NAMES=$(echo "$NAMES" | grep -v -E "^.{5}")
# Q-Z
#NAMES=$(echo "$NAMES" | grep -v -E "^[aeiou]")

for person_name in $NAMES ; do
	person_facts=$(echo "$FACTS" | grep -i "$person_name")

	# Then, the list of facts of each person is manipulated,

	# A-H
	#person_facts=$(echo "$person_facts" | sed -E "s/$person_name/THIS FUNNY PERSON/g")
	# I-P
	#if echo $person_name | grep -Eq "^[aeiou]" ; then
	#	person_facts=$(echo "$person_facts" | sed -E "s/$person_name/THIS WISE PERSON/g")
	#fi
	# Q-Z
	#name_new=$(echo "$person_name" | sed -E -e 's/^./A/' -e 's/.$/Z/')
	#person_facts=$(echo "$person_facts" | sed -E "s/$person_name/$name_new/g")

	# Last, a "facts file" is created for each person.
	num_facts=$(echo "$person_facts" | wc -l)
	echo "$person_name" > "facts-$person_name.txt"
	echo "$person_facts" >> "facts-$person_name.txt"
	echo "$num_facts" >> "facts-$person_name.txt"
done