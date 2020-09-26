#!/bin/sh
#BSUB -q simul1 
##BSUB -n 1
#BSUB -o sh%J.out
#BSUB -e sh%J.err
#BSUB -J map
##BSUB -R "span[hosts=1]"
user="xieyu"
CURR=$PWD
WORK_DIR=$CURR
TMP_DIR="/tmp/$user/$LSB_JOBID"



mkdir -p  $TMP_DIR

main=/mnt/simul/ds3/xieyu/mapping
#cp -r $WORK_DIR/* $TMP_DIR -R
#cd $TMP_DIR
python ../../traj_pop_aver.py < traj_pop_aver_SQC_input
#cp -rf $TMP_DIR/*   $WORK_DIR
#rm -rf $TMP_DIR

