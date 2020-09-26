
main_dir=$PWD

for wc in  1000 # 1000  #40  100    200  500  1000
do
  for kdw in 0.5  0.7 # 1.0  #0.3  0.5  0.7  1.0  1.4  2.1
  do
    fig_dir="$main_dir/fig/wc_$wc/kdw_$kdw"
    work_dir="$main_dir/wc_$wc/kdw_$kdw"
    mkdir -p $fig_dir
#    cp $work_dir/pop_dia_t.dat $fig_dir
    cp $work_dir/pop_t.dat $fig_dir
  done
done
