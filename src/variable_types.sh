#!/bin/bash
MY_NAME="Abraham"
MY_AGE=35
MY_NAME_INC=$((MY_NAME + 1))
MY_AGE_INC=$((MY_AGE + 1))
MY_AGE_INC_2=$((++MY_AGE))

echo "Hello, my name is $MY_NAME"
echo "Hello, my name is $MY_NAME_INC"
echo "This year I will be $MY_AGE"
echo "This year I will be $MY_AGE_INC"
echo "This year I will be $MY_AGE_INC_2"
