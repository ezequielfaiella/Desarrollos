#! /bin/bash
cd /media/ezequiel/65F7-5F47/mp3/
for i in *.aac ; do
	ffmpeg -i inputfile.m4a -c:a libmp3lame -ac 2 -b:a 190k outputfile.mp3
done