subroutine sub_read_control
use mod_main
implicit none
integer file_dyn_in

namelist /dyn_control/ n_mode,  &
         n_step, nuc_dt, n_ele_dt, &
         n_save_trj,label_restart,label_diabatic, &
         n_state, ggamma, label_debug,  &
         mapping_model, label_aver_PES
file_dyn_in=11       
open(unit=file_dyn_in, file="dyn.input")      
read(file_dyn_in, nml = dyn_control)
close(11)

end
