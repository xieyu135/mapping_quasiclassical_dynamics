
main_dir=$PWD
source env.sh
fnm_spec_input='main_spec_dens_input'
f_gener_inp_input="$main_dir/input_gener_tree2_input"
f_gener_input_files_input="$main_dir/gener_input_files_input"
file_w_k='w_k_out.dat'
exe_spec="$program/spectral_density/Debye/main_spec_dens.exe"
exe_gener_lambda0="python $main_dir/gener_lambda0_coupling.py"
exe_gener_lambda1="python $main_dir/gener_lambda1_coupling.py"
exe_gener_input_files="python $program/mapping/scripts/gener_input_files_v18.3.py"
exe_gener_trjs="sh $main_dir/cp_trj.sh"


for wc in    200
do
  for kdw in 0.5 0.7  #0.3  0.5  0.7  1.0  1.4  2.1
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
12      # delt_omega
w_k_out.dat # file_w_k_out
"  > $f_spec_input

    work_dir="$main_dir/wc_$wc/kdw_$kdw"
    cp vmat.data run.sh env.sh $work_dir
    cd $work_dir
    $exe_gener_lambda0 < $f_gener_input_files_input
    $exe_gener_lambda1 < $f_gener_input_files_input
    $exe_spec < $fnm_spec_input
    #gnuplot -persist $main_dir/plot_set
    awk '{print $1, $1}'  $file_w_k > freq.input
    awk '{print $1, $1}'  $file_w_k >> freq.input
    cp freq.input freq_sam.input
    awk '{print $2, 0}'  $file_w_k > k_tun.input
    awk '{print 0, $2}'  $file_w_k >> k_tun.input
    $exe_gener_input_files < $f_gener_input_files_input

    $exe_gener_trjs
    bsub $main_dir/sub_all.sh
    cd $main_dir
  done
done

