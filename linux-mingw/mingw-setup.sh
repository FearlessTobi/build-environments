#!/usr/bin/bash -e
# install pefile
pip3 install pefile

# ffmpeg
FFMPEG_VER='4.1'
for i in 'shared' 'dev'; do
  echo "Downloading ffmpeg (${i})..."
  wget -q -c "https://ffmpeg.zeranoe.com/builds/win64/${i}/ffmpeg-${FFMPEG_VER}-win64-${i}.zip"
  7z x "ffmpeg-${FFMPEG_VER}-win64-${i}.zip" > /dev/null
done

echo "Copying ffmpeg ${FFMPEG_VER} files to sysroot..."
cp -v "ffmpeg-${FFMPEG_VER}-win64-shared"/bin/*.dll /usr/x86_64-w64-mingw32/lib/
cp -vr "ffmpeg-${FFMPEG_VER}-win64-dev"/include /usr/x86_64-w64-mingw32/
cp -v "ffmpeg-${FFMPEG_VER}-win64-dev"/lib/*.{a,def} /usr/x86_64-w64-mingw32/lib/

# remove the directory
ABS_PATH="$(readlink -f $0)"
rm -rf "$(dirname ${ABS_PATH})"
