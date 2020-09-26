
sd_exe=/home/xieyu/forProgram/spectral_density/Debye/main_spec_dens.exe
exe_gener_lambda0="python gener_lambda0_coupling.py"
exe_gener_lambda1="python gener_lambda1_coupling.py"

file_w_k='w_k_out.dat'

$sd_exe < main_spec_dens_input

awk '{print $1, $1}'  $file_w_k > freq.input
awk '{print $1, $1}'  $file_w_k >> freq.input
cp freq.input freq_sam.input
awk '{print $2, 0}'  $file_w_k > k_tun.input
awk '{print 0, $2}'  $file_w_k >> k_tun.input

$exe_gener_lambda0
$exe_gener_lambda1
