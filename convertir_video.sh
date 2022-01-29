#!/bin/bash
# unir
#cat *.VOB > incas.vob
ffmpeg -y -i $1 -c:v copy -c:a copy $1.mp4
