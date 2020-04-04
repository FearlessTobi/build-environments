#!/usr/bin/bash -e
# install pefile
pip3 install pefile

MINGW_URL='https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-posix/seh/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z/download'
TARGET_DIR='mingw64/x86_64-w64-mingw32/lib/'

echo 'Downloading MinGW replacement binaries...'
wget -q "${MINGW_URL}" -O 'mingw.7z'
7z x 'mingw.7z' "${TARGET_DIR}"lib{mf,mfplat,mfuuid}.a
cp -rv "${TARGET_DIR}"/* '/usr/x86_64-w64-mingw32/lib/'

# SDL2
SDL2_VER='2.0.10'
wget "https://www.libsdl.org/release/SDL2-devel-${SDL2_VER}-mingw.tar.gz"
tar -zxf "SDL2-devel-${SDL2_VER}-mingw.tar.gz"
cd SDL2-${SDL2_VER}/
make install-package arch=x86_64-w64-mingw32 prefix=/usr/x86_64-w64-mingw32;
cd ..

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
