#!/bin/bash

echo "Information on drive space:"
df -h

echo -e "\nTop 10 resourse consumable processes:"
ps aux --sort=-$mem | head -n 11

echo -e "\nFirst 5 rows of the top's output:"
top -b -n 1 | head -n 5

echo -e "\nInformation on RAM:"
free -h

echo -e "Infromation on CPU's usage:"
uptime

echo -e "\nInformation on CPU:"
lscpu

echo -e "\nInformation on GPU:"
lspci | grep VGA