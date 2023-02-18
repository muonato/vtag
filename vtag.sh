#!/bin/bash
# muonato/vtag @ GitHub (AUG-2021)
# 
# Adds running time overlay to video file, using
# date argument or filesystem timestamp of video
#
# Parameters: vtag.sh <filename> [start time]
#	1: Path to input video file
#	2: Start time in format dd/mm/yyyy hh:mm:ss
#		- Using file timestamp when omitted
# Examples:
#	vtag.sh my_video.avi 17/02/2023\ 14:50:00
#	= starts overlay from 17-FEB-2023 at 14:50
#
#	vtag.sh my_video.avi
#	= starts overlay from file modified time
#
FONTSIZE=64
FONTCOLOR=yellow

is_ffmpeg=$(ffmpeg -version|grep -o "ffmpeg")

if [[ -z $is_ffmpeg ]]; then
    echo "missing ffmpeg, try 'apt install ffmpeg' maybe ?"
    exit
fi

if [[ -f "$1" ]]; then
    is_video=$(file $1 | grep -o -e ", video")
else
    echo "missing input file"
fi

if [[ -z $is_video ]]; then
    echo "missing video header"
    exit
fi

if [[ -z $2 ]]; then
    epoch=$(stat -c %Y $1)
    echo "adding filesys timestamp overlay on '$1'"
else
    epoch=$(date -d "$2" +"%s")
    echo "adding video start @ '$2' overlay on '$1'"
fi

sleep 3

ffmpeg -y -i $1 -vf drawtext="\
	fontsize=$FONTSIZE:\
	fontcolor=$FONTCOLOR:\
	text='%{pts\:localtime\:$epoch}'"\
	vtag_${1}
