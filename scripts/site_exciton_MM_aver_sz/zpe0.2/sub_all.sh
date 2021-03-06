#!/bin/sh
APP_NAME=intelg_small #mid
NP=8
RUN="RAW"
NP_PER_NODE=8

CURDIR=$PWD                          

ulimit -s hard

TMP_DIR="/tmp/nscc540_WJ"
#rm -rf $TMP_DIR/*

if [ ! -d $TMP_DIR ];
then
   mkdir $TMP_DIR
fi
source env.sh
scripts=$program/mapping/scripts
WORK_DIR=$TMP_DIR/$LSB_JOBID

mkdir -p $WORK_DIR


cp -rf $CURDIR/* $WORK_DIR
cd $WORK_DIR

echo 'Starting time:'
date

trap "echo 'get signal,now exist' ; mv $WORK_DIR/* $CURDIR" SIGINT SIGQUIT
sh run.sh
sleep 1m
python $scripts/traj_pop_aver.py < traj_pop_aver_SQC_input

echo 'Ending time:'
date

cp -fr $WORK_DIR/* $CURDIR                        
rm -rf $WORK_DIR/

exit                                   

