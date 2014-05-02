#!/bin/bash -e
script=$0
mydir=`dirname $script`
mydir=`cd $mydir ; pwd`
parentdir=`cd $mydir/.. ; pwd`
export PATH=$PATH:$parentdir

argdir=$mydir/OUT
test -n "$1" && argdir=`mkdir -p $1 ; cd $1 ; pwd`

outdir="$argdir"
logfile="$argdir/build_docs.log"

mkdir -p $outdir
cd $mydir

rm -f "$logfile"

echo "Running: md_doctester.py -f \"md_doctester.ini\" -o \"$outdir\" -l \"$logfile\""
md_doctester.py -f "md_doctester.ini" -o "$outdir" -l "$logfile"

cp $outdir/md_doctester_readme.md ../README.md
cp $outdir/md_doctester_readme.html ../README.html
