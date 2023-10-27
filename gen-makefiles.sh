#!/bin/sh
PWD=`pwd`
VERSION=`cat version.all`
# In the form of x.yy, only numbers (4 removes trailing .0 string)
PERLV=`perl -e 'print substr $^V, 1,4'`  
M4="m4 --include=$PWD/m4/ --define=BP_VERSION=$VERSION --define=PERLV=$PERLV"
IN=Makefile.in
OUT=Makefile
SUBDIRS=". \
    BackupProg \
    BackupProg/Common \
    BackupProg/Exception \
    BackupProg/Parser \
    BackupProg/UserInterface"

wm4=`m4 --help`
wm4_es=$?
if [ $wm4_es -eq 127 ]
then
    echo -n "  Can't find the m4 binary. Please read README.md to know"
    echo " how to install needed packages."
    exit 1
fi    

for d in $SUBDIRS; do (
	echo "Generating $OUT for directory $d/ ..."
	cd $d && $M4 $IN > $OUT 
); done

