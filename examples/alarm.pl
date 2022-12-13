#!/usr/bin/perl
use strict;
use warnings;

=pod
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
=cut

my $count=1;
my @time=(4,12,16,8);

print "Start at $count\n";
LABELME: foreach my $t (@time)
{
    eval {
	$SIG{ALRM} = sub {print "Now $count\n"; next LABELME};
	#sleep(1);
	alarm 1;
	$count += 1;
	print "done with $t. Count is now $count\n";
    }
}
