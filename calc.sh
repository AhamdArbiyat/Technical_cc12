#!/bin/bash

#This section is about declaring varibles to store arguments inside each varibale
n1=$1
n2=$2
operation=$3

#this is the core of the script where it checks teh value of the varibale operation and decide upon it what to do.
#if it's --addition it will add n1 + n2 and store the result in output varibale.
#if it's --deletion then it will subtract n1 - n2 and stores the result in output varibale.
#if it's nither --deletion or --addition then the script will print an error message "Invalid input" and it will exit immedaitly with status 1 (means failure), so the script nerver runs.

if [ "$operation" = "--addition" ]
then
    output=$((n1 + n2))
elif [ "$operation" = "--deletion" ]
then
    output=$((n1 - n2))
else
    echo "Invalid operation"
    exit 0
fi

#When a valid input comes, this sction put it in two ways, first it will print it out on the terminal so the user can see it, and second it will write to the file called output.txt

echo "$output"
echo "$output" > output.txt
