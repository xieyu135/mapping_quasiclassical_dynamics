
main_dir=$PWD

for wc in 39      40   95     100   182    200   1000
do
  work_dir="$main_dir/wc_$wc"
  mv $work_dir/kdw_0.5 $work_dir/kdw_0.7
  mv $work_dir/kdw_1.0 $work_dir/kdw_1.4
  mv $work_dir/kdw_1.5 $work_dir/kdw_2.1
done
