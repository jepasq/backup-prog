#!/bin/sh
PWD=`pwd`
VERSION=`cat version.all`
M4="m4 --include=$PWD/m4/ --define=BP_VERSION=$VERSION"
IN=Makefile.in
OUT=Makefile
SUBDIRS=". \
    BackupProg \
    BackupProg/Common \
    BackupProg/Exception \
    BackupProg/Parser \
    BackupProg/UserInterface"

for d in $SUBDIRS; do (
	echo "Generating $OUT for directory $d/ ..."
	cd $d && $M4 $IN > $OUT 
); done
