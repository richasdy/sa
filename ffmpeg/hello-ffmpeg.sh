#!/bin/bash
# https://sanchi.forkroad.xyz/post/2018-03-27-ffmpeg-1-%E5%8E%9F%E7%90%86-FFmpeg%E5%9F%BA%E7%A1%80%E5%91%BD%E4%BB%A4.html
# https://sanchi.forkroad.xyz/post/2018-03-27-ffmpeg-2-%E6%A6%82%E5%BF%B5-%E5%B8%A7%E7%8E%87%E6%AF%94%E7%89%B9%E7%8E%87%E6%96%87%E4%BB%B6%E5%A4%A7%E5%B0%8F.html
# https://sanchi.forkroad.xyz/post/2018-03-27-ffmpeg-3-%E4%BD%BF%E7%94%A8-FFmpeg%E8%B0%83%E6%95%B4%E6%96%87%E4%BB%B6%E5%B0%BA%E5%AF%B8.html
# https://sanchi.forkroad.xyz/post/2018-03-27-ffmpeg-4-%E4%BD%BF%E7%94%A8-FFmpeg%E8%A7%86%E9%A2%91%E8%A3%81%E5%89%AA.html
# https://sanchi.forkroad.xyz/post/2018-03-27-ffmpeg-5-%E4%BD%BF%E7%94%A8-FFmpeg%E8%A7%86%E9%A2%91%E9%97%B4%E8%B7%9D.html
# https://www.mankier.com/1/ffmpeg-filters

# FFmpeg basic commands
ffmpeg -version
# the video usage transposeinstruction 90 degrees clockwise
ffplay -f lavfi -i testsrc -vf transpose=1
ffplay -f lavfi -i testsrc -filter transpose=1
ffplay -f lavfi -i testsrc -af transpose=1
ffplay -f lavfi -i testsrc -filter_complex "transpose=1"
ffplay -f lavfi -i testsrc -vf transpose=1
ffplay -f lavfi -i testsrc -vf transpose=2
ffplay -f lavfi -i testsrc -vf transpose=3
ffplay -f lavfi -i testsrc -vf transpose=4
ffplay -f lavfi -i testsrc
# atempoSlow down the input audio speed usage instruction to 80%
ffmpeg -i input.mp3 -af atempo=0.8 output.mp3
# split, double width, flip copy, overlay after 
ffplay -f lavfi -i rgbtestsrc -vf split[a][b];[a]pad=2*iw[1];[b]vflip[2];[1][2]overlay=w
# video from A, audio from B, subtitle from C
ffmpeg -i A.mov -i B.mov -i C.mov -map 0:v:0 -map 1:a:0 -map 2:s:0 clip.mov

# all stream from both file
ffmpeg -i A.mov -i B.mov -map 0 -map 1 clip.mov
# subtitle from C, video and audio from A
ffmpeg -i A.mov -i B.mov -map 0:s:0 -map 1:v:0 -map 1:a:0  clip.mov
# video from B, subtitle from A, no audio
ffmpeg -i A.mov -i B.mov -map 0:v:1 -map 1:s:0 -an clip.mov
ffmpeg -i A.mov -i B.mov -map 0:v:0 -map 0 -map 1 -map -0:v:0 -map -0:a:1 clip.mov

# output a TV without signal interface
ffplay -f lavfi -i smptebars
# output a blue interface.
ffplay -f lavfi -i color=c=blue
ffmpeg -version # version
ffmpeg -bsfs # Display the built-in bitstream filter
ffmpeg -codecs # Show all codecs
ffmpeg -decoders # Show all decoders
ffmpeg -encoders # Show all decoders
ffmpeg -filters # Show all available built-in filters
ffmpeg -formats # Display all supported audio and video formats
ffmpeg -layouts # Display all available audio channel layouts
ffmpeg -L # Show ffmpeg protocol
ffmpeg -pix_fmts # Display all available pixel formats
ffmpeg -protocols # Show all supported protocols
ffmpeg -sample_fmts # Display all audio sample formats

# https://www.mankier.com/1/ffmpeg-filters
ffmpeg -i INPUT -vf "split [main][tmp]; [tmp] crop=iw:ih/2:0:0, vflip [flip]; [main][flip] overlay=0:H/2" OUTPUT


