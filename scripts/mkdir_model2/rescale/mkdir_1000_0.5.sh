
main_dir=$PWD
fnm_spec_input='main_spec_dens_input'
f_gener_input_files_input="$main_dir/gener_input_files_input"
file_w_k='w_k_out.dat'
exe_spec="$HOME/forProgram/spectral_density/Debye/main_spec_dens.exe"
calc_freq_cut="python /home/xieyu/forProgram/mapping/scripts/calc_freq_cut.py"
exe_gener_lambda0="python $main_dir/gener_lambda0_coupling.py"
exe_gener_lambda1="python $main_dir/gener_lambda1_coupling.py"
exe_gener_input_files="python $HOME/forProgram/mapping/scripts/gener_input_files_aver_PES_freeze_high_freq.py"
exe_gener_trjs="sh $main_dir/cp_trj.sh"

exec 7< $f_gener_input_files_input
read -u 7
read -u 7
read -u 7
read -u 7
read -u 7 high_freq_cut tmp

for wc in   1000 #500   1000
do
  for kdw in 0.5 #0.3  0.5  0.7  1.0
  do
    work_dir="$main_dir/wc_$wc/kdw_$kdw"
    f_spec_input="$work_dir/$fnm_spec_input"
    #E_re=`echo "$kdw * $kdw * $wc" | bc scale=4`
    E_re=`awk -v a=$kdw -v w=$wc 'BEGIN{print a^2*w*0.5}'`
    echo "mkdir $work_dir"
    mkdir -p $work_dir
    echo "generate $fnm_spec_input"
    echo "cm        # energy unit
$wc     # omega_c
$E_re         # lambda
100       # n_mode
24      # delt_omega
w_k_out.dat # file_w_k_out
"  > $f_spec_input
  done
done


for wc in  1000 #40  100  200  500  1000  1500
do
  for kdw in 0.5 # 0.3  0.5  0.7  1.0
  do
    work_dir="$main_dir/wc_$wc/kdw_$kdw"
    cp vmat.data run.sh $f_gener_input_files_input $work_dir
    cp $main_dir/calc_freq_cut_input $work_dir
    cd $work_dir
    $exe_spec < $fnm_spec_input
    #gnuplot -persist $main_dir/plot_set
    $calc_freq_cut < calc_freq_cut_input > calc_freq_cut.out
    tail -n 1 calc_freq_cut.out > high_freq_cut_input
    exec 7< high_freq_cut_input
    read -u 7 high_freq_cut V12
    echo $V12
    awk -v cut=$high_freq_cut '$1<cut{print $1, $1}'  $file_w_k > freq.input
    awk -v cut=$high_freq_cut '$1<cut{print $1, $1}'  $file_w_k >> freq.input
    cp freq.input freq_sam.input
    awk -v cut=$high_freq_cut '$1<cut{print $2, 0}'  $file_w_k > k_tun.input
    awk -v cut=$high_freq_cut '$1<cut{print 0, $2}'  $file_w_k >> k_tun.input
    n_mode=`cat freq.input | wc -l`
    sed -i '2c '"$n_mode"'' gener_input_files_input
    sed -i '5c '"$high_freq_cut"' # high freq cutoff' gener_input_files_input
    echo "0.0124   $V12
$V12   0" > vmat.data
    $exe_gener_lambda0 < gener_input_files_input
    $exe_gener_lambda1 < gener_input_files_input
    $exe_gener_input_files < gener_input_files_input

    $exe_gener_trjs
    cd $main_dir
  done
done
