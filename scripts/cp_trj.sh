sampling=/media/sf_E/forProgram/mapping/scripts/../src/sampling
main_dir=$PWD

exec 7< traj_pop_aver_SQC_input
read -u 7 a 
read -u 7 a 
read -u 7 n_trj a
trj0=1
for((i=$trj0;i<=$n_trj;i++))
do
  mkdir -p trajs/$i
  cp lambda?_coupling.input ene.input k_tun.input freq.input trajs/$i
  cp dyn.input trajs/$i
done

$sampling/SQC/angular_triangle/main.exe < angular_elec_input

for((i=$trj0;i<=$n_trj;i++))
do
  mv traj_${i}.inp trajs/$i/trj_elec.input
done

$sampling/sampling2_pjw/main_initial_sampling.exe < main_Tk_nuc_input
python $sampling/sampling2_pjw/extra_ini_trj.py < extra_ini_trj_input

for((i=$trj0;i<=$n_trj;i++))
do
  mv traj_${i}.inp trajs/$i/trj.input
done
