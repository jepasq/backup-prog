#!/usr/bin/perl
use strict;
use warnings;

# Based on code from https://www.perlmonks.org/?node_id=783615
my $count=1;
my @time=(4,12,16,8);

print "Start at $count\n";
LABELME: foreach my $t (@time)
{
    eval {
	$SIG{ALRM} = sub {
	    $count += 1;
	    print "Count is now $count\n";
	    next LABELME}
	;
	sleep(1);
	alarm 0;
	
	print "done with $t.\n";
    }
}
