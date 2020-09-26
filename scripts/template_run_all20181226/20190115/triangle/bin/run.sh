
exec 7< traj_pop_aver_SQC_input
read -u 7
read -u 7
read -u 7 n_traj ctmp
n_core=1
#np=2  # npoint
home=/media/sf_E
program=$home/forProgram
exe="$program/mapping/src/mapping_adia_HO_test/main.exe"
main_dir=$PWD



for((i=1;i<=n_traj;i++))
do
  echo
  echo
  echo $i
  work_dir="$main_dir/trajs/$i"
  cd $work_dir
  $exe&
  a=`awk -v i=$i -v n=$n_core 'BEGIN{print i%n}'`
  if [ $a = 0 ];then
    #echo $a
    wait
  fi
done
