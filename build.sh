#!/bin/sh

VERSION="1.2.0"
NORMALIZE=false # remember, sox doesn't like mp3 files
NORM_DB="-5.0"

WAV_DIR_PATH="wav_links"
META_DIR_PATH="meta"
BUILD_DIR_PATH="build"
SB_ASSETS_DIR_PATH="$BUILD_DIR_PATH/assets/soundbounds"
MUSIC_DIR_PATH="$SB_ASSETS_DIR_PATH/music"
NORMED_DIR_PATH="normed"
ZIP_NAME="cnc-sb-resources-$VERSION.zip"

# ~~~ CLEANUP ~~~
rm -rf $BUILD_DIR_PATH
mkdir -p $MUSIC_DIR_PATH
rm -f $ZIP_NAME
rm -rf $NORMED_DIR_PATH

# ~~~ COPY METADATA ~~~
cp $META_DIR_PATH/pack.png $BUILD_DIR_PATH
cp $META_DIR_PATH/pack.mcmeta $BUILD_DIR_PATH
cp $META_DIR_PATH/sb.json $SB_ASSETS_DIR_PATH

# ~~~ NORMALIZE WAV FILES ~~~
if [ $NORMALIZE = true ] ; then
  mkdir $NORMED_DIR_PATH
  cd $WAV_DIR_PATH
  for f in *; do
    echo "Normalizing $f..."
    sox "$f" "../$NORMED_DIR_PATH/$f" norm $NORM_DB
  done
fi

# ~~~ BUILD RESOURCE PACK ~~~
if [ $NORMALIZE = true ] ; then cd $NORMED_DIR_PATH
else cd $WAV_DIR_PATH; fi

for f in *; do
  echo "Converting $f to ogg..."
  ogg=../$MUSIC_DIR_PATH/$(echo $f | cut -f 1 -d '.').ogg
  ffmpeg -loglevel warning -i $f $ogg
done
cd ..

# ~~~ PACKAGE ZIP ~~~
cd $BUILD_DIR_PATH
zip -r ./$ZIP_NAME *
mv -f $ZIP_NAME ../
cd ..
