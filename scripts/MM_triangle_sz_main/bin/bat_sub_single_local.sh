
exec 7< traj_pop_aver_SQC_input
read -u 7
read -u 7
read -u 7 n_traj ctmp
main_dir=$PWD
SOURCE="${BASH_SOURCE[0]}"
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
source $DIR/env.sh

for((i=1134;i<=1800;i++))
do
  work_dir="$main_dir/trajs/$i"
  cd $work_dir
  echo $i
  bsub $DIR/sub_single_local.sh
#  a=`awk -v i=$i -v n=100 'BEGIN{print i%n}'`
#  if [ $a = 0 ];then
#    echo $i
#  fi
done
