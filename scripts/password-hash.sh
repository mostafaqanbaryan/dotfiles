#!/bin/bash
echo -n "Please enter your salt: "
read -s salt

printf "\n"
echo -n "Please re-enter your salt: "
read -s saltv

if [ $saltv != $salt ]; then
    printf "\nError: Salts do not match"
    exit 1
fi

printf "\n"

echo -n "Please enter password: "
read -s pass

printf "\n"
echo -n "Please re-enter password: "
read -s passv

if [ $passv != $pass ]; then
    printf "\nError: Passwords do not match"
    exit 1
fi

printf "\n"
echo $passv | argon2-cli "$salt" -id -t 10 -k 512000 -p 4 -l 8192 -e
