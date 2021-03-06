#!/bin/bash

#    ytchannel.bash - interactive cli program to choose play and YouTube videos from given channel with mpv
#    Copyright (C) 2016  /u/procoder1337
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# REQUIRED PACKAGES: lynx mpv

# USAGE: ytchannel [YouTube channel]

# EXAMPLE: "ytchannel druaga1" will give you a list of Druaga's newest videos to choose from

# Empty and recreate the cache directory
rm -rf "/home/$USER/.cache/ytchannel/"
mkdir -p "/home/$USER/.cache/ytchannel/channels/$1"

# Get the video titles
lynx --dump "https://youtube.com/user/$1/videos" | grep "Duration" > "/home/$USER/.cache/ytchannel/channels/$1/titles.txt"

# Get the video urls
lynx --dump "https://youtube.com/user/$1/videos" | grep "https://www.youtube.com/watch?v=" > "/home/$USER/.cache/ytchannel/channels/$1/urls.txt"

# Print 20 first video titles for the user to choose from
#~ head "~/.cache/ytchannel/channels/$1/titles.txt" -n 20 --quiet
cat "/home/$USER/.cache/ytchannel/channels/$1/titles.txt"

# Prompt the user for video number
read -p "Choose a video: " titlenumber

# Play the video with mpv
mpv $(grep $titlenumber  "/home/$USER/.cache/ytchannel/channels/$1/urls.txt" | awk '{print $2}') # grep is not needed here but I'm lazy

# Empty and recreate the cache directory
rm -rf "/home/$USER/.cache/ytchannel/"

