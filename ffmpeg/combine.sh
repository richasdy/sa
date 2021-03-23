ffmpeg \
-i "Anak dengan keterlambatan bicara dan bahasa - dr Hardiono (Part1)-VvhEFma0U-g.f136.mp4" \
-i "Anak dengan keterlambatan bicara dan bahasa - dr Hardiono (Part1)-VvhEFma0U-g.f251.webm" \
-c:v copy -c:a copy -strict experimental \
"Anak dengan keterlambatan bicara dan bahasa - dr Hardiono (Part1)-VvhEFma0U-g.mp4"

ffmpeg \
-i "Anak dengan keterlambatan bicara dan bahasa - dr Hardiono (Part1)-VvhEFma0U-g.f136.mp4" \
-i "Anak dengan keterlambatan bicara dan bahasa - dr Hardiono (Part1)-VvhEFma0U-g.f251.webm" \
-c:v copy -c:a copy \
"Anak dengan keterlambatan bicara dan bahasa - dr Hardiono (Part1)-VvhEFma0U-g.mp4"

ffmpeg \
-i "Anak dengan keterlambatan bicara dan bahasa - dr Hardiono (Part1)-VvhEFma0U-g.f136.mp4" \
-i "Anak dengan keterlambatan bicara dan bahasa - dr Hardiono (Part1)-VvhEFma0U-g.f251.webm" \
-c:v copy -c:a copy \
"Anak dengan keterlambatan bicara dan bahasa - dr Hardiono (Part1)-VvhEFma0U-g.mp4"

ffmpeg \
-i "Anak dengan keterlambatan bicara dan bahasa - dr Hardiono (Part1)-VvhEFma0U-g.f136.mp4" \
-i "Anak dengan keterlambatan bicara dan bahasa - dr Hardiono (Part1)-VvhEFma0U-g.f251.webm" \
-c copy \
"Anak dengan keterlambatan bicara dan bahasa - dr Hardiono (Part1)-VvhEFma0U-g.mp4"

ffmpeg \
-i "intro.mkv" \
-i "content.mkv" \
-c copy \
"final.mp4"

ffmpeg -i intro.mkv -c:a copy -s 1280x800 -r 30 intro1280x800.mkv
ffmpeg -f concat -i file.txt -c copy final1280x800.mkv
