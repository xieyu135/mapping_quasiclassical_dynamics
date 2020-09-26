
main_dir=$PWD
#home=$HOME/xieyu
#program=$home/program
home=/media/sf_E
program=$home/forProgram
exe_gener_input_files="python $program/mapping/scripts/gener_input_files_v18.3.py"
exe_gener_lambda0="python $main_dir/bin/gener_lambda0_coupling.py"
exe_gener_lambda1="python $main_dir/bin/gener_lambda1_coupling.py"
exe_gener_trjs="sh $main_dir/bin/cp_trj.sh"
exe_dyn="sh $main_dir/bin/run.sh"
exe_win="python $program/mapping/scripts/bat_win_triangle_pop_in.py"
exe_aver_win="python $program/mapping/scripts/traj_pop_aver_SQC.py"
exe_aver_nowin="python $program/mapping/scripts/traj_pop_aver.py"

f_gener_input_files_input="$main_dir/exe_input/gener_input_files_input"
f_aver_input="$main_dir/traj_pop_aver_SQC_input"

cp ham_input/vmat.input vmat.data
cp ham_input/freq.input freq.input
cp ham_input/freq.input freq_sam.input
cp ham_input/k_tun.input k_tun.input
$exe_gener_input_files < $f_gener_input_files_input
$exe_gener_lambda0 < $f_gener_input_files_input
$exe_gener_lambda1 < $f_gener_input_files_input
$exe_gener_trjs
rm vmat.data random_gau.dat random_uni.dat
rm dyn.input extra_ini_trj_input freq_sam.input k_tun.input lambda1_coupling.input main_Tk_nuc_input trj_elec.input
rm ene.input freq.input ini_n_elec.inp lambda0_coupling.input main_action_angle_elec_input
$exe_dyn
#sleep 3m
$exe_win < $f_gener_input_files_input
$exe_aver_win < $f_aver_input
#$exe_aver_nowin < $f_aver_input
