#!/bin/bash

read -p "Enter host to ping: " HOST
FAILS=0

while true
do
    RESULT=$(ping -c 1 -W 1 "$HOST")
    TIME=$(echo "$RESULT" | grep -oE 'time=([0-9]+(\.[0-9]+)?)' | cut -d= -f2)

    if [ -n "$TIME" ]; then
        # успех — сбрасываем счётчик таймаутов
        FAILS=0

        if (( $(echo "$TIME > 100" | bc -l) )); then
            echo "WARNING: $TIME ms (>100)"
        else
            echo "ok: $TIME ms"
        fi
    else
        FAILS=$((FAILS+1))
        echo "No reply ($FAILS in a row)"
        if [ $FAILS -ge 3 ]; then
            echo "ERROR: 3 timeouts in a row"
            FAILS=0     # чтобы не спамило каждую секунду
        fi
    fi

    sleep 1
done

