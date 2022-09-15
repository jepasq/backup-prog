#!/usr/bin/perl
use strict;
use warnings;

# From https://www.perlmonks.org/?node_id=783615

my @time=(4,12,16,8);
LABELME: foreach my $t (@time)
{
    $SIG{ALRM} = sub {print "timeout\n"; next LABELME};
     print "Start $t\n";
     alarm(10);
     sleep($t);
     alarm(0);
     print "done with $t\n";
}
print "All Done!\n";
