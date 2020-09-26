
src_dir=/home-gg/users/nscc540_WJ/hudp/cal/jade_mapping/test/ch2nh2/3state/prepare/sampling

for((i=1;i<=100;i++))
do
  cp $src_dir/workspace/$i trajs/ -r
  cp $src_dir/../../rectangle/prepare/sampling/elec/traj_$i.inp trajs/$i/trj_elec.input
  cp $src_dir/../template/MOLPRO_EXAM trajs/$i -r
  cp dyn.inp trajs/$i
done
