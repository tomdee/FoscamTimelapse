#!/bin/bash
#Default to today's date, but allow a different date (in YYYYMMDD format) to be passed in.

if [[ $1 ]]; then
  DATE=$1
else
  DATE=`date +%Y%m%d`
fi

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMP_DIR="/tmp/timelapse"
OUTPUT_DIR="/storage"

echo $SCRIPT_DIR
echo $DATE
mkdir $TEMP_DIR
$SCRIPT_DIR/convertdate.py  "*_$DATE*.jpg" $TEMP_DIR
cd $TEMP_DIR
mencoder "mf://*.jpg" -mf fps=30 -o $OUTPUT_DIR/Bryantwood$DATE.avi -ovc x264 -x264encopts preset=medium:global_header:threads=auto
rm -rf $TEMP_DIR
