# https://video.stackexchange.com/questions/23105/screen-cast-and-capture-video-cam-and-show-both-on-screen-using-ffmpeg

#linux
ffmpeg -video_size 1024x768 -framerate 25 -f x11grab -i :0.0+0,0 output.mp4

#mac
ffmpeg -f avfoundation -list_devices true -i ""
# [AVFoundation input device @ 0x7ffac1e17880] AVFoundation video devices:
# [AVFoundation input device @ 0x7ffac1e17880] [0] FaceTime HD Camera (Built-in)
# [AVFoundation input device @ 0x7ffac1e17880] [1] Capture screen 0
# [AVFoundation input device @ 0x7ffac1e17880] AVFoundation audio devices:
# [AVFoundation input device @ 0x7ffac1e17880] [0] Built-in Input

# ffmpeg -f avfoundation -i "<screen device index>:<audio device index>" output.mkv
#screencapture
ffmpeg -f avfoundation -i "1:0" output.mkv
ffmpeg -f avfoundation -i "1:0" output.mp4

# ok
ffmpeg \
-f avfoundation -i "1" \
output.mp4

# ok
ffmpeg \
-f avfoundation -i "0" \
output.mp4

# error
ffmpeg \
-f avfoundation -r 30 -i "0" \
output.mp4

# ok
ffmpeg \
-f avfoundation -video_size 640x480 -i "1" \
output.mp4

# ok
ffmpeg \
-f avfoundation -i "1" \
output.mp4

# error
ffmpeg \
-f avfoundation -r 30 -video_size 640x480 -i "0" \
output.mp4

# error
video="Capture screen 0":audio="Built-in Input" output.mkv

#livestreaming
ffmpeg -f avfoundation -i "0:0" output.mkv

ffmpeg -f avfoundation -i ":0" out.mp3


# https://stackoverflow.com/questions/32862859/ffmpeg-screen-recording-with-camera-overlay-on-osx
# error
ffmpeg \
-f avfoundation -i "1" \
-f avfoundation -r 30 -video_size 640x480 -i "0" \
-c:v libx264 -crf 0 -preset ultrafast \
-filter_complex 'overlay=main_w-overlay_w-10:main_h-overlay_h-10' "out.mkv"

# ok
ffmpeg \
-f avfoundation -i "1" \
-f avfoundation -video_size 640x480 -i "0" \
-c:v libx264 -crf 0 -preset ultrafast \
-filter_complex 'overlay=main_w-overlay_w-10:main_h-overlay_h-10' "out.mkv"

#me
ffmpeg \
-f avfoundation -i "1" \
-f avfoundation -video_size 320x240 -i "0" \
-c:v libx264 -crf 0 -preset ultrafast \
-filter_complex 'overlay=main_w-overlay_w-10:main_h-overlay_h-10' "out.mkv"

#error
ffmpeg -thread_queue_size 50 \
-f avfoundation -framerate 30 -i "1" \
-thread_queue_size 50 -f avfoundation -framerate 30 -video_size 640x480 -i "0" \
-c:v libx264 -crf 18 -preset ultrafast \
-filter_complex 'overlay=main_w-overlay_w-10:main_h-overlay_h-10' -r 30 ~/Desktop/out.mkv

#error
ffmpeg -thread_queue_size 50 \
-f avfoundation -pix_fmt uyvy422 -framerate 30 -i "1" \
-thread_queue_size 50 -f avfoundation -pix_fmt uyvy422 -framerate 30 -video_size 640x480 -i "0" \
-c:v libx264 -crf 18 -preset ultrafast \
-filter_complex 'overlay=main_w-overlay_w-10:main_h-overlay_h-10' -r 30 ~/Desktop/out.mkv

# https://stackoverflow.com/questions/46767758/ffmpeg-3-3-4-avfoundation-to-record-only-a-specific-section-of-the-screen-on-mac
ffmpeg 
-f avfoundation    // avfoundation
-pix_fmt uyvy422   // pixel format
-i 1               // input: desktop
-r 30              // framerate for output
test.mp4      // filename


# https://stackoverflow.com/questions/8299252/ffmpeg-chroma-key-greenscreen-filter-for-images-video
# https://video.stackexchange.com/questions/21397/green-screen-to-transparent-with-ffmpeg
ffmpeg \
-i <base-video> \
-i <overlay-video> \
-filter_complex '[1:v]colorkey=0x<color>:<similarity>:<blend>[ckout];[0:v][ckout]overlay[out]' \
-map '[out]' \
<output-file>

ffmpeg -f lavfi -i color=c=black:s=606x1080 
       -i input.mp4  
       -filter_complex 
            "[1:v]chromakey=0x70de77:0.1:0.2[ckout];
            [0:v][ckout]overlay[out]" 
       -map "[out]"  output.mp4

# ERROR
ffmpeg -i gs.mkv -vf "chromakey=0x70de77:0.1:0.2" -c copy -c:v png gs_output.mp4



