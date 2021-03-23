#!/bin/bash

ffplay -f lavfi -i color=c=white -vf drawtext=fontfile=/Windows/Fonts/arial.ttf:text=Welcome
# sama kyk fplay
ffmpeg -f lavfi -i rgbtestsrc -pix_fmt yuv420p -f sdl Example
ffmpeg -f lavfi -i rgbtestsrc -pix_fmt yuv420p -vf split[a][b];[a]pad=2*iw[1];[b]vflip[2];[1][2]overlay=w -f sdl Example

# SI prefixes available in FFmpeg
ffmpeg -i input.avi -b:v 1500000 output.mp4
ffmpeg -i input.avi -b:v 1500K output.mp4
ffmpeg -i input.avi -b:v 1.5M output.mp4
ffmpeg -i input.avi -b:v 0.0015G output.mp4
ffmpeg -i input.mpg -fs 10MB output.mp4

ffplay -f lavfi -i testsrc -vf transpose=1
ffmpeg -i input.mp3 -af atempo=0.8 output.mp3

# Filters, filterchains and filtergraphs
ffmpeg -i input.mpg -vf hqdn3d,pad=2*iw output.mp4
ffmpeg -i output.mp4 -i input.mpg -filter_complex overlay=w compare.mp4
# Using a filtergraph with the link labels, sufficient is only 1 command:
ffplay -i i.mpg -vf split[a][b];[a]pad=2*iw[A];[b]hqdn3d[B];[A][B]overlay=w
ffplay -f lavfi -i rgbtestsrc -vf split[a][b];[a]pad=2*iw[A];[b]hqdn3d[B];[A][B]overlay=w
ffplay -f lavfi -i rgbtestsrc -vf split[a][b];[a]pad=2*iw[1];[b]vflip[2];[1][2]overlay=w
ffplay -f lavfi -i testsrc -vf split[a][b];[a]pad=2*iw[A];[b]hqdn3d[B];[A][B]overlay=w