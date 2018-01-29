convert s1_*.jpg s1.pdf
convert s1_*.jpg -resize 20% s1_50.pdf
convert s1_*.jpg -resize 30% s1_50.pdf
convert s1_*.jpg -resize 50% s1_50.pdf
convert s1_*.jpg -resize 45% s1_45.pdf
convert s1_*.jpg -resize 43% s1_43.pdf


convert s2_*.jpg -resize 50% s2_50.pdf
convert s2_*.jpg s2.pdf
convert s2_*.jpg -resize 90% s2_90.pdf
convert s2_*.jpg -resize 85% s2_85.pdf

convert s1_ijazah.jpg -rotate 90 s1_ijazah_rotate.jpg
convert s1_ijazah_rotate.jpg -rotate 90 s1_ijazah_rotate.jpg
convert s1_ijazah_en.jpg -rotate 90 s1_ijazah_en_rotate_90.jpg

convert s1_ijazah.jpg -resize 2446x3480 s1_ijazah_risize.jpg
convert s1_ijazah_en.jpg -resize 2446x3480 s1_ijazah_en_risize.jpg
convert s1_nilai.jpg -resize 2446x3480 s1_nilai_risize.jpg
convert s1_nilai2.jpg -resize 2446x3480 s1_nilai2_risize.jpg

convert "s1*resize.jpg" s1.pdf

convert s1_*.jpg s1.pdf
convert s1_*.jpg -resize 90% s1_90.pdf
convert s1_*.jpg -resize 89% s1_89.pdf