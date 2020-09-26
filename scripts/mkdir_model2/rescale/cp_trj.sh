
exec 7< traj_pop_aver_SQC_input
read -u 7 a 
read -u 7 a 
read -u 7 n_trj a

main_dir=$PWD
src=/home/xieyu/forProgram/mapping/src
sampling=$src/sampling

#sam_nuc=/home/xieyu/forProgram/mapping/src/sampling/action_angle/main_action_angle.exe
sam_nuc=$HOME/forProgram/mapping/src/sampling/sampling2_pjw/main_initial_sampling.exe
#sam_elec=/home/xieyu/forProgram/mapping/src/sampling/SQC/main_action_angle.exe
sam_elec=$HOME/forProgram/mapping/src/sampling/SQC/action_angle_uni/main_action_angle_uni_triangle.exe
trj0=1

for((i=$trj0;i<=$n_trj;i++))
do
  mkdir -p trajs/$i
  cp lambda?_coupling.input  ene.input  k_tun.input dyn.input freq.input trajs/$i
done

$sam_elec < main_action_angle_elec_input
for((i=$trj0;i<=$n_trj;i++))
do
  mv traj_${i}.inp trajs/$i/trj_elec.input
#  cp nuc/traj_${i}.inp trajs/$i/trj.input
done

$sam_nuc < main_Tk_nuc_input
python $HOME/forProgram/mapping/src/sampling/sampling2_pjw/extra_ini_trj_freeze_high_freq.py < extra_ini_trj_input
for((i=$trj0;i<=$n_trj;i++))
do
  mv traj_${i}.inp trajs/$i/trj.input
done

#for((i=$trj0;i<=$n_trj;i++))
#do
#  cd $main_dir/trajs/$i
#  python $filter < $main_dir/filter_input
#done
