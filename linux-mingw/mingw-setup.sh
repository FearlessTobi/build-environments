#!/usr/bin/bash -e
# install pefile
pip3 install pefile

MINGW_URL='https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-posix/seh/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z/download'
TARGET_DIR='mingw64/x86_64-w64-mingw32/lib/'

echo 'Downloading MinGW replacement binaries...'
wget -q "${MINGW_URL}" -O 'mingw.7z'
7z x 'mingw.7z' "${TARGET_DIR}"lib{mf,mfplat,mfuuid}.a
cp -rv "${TARGET_DIR}"/* '/usr/x86_64-w64-mingw32/lib/'

# remove the directory
ABS_PATH="$(readlink -f $0)"
rm -rf "$(dirname ${ABS_PATH})"
