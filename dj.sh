#Written by lowrez - jesse@lowrez.net

#apt-get install mplayer
#apt-get randomize-lines

musicdir='media/Audio'
cd $musicdir;

while : 
do
#	find . \( -name "*.mp3" -o -name "*.flac" -o -name "*.ogg" \) -print0 | rl -0 | xargs -n 1 -0 mplayer
	find . \( -name "*.mp3" -o -name "*.flac" -o -name "*.ogg" \) -print0 | sort -R -z | mplayer
done