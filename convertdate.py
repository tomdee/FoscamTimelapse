#!/usr/bin/python
import sys, datetime, glob, os;

# Pass in a glob argument as the first arg
# and a directory as a second arg.

# This script will then extract the date from the default filename format used by FOSCAMs
# And then use imagemagick to put a date/time on the corner of each image

fromFormat = "%Y%m%d%H%M%S"
toFormat   = "%A, %d %B %Y %H:%M %Ss"

for name in glob.glob(sys.argv[1]):
	splitName = name.split("_")
	if (len(splitName) == 4):
		dateString = datetime.datetime.strptime(splitName[2], fromFormat).strftime(toFormat)
		os.system('convert \'%s\' -gravity SouthEast -pointsize 24 -undercolor "#00000080" -fill white -annotate +12+12 "%s"  \'%s/%s.converted.jpg\'' % (name,dateString,sys.argv[2],name))
