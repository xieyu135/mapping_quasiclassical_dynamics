
exec 7< traj_pop_aver_SQC_input
read -u 7 a 
read -u 7 a 
read -u 7 n_trj a

home=/media/sf_E
program=$home/forProgram
src=$program/mapping/src
sampling=$src/sampling
main_dir=$PWD

sam_nuc=$sampling/sampling2_pjw/main_initial_sampling.exe
#sam_elec=$sampling/SQC/action_angle_uni/main_action_angle_uni_triangle.exe
#sam_elec=$sampling/action_angle/main_action_angle.exe
sam_elec="python3 $main_dir/bin/d2a_ini_trj_elec.py"

trj0=1

for((i=$trj0;i<=$n_trj;i++))
do
  mkdir -p trajs/$i
  cp lambda?_coupling.input  ene.input  k_tun.input dyn.input freq.input trajs/$i
done

#$sam_elec < main_action_angle_elec_input
for((i=$trj0;i<=$n_trj;i++))
do
  #mv traj_${i}.inp trajs/$i/trj.input
  cd $main_dir/trajs/$i
  $sam_elec
  cd $main_dir
done

#$sam_nuc < main_action_angle_nuc_input
$sam_nuc < main_Tk_nuc_input
python $sampling/sampling2_pjw/extra_ini_trj.py < extra_ini_trj_input
for((i=$trj0;i<=$n_trj;i++))
do
  mv traj_${i}.inp trajs/$i/trj.input
done

#for((i=$trj0;i<=$n_trj;i++))
#do
#  cd $main_dir/trajs/$i
#  python $filter < $main_dir/filter_input
#done
