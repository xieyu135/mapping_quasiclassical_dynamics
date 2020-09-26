#!/bin/sh
#BSUB -q normal
#BSUB -n 8
#BSUB -o sh%J.out
#BSUB -e sh%J.err
#BSUB -J map
#BSUB -R "span[hosts=1]"
user="xieyu"
CURR=$PWD
WORK_DIR=$CURR
TMP_DIR="/tmp/$user/$LSB_JOBID"


sh win.sh
