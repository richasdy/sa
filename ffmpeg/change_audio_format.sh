http://www.bugcodemaster.com/article/convert-videos-mp4-format-using-ffmpeg
ffmpeg -i example.mov -f mp4 -vcodec libx264 -preset fast -profile:v main -acodec aac example.mp4 -hide_banner


https://superuser.com/questions/215430/would-like-to-change-audio-codec-but-keep-video-settings-with-ffmpeg
ffmpeg -i input.avi -acodec mp3 -vcodec copy out.avi


ffmpeg -i "Ayah Hebat, Bersama Ibu Optimalkan Anak  - dr Tiwi & dra Ratih Ibrahim (Part1)-FwdvPywU20U.mkv" -acodec mp3 -vcodec copy "Ayah Hebat, Bersama Ibu Optimalkan Anak  - dr Tiwi & dra Ratih Ibrahim (Part1)-FwdvPywU20U_convert.mkv"

-FwdvPywU20U_convert
ffmpeg -i "Ayah Hebat, Bersama Ibu Optimalkan Anak  - dr Tiwi & dra Ratih Ibrahim (Part1)-FwdvPywU20U.mkv" -acodec mp3 -vcodec copy "Ayah Hebat, Bersama Ibu Optimalkan Anak  - dr Tiwi & dra Ratih Ibrahim (Part1)-FwdvPywU20U_convert.mp4"

ffmpeg -i "Ayah Hebat, Bersama Ibu Optimalkan Anak - dr Tiwi & dra Ratih Ibrahim (Part2)-u8RY90bcqgs.mp4" -acodec mp3 -vcodec copy "Ayah Hebat, Bersama Ibu Optimalkan Anak - dr Tiwi & dra Ratih Ibrahim (Part2)-u8RY90bcqgs_convert.mp4"

ffmpeg -i "Ayah Hebat, Bersama Ibu Optimalkan Anak - dr Tiwi & dra Ratih Ibrahim (Part3)-gizfVSkl1Lg.mkv" -acodec mp3 -vcodec copy "Ayah Hebat, Bersama Ibu Optimalkan Anak - dr Tiwi & dra Ratih Ibrahim (Part3)-gizfVSkl1Lg_convert.mp4"
