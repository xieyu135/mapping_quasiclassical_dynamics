#!/bin/sh
#BSUB -q simul1 
#BSUB -n 8
#BSUB -o sh%J.out
#BSUB -e sh%J.err
#BSUB -J map
#BSUB -R "span[hosts=1]"
user="xieyu"
CURR=$PWD
WORK_DIR=$CURR
TMP_DIR="/tmp/$user/$LSB_JOBID"



python /home/simul/xieyu/forProgram/mapping/src/window_func/win_func.py < gener_input_files_input
python /home/simul/xieyu/forProgram/mapping/scripts/traj_pop_aver_SQC.py < traj_pop_aver_SQC_input
