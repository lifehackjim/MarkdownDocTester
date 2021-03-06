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

for i in *.ini ; do
    echo "Running: md_doctester.py -f \"$i\" -o \"$outdir\" -l \"$logfile\""
    md_doctester.py -f "$i" -o "$outdir" -l "$logfile"
done

echo "Done!"
echo " - built docs are in $outdir"
echo " - logfile is $logfile"
