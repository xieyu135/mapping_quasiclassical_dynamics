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
scripts=$HOME/xieyu/program/mapping/scripts
WORK_DIR=$TMP_DIR/$LSB_JOBID

mkdir -p $WORK_DIR


cp -rf $CURDIR/* $WORK_DIR
cd $WORK_DIR

echo 'Starting time:'
date

trap "echo 'get signal,now exist' ; mv $WORK_DIR/* $CURDIR" SIGINT SIGQUIT
sh run.sh
sleep 1m
python $scripts/bat_win_angular.py < gener_input_files_input
python $scripts/traj_pop_aver_SQC.py < traj_pop_aver_SQC_input

echo 'Ending time:'
date

cp -fr $WORK_DIR/* $CURDIR                        
rm -rf $WORK_DIR/

exit                                   

