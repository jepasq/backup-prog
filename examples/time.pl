#!/usr/bin/perl
use strict;
use warnings;

use Time::HiRes qw(time);
use POSIX qw(strftime);

# Based on code from https://www.perlmonks.org/?node_id=783615
my $count=1;

print "Start at $count\n";
my $lastseconds  = -1;
while (1) {
    my $date = strftime "%S", localtime;
    print ".";
    if ($date != $lastseconds) {
	$lastseconds = $date;
	print "New second ($date => $count++)\n";
    }
    sleep(0.1);
}