https://sanchi.forkroad.xyz/categories/ffmpeg/
https://sanchi.forkroad.xyz/post/2018-03-27-ffmpeg-1-%E5%8E%9F%E7%90%86-FFmpeg%E5%9F%BA%E7%A1%80%E5%91%BD%E4%BB%A4.html
https://sanchi.forkroad.xyz/post/2018-03-27-ffmpeg-2-%E6%A6%82%E5%BF%B5-%E5%B8%A7%E7%8E%87%E6%AF%94%E7%89%B9%E7%8E%87%E6%96%87%E4%BB%B6%E5%A4%A7%E5%B0%8F.html
https://sanchi.forkroad.xyz/post/2018-03-27-ffmpeg-3-%E4%BD%BF%E7%94%A8-FFmpeg%E8%B0%83%E6%95%B4%E6%96%87%E4%BB%B6%E5%B0%BA%E5%AF%B8.html
https://sanchi.forkroad.xyz/post/2018-03-27-ffmpeg-4-%E4%BD%BF%E7%94%A8-FFmpeg%E8%A7%86%E9%A2%91%E8%A3%81%E5%89%AA.html
https://sanchi.forkroad.xyz/post/2018-03-27-ffmpeg-5-%E4%BD%BF%E7%94%A8-FFmpeg%E8%A7%86%E9%A2%91%E9%97%B4%E8%B7%9D.html

# https://stackoverflow.com/questions/45032945/overlay-circular-video-with-transparency-with-maskedmerge

 
# CHROMA KEY
ffmpeg \
-f lavfi -i color=c=black:s=1920x1080 \
-i gs.mkv \
-shortest \
-filter_complex "[1:v]chromakey=0x70de77:0.1:0.2[ckout];[0:v][ckout]overlay[out]" \
-map "[out]" \
-t 10 \
gsoutput.mkv

# camera with sound
ffmpeg -thread_queue_size 50 -f avfoundation -video_size 320x240 -i "0:0" cam.mkv

# screen capture with sound
ffmpeg -thread_queue_size 50 -f avfoundation -i "1:0" sc.mkv

# record
ffmpeg -thread_queue_size 50 -f avfoundation -i ":0" voice.mp3

# BEST
ffmpeg \
-thread_queue_size 50 -f avfoundation -i "1" \
-thread_queue_size 50 -f avfoundation -video_size 320x240 -i "0:0" \
-c:v libx264 -crf 18 -preset ultrafast \
-filter_complex 'overlay=main_w-overlay_w-10:main_h-overlay_h-10' \
-r 30 \
~/Desktop/outthread.mkv

# OK
gphoto2 --stdout --capture-movie |\
ffmpeg \
-y \
-thread_queue_size 50 -f avfoundation -i "1:0" \
-thread_queue_size 50 -i - \
-c:v libx264 -crf 18 -preset ultrafast \
-filter_complex 'overlay=main_w-overlay_w-10:main_h-overlay_h-10' \
-r 30 \
~/Desktop/outthread.mkv

-vf scale=320:240

#linux
gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video1
# mac
gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f sdl Example
gphoto2 --stdout --capture-movie --capture-sound| ffmpeg -y -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 canon.mkv
gphoto2 --stdout --capture-movie --capture-sound| ffmpeg -y -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f sdl Example

gphoto2 --stdout --capture-movie --capture-sound| ffmpeg -y -i - -vcodec rawvideo -acodec aac -strict -2 -ac 1 -b:a 64k -pix_fmt yuv420p -threads 0 canon.mkv


ffmpeg -f lavfi -i rgbtestsrc -pix_fmt yuv420p -f sdl Example



gphoto2 --stdout --capture-movie| ffmpeg -y -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f sdl Example
gphoto2 --stdout --capture-movie| ffmpeg -y -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 canon.mkv
# test
gphoto2 --stdout --capture-movie| ffmpeg -y -i - canon.mkv
gphoto2 --stdout --capture-movie| ffmpeg -y -i - -vf scale=320:240 canon.mkv
gphoto2 --stdout --capture-movie| ffmpeg -i - -f avfoundation -i "1" -vf [0:v]scale=320:240[a];overlay=main_w-overlay_w-10:main_h-overlay_h-10
ffmpeg -i canon.mkv -i gs.mkv -vf [0:v]scale=320:240;overlay=main_w-overlay_w-10:main_h-overlay_h-10 cobine.mkv

#no sound
gphoto2 --stdout --capture-movie| ffmpeg -y -i - -vcodec rawvideo -pix_fmt yuv420p -acodec aac -strict -2 -ac 1 -threads 0 canon.mkv
gphoto2 --stdout --capture-movie| ffmpeg -y -i - -pix_fmt yuv420p -f avfoundation -i ":0" -threads 0 canon.mkv

f avfoundation -i ":0"

gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -f sdl Example

gphoto2 --stdout --capture-movie --capture-sound| ffmpeg -y -i - -vcodec rawvideo -pix_fmt yuv420p -f sdl Example
gphoto2 --stdout --capture-sound| ffmpeg -y -i - -vcodec rawvideo -pix_fmt yuv420p canon.mkv
-acodec aac -strict -2 -ac 1 -b:a 64k

# virtual device
# https://apple.stackexchange.com/questions/355125/virtual-video-capture-device
# https://webcamoid.github.io/#downloads
# https://github.com/webcamoid/webcamoid

ffplay /akvcam/video0