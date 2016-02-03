#! /bin/bash

# gstawk *.fa
# gstawk -x assembly.fa

# Defaults
J=1
X=0

while getopts j:x opt
do
    case $opt in
	j) J=$OPTARG;;
	x) X=1;;
    esac
done

INDEX=$(($OPTIND))
FILES="${@:$INDEX}"

wrkdir=$(pwd)
pfx=$(dirname $(readlink -f "$0"))

if [ $X -eq 1 ]
then
    nx $FILES
else
    FILELOG=$wrkdir"/".gstawk.log
    echo $FILES > $FILELOG
    make -j $J -f $pfx"/gstawk_make" -s stats FILENAMES=$FILELOG
    make -f $pfx"/gstawk_make" -s print FILENAMES=$FILELOG
fi

