
main_dir=$PWD
exe_pop="python $main_dir/traj_pop_aver.py"
exe_pop_input="traj_pop_aver_SQC_input"
#for wc in 39      40   95     100   182    200   1000
for wc in 40  100  200  1000
do
  for kdw in 0.3  0.5  0.7  1.0  1.4  2.1
  do
    work_dir="$main_dir/wc_$wc/kdw_$kdw"
    echo "wc_$wc, kdw_$kdw"
    cd $work_dir
    $exe_pop < $exe_pop_input
    cd $main_dir
  done
done
