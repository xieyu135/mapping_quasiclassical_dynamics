


main_dir=$PWD

sub_run="$main_dir/sub_run.sh"

for wc in   1000
do
  for kdw in 0.3  0.5  0.7  1.0  1.4  2.1
  do
    work_dir="$main_dir/wc_$wc/kdw_$kdw"
    cp $main_dir/run.sh $work_dir
    cd $work_dir
    bsub < $sub_run
  done
done
