#!/usr/bin/perl
use strict;
use warnings;

use Time::HiRes qw(time);
use POSIX qw(strftime);
use IO::Handle;

# Based on code from https://www.perlmonks.org/?node_id=783615
my $count=0;

# Needed to update terminal wihout newline
STDOUT->autoflush(1);

print "Newline every 10s\n";
my $lastseconds  = -1;
while (1) {
    my $date = strftime "%S", localtime;
    if ($date != $lastseconds) {
	$lastseconds = $date;
	print ".";
	$count++;
	if (($count % 10) == 0) {
	    print "\n";
	}
    }
    sleep(0.1);
}
