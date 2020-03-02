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

#livestreaming
ffmpeg -f avfoundation -i "0:0" output.mkv