#!/bin/sh
APP_NAME=intelG_small #mid
NP=1
RUN="RAW"
NP_PER_NODE=1

CURDIR=$PWD                          

ulimit -s hard

TMP_DIR="/tmp/nscc540_WJ"
#rm -rf $TMP_DIR/*

if [ ! -d $TMP_DIR ];
then
   mkdir $TMP_DIR
fi


WORK_DIR=$TMP_DIR/$LSB_JOBID

mkdir -p $WORK_DIR


cp -rf $CURDIR/* $WORK_DIR
cd $WORK_DIR

echo 'Starting time:'
date

trap "echo 'get signal,now exist' ; mv $WORK_DIR/* $CURDIR" SIGINT SIGQUIT
$HOME/xieyu/program/mapping/src/mapping_v19.3_ing/main.exe
echo 'Ending time:'
date

cp -fr $WORK_DIR/* $CURDIR                        
rm -rf $WORK_DIR/

exit                                   

