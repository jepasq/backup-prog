#!/usr/bin/perl
use strict;
use warnings;

use Time::HiRes qw(time);
use POSIX qw(strftime);

# Based on code from https://www.perlmonks.org/?node_id=783615
my $count=1;
my @time=(4,12,16,8);

print "Start at $count\n";
my $lastseconds  = -1;
foreach my $t (@time) {
    my $date = strftime "%S", localtime $t;
    if ($date != $lastseconds) {
	$lastseconds = $date;
	print "New second ($t)\n";
    }
}
