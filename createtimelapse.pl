#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
 
my $spacing       = 5;
my $captureLength = 30;
my $verbose       = 0;
 
my $result = GetOptions(
  "length=i"  => \$captureLength,    # numeric
  "spacing=i" => \$spacing,          # string
  "verbose"   => \$verbose
);
 
print "Capture every $spacing for a total of $captureLength\n\n";
 
my $startTime = time;
`mkdir -p $startTime`;
my $endTime = time + $captureLength;
 
$verbose && print "Started at $startTime and will finish at $endTime\n";
 
my $index = 0;
 
while (time < $endTime)
{
  $verbose && print "Time is " . time . "\n";
  my $output = sprintf("%s/image-%s-%05d.jpg", $startTime, $startTime, $index);
  `curl http://192.168.1.115/snapshot.cgi -u root:password -s -o $output`;
  $verbose && print "Saved $output\n";
  $index++;
  sleep($spacing);
}
 
# Now encode a video, naming it after the starttime.
 
`ffmpeg -r 30 -i $startTime/image-$startTime-%05d.jpg -b 4000k $startTime.mpeg`;
