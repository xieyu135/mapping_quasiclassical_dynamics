
n_traj=8000

n_job_1node=`echo "$n_traj/9 +1" | bc`
for((i=1;i<=9;i++))
do
i_op=`echo "($i - 1) * $n_job_1node + 1" | bc`
i_ed=`echo "$i * $n_job_1node" | bc`
echo $i_op, $i_ed
echo "import win_func
win_func.bat_run($i_op, $i_ed)
" > win_$i.py
done
