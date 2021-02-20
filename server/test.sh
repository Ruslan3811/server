#!/bin/bash
if [ $1 = "on" ]; then
    sed -i '18s/off/on/' ./default
fi
if [ $1 = "off" ]; then
    sed -i '18s/on/off/' ./default
fi