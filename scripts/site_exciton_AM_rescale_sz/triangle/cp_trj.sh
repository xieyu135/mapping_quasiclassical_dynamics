
exec 7< traj_pop_aver_SQC_input
read -u 7 a 
read -u 7 a 
read -u 7 n_trj a

main_dir=$PWD
source env.sh

#sam_nuc=/home/xieyu/program/mapping/src/sampling/action_angle/main_action_angle.exe
sam_nuc=$program/mapping/src/sampling/sampling2_pjw/main_initial_sampling.exe
#sam_elec=/home/xieyu/program/mapping/src/sampling/SQC/main_action_angle.exe
sam_elec=$program/mapping/src/sampling/SQC/action_angle_uni/main_action_angle_uni_angular_triangle.exe
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
python $program/mapping/src/sampling/sampling2_pjw/extra_ini_trj_freeze_high_freq.py < extra_ini_trj_input
for((i=$trj0;i<=$n_trj;i++))
do
  mv traj_${i}.inp trajs/$i/trj.input
done

