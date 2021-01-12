#!/bin/bash
echo "Converting all jpg images to png. The cwebp tool only takes png input"
for i in *.jpg
do
convert "$i" "$i".webpsynth.png
done
echo "Converting all png frames to webp with cwebp"
for i in *.png
do
cwebp -m 4 -q "$1" "$i" -o "$i".webpsynth.webp
done
echo "Creating muxing list"
echo "webpmux \\" > webpsynth.mux
for i in *.webpsynth.webp
do
echo " -frame $i +$2 \\" >> webpsynth.mux
done
echo "-o $3" >> webpsynth.mux
chmod +x webpsynth.mux
echo "Muxing webp frames with webpmux"
./webpsynth.mux
echo "Cleaning up"
rm *webpsynth*