# FFmpeg Bit Rate Frame Rate File Size
ffmpeg -i input.avi -r 30 output.mp4
ffmpeg -i clip.mpg -vf fps=fps=25 clip.webm
ffmpeg -i input.avi -r 29.97 output.mpg
ffmpeg -i input.avi -r 30000/1001 output.mpg
ffmpeg -i input.avi -r ntsc output.mpg

# -b
# -b:v
# -b:a
ffmpeg -i film.avi -b 1.5M film.mp4
ffmpeg -i input.avi -b:v 1500k output.mp4
# CBR
ffmpeg -i in.avi -b 0.5M -minrate 0.5M -maxrate 0.5M -bufsize 1M out.mkv
# Set the maximum size of the output file
fmpeg -i in.avi -fs 10MB out.mp4
# video_size = video_bitrate * time_in_seconds / 8
# audio_size = sampling_rate * bit_depth * channels * time_in_seconds / 8
# audio_size = bitrate * time_in_seconds / 8

# file_size = video_size + audio_size 
# file_size = (video_bitrate + audio_bitrate) * time_in_seconds / 8 
# file_size = (1500 kbit / s + 128 kbits / s) * 600 s 
# file_size = 1628 kbit / s * 600 s 
# file_size = 976800 b / 8 = 122100000 B / 1024 = 119238.28125 KB 
# file_size = 119238.28125 KB / 1024 = 116.443634033203125 MB ≈ 116.44 MB

# FFmpeg to adjust file size
ffmpeg -i input.avi -s 640x480 output.avi
ffmpeg -i input.avi -s vga output.avi
ffmpeg -i phone_video.3gp -vf super2xsai output.mp4
ffmpeg -i input.mpg -s 320x240 output.mp4
ffmpeg -i input.mpg -vf scale=320:240 output.mp4
ffmpeg -i input.mpg -vf scale = iw / 2: ih / 2 output.mp4 # Equal scale 1/2
ffmpeg -i input.mpg -vf scale = iw * 0.9: ih * 0.9 output.mp4 # Equal scale 90% 
ffmpeg -i input.mpg -vf scale = iw / PHI: ih / PHI output.mp4 # Scale in golden ratio: PHI = 1.61803398874989484820 ...
ffmpeg -i input.mpg -vf scale=400:400/a output.mp4
ffmpeg -i input.mpg -vf scale=300/a:300 output.mp4

# FFmpeg video crop
# ffmpeg -i input -vf crop = iw / 3: ih: 0: 0 output 
# ffmpeg -i input -vf crop = iw / 3: ih: iw / 3: 0 output 
# ffmpeg -i input -vf crop = iw / 3: ih: iw / 3 * 2: 0 output
ffmpeg -i input.mpg -vf crop=iw/2:ih/2 output.mp4

# to crop the output without black.
ffmpeg -i input.mp4 -vf cropdetect=limit=0 output.mp4

# fmpeg has a testsrcvideo called built-in , we can ffplay -f lavfi -i testsrcplay it by command. His default size is 320x240 pixels, the number 0 of the initial timer is 29x52 pixels, and his position is 256 pixels from the upper left corner in the horizontal direction and 94 pixels in the vertical direction. 
ffmpeg -f lavfi -i testsrc -vf crop=29:52:256:94 -t 10 timer1.mpg

# FFmpeg video pitch
ffmpeg -i photo.jpg -vf pad=860:660:30:30:pink framed_photo.jpg

# some playback devices only support 16: 9 size, if we have a 4: 3 video, you can add padding in the horizontal direction, without adding in the vertical direction, output a 16: 9 video
ffmpeg -i input -vf pad=ih*16/9:ih:(ow-iw)/2:0:color output

# ow that the 4: 3 video has been enlarged to 16: 9, how to reverse the operation and convert the 16: 9 video to 4: 3? Don't panic, the horizontal width does not change, and the vertical height becomes 3/4 of the original file width.
ffmpeg -i input -vf pad=iw:iw*3/4:0:(oh-ih)/2:color output