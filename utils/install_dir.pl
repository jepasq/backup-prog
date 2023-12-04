#!/usr/bin/perl -w

#use strict;

# Handle the 'verbose' mode for CI only if scruipt is called with an arg
$debug = scalar @ARGV > 0;

# A basic little script to help find an 

$vfu=substr $^V, 1;
$ver=substr $^V, 1,4;

# Will print the given directory and eventually test its existence
#
# $1 is the directory found.
sub printdir {
    my ($dirname) = @_;
    print $dirname;

    if ($debug) {
	print "   -- ";
	if (-d $dirname) {
	    print ("This directory exists");
	} else {
	    print ("This directory does NOT exist. Creating it! ");
	    my @args = ("mkdir", "-p", $dirname);
	    system(@args) == 0
		or die ("Cannot create directory '$dirname' : $?");
	    if (-d $dirname) {
		print("(It worked)")
	    } else {
		print("(it DIDN'T work)")
	    }
	}
    }
}

if ($debug) {
    print "debug: Extracting versions from $^V : $vfu, $ver\n"
}

# Testing for full version number
foreach(@INC) {
    if (index($_, $vfu) != -1) {
	printdir $_;
	exit 0;
    }
}

# Testing for restricted version number
foreach(@INC) {
    if (index($_, $ver) != -1) {
	printdir $_;
	exit 0;
    }
}

# Can't find. Exit with error status code.
exit 1;
