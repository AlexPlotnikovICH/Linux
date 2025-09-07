#!/bin/bash
BASE="/opt/050525-wde/AlexPlotnikov/HW19"
# 1 - add 100 file random numer
for i in {1..100}
do
    touch "$BASE/1/$RANDOM"
done
# 2 - move even files from 1 to 2
for file in "$BASE/1"/*
do
    name=$(basename "$file")
    if [ $((name % 2)) -eq 0 ]; then
        mv "$file" "$BASE/2/"
    fi
done
