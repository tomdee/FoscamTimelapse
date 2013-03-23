#!/bin/bash
mkdir /tmp/timelapse
/root/convertdate.py  "*_$(date +%Y%m%d)*.jpg"
cd /tmp/timelapse
mencoder "mf://*.jpg" -mf fps=30 -o /storage/Bryantwood$(date +%Y%m%d).avi -ovc lavc -lavcopts vcodec=msmpeg4v2:vbitrate=3600
rm -rf /tmp/timelapse
