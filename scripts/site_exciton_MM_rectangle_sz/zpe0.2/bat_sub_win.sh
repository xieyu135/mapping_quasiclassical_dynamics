


main_dir=$PWD

sub_run="$main_dir/sub_win.sh"

for wc in  40  100  200  500  1000
do
  for kdw in 0.3  0.5  0.7  1.0  1.4  2.1
  do
    work_dir="$main_dir/wc_$wc/kdw_$kdw"
    cp $main_dir/run.sh $work_dir
    cp $main_dir/gener_input_files_input $work_dir
    cd $work_dir
    bsub < $sub_run
  done
done
