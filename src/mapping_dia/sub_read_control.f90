subroutine sub_read_control
use mod_main
implicit none
integer file_dyn_in

namelist /dyn_control/ n_mode, n_mode_HO, n_mode_tor, &
         n_step, nuc_dt, n_ele_dt, &
         n_save_trj,label_restart,label_diabatic, &
         n_state, ggamma, label_debug, hamilton_type, &
         mapping_model, label_aver_PES
file_dyn_in=11       
open(unit=file_dyn_in, file="dyn.input")      
read(file_dyn_in, nml = dyn_control)
close(11)

if ( hamilton_type == 3 ) then
  if (n_mode /= n_mode_HO) stop 'Input error! This hamilton type 3, so n_mode should be equal to n_mode_HO!'
  if (n_mode_tor /= 0) stop 'Input error! n_mode_tor /= 0. If including torsional modes, please use hamiltonian type 4!'
elseif ( hamilton_type == 4 ) then
  if (n_mode /= n_mode_HO + n_mode_tor) stop 'Input error!  n_mode /= n_mode_HO + n_mode_tor'
  if (n_mode_tor == 0) stop 'Input error! n_mode_tor should not be zero for hamiltonian type 4!'
endif

end
