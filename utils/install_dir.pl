#!/usr/bin/perl -w

#use strict;

$debug = scalar @ARGV > 0;

# A basic little script to help find an 

$vfu=substr $^V, 1;
$ver=substr $^V, 1,4;

if ($debug) {
    print "debug: Extracting versions from $^V : $vfu, $ver\n"
}

# Testing for full version number
foreach(@INC) {
    if (index($_, $vfu) != -1) {
	print $_;
	exit 0;
    }
}

# Testing for restricted version number
foreach(@INC) {
    if (index($_, $ver) != -1) {
	print $_;
	exit 0;
    }
}

# Can't find. Exit with error status code.
exit 1;
