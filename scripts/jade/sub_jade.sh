#!/bin/bash
APP_NAME=intelg_small
NP_PER_NODE=1
NP=1
RUN="RAW"
CURDIR=$PWD


export JADE_HOME=/home-gg/users/nscc540_WJ/hudp/cal/jade_mapping
source $JADE_HOME/bin/JADERC

export random_bumber=$RANDOM
mkdir -p /tmp/nscc540_WJ/$random_bumber
workdir=/tmp/nscc540_WJ/$random_bumber

cp -rf $CURDIR/* $workdir
cd $workdir

jade.exe > $CURDIR/jade.log

cp -rf $workdir/* $CURDIR/

rm -rf $workdir

