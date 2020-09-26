
exec 7< traj_pop_aver_SQC_input
read -u 7
read -u 7
read -u 7 n_traj ctmp
#np=2  # npoint
exe="$HOME/forProgram/mapping/src/ver_3/main.exe"
main_dir=$PWD

function a_sub { 
sleep 3 
}


tmp_fifofile="/tmp/$$.fifo"
mkfifo $tmp_fifofile
exec 6<>$tmp_fifofile
rm $tmp_fifofile


thread=8 
for ((i=0;i<$thread;i++));do 
echo
done >&6 


for((i=1;i<=n_traj;i++))
do

  read -u 6
  { 
    a_sub && {
      echo "a_sub is finished"
      work_dir="$main_dir/trajs/$i"
      cd $work_dir
      $exe
    }
    echo >&6 
  }&

done
