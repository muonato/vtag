# Video overlay tag
Adds running time overlay on video file with ffmpeg, using datetime argument or filesystem timestamp of the input file.
```
Parameters: vtag.sh <filename> [start time]
1: Path to input video file
2: Start time in format dd/mm/yyyy hh:mm:ss
- Using file timestamp when omitted

Examples:
vtag.sh my_video.avi 17/02/2023\ 14:50:00
= starts overlay from 17-FEB-2023 at 14:50

vtag.sh my_video.avi
= starts overlay from file modified time
```
