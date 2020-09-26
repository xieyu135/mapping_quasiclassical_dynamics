
src_dir=/home-gg/users/nscc540_WJ/hudp/cal/jade_mapping/test/ch2nh2/3state/prepare/sampling
main_dir=$PWD
for((i=1;i<=100;i++))
do
work_dir=$main_dir/trajs/$i
cp $main_dir/sub_jade.sh $work_dir
cd $work_dir
bsub sub_jade.sh
done
