
main_dir=$PWD
SOURCE="${BASH_SOURCE[0]}"
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
source $DIR/env.sh
exe_gener_input_files="python $program/mapping/scripts/gener_input_files_v18.3.py"
exe_gener_lambda0="python $main_dir/bin/gener_lambda0_coupling.py"
exe_gener_lambda1="python $main_dir/bin/gener_lambda1_coupling.py"
exe_gener_trjs="sh $main_dir/bin/cp_trj.sh"
exe_dyn="sh $main_dir/bin/run.sh"
exe_win="python $program/mapping/scripts/bat_win_angular.py"
exe_aver="python $program/mapping/scripts/traj_pop_aver_SQC.py"

f_gener_input_files_input="$main_dir/exe_input/gener_input_files_input"
f_aver_input="$main_dir/traj_pop_aver_SQC_input"

cp ham_input/vmat.input vmat.data
cp ham_input/freq.input freq.input
cp ham_input/freq.input freq_sam.input
cp ham_input/k_tun.input k_tun.input
$exe_gener_input_files < $f_gener_input_files_input
#$exe_gener_lambda0 < $f_gener_input_files_input
#$exe_gener_lambda1 < $f_gener_input_files_input
cp ham_input/lambda?_coupling.input .
cp ham_input/ene.input .
$exe_gener_trjs
$exe_dyn
sleep 1m
$exe_win < $f_gener_input_files_input
$exe_aver < $f_aver_input
