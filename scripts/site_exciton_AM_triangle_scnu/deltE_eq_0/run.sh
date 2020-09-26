
exec 7< traj_pop_aver_SQC_input
read -u 7
read -u 7
read -u 7 n_traj ctmp
#np=2  # npoint
exe="$HOME/program/mapping/src/ver_model1_elec_zpe/main.exe"
main_dir=$PWD



for((i=1;i<=n_traj;i++))
do
  echo $i
  work_dir="$main_dir/trajs/$i"
  cd $work_dir
  $exe&
  a=`awk -v i=$i 'BEGIN{print i%8}'`
  if [ $a = 0 ];then
    echo $a
    wait
  fi
done
