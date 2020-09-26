Program main
use mod_main
implicit none


integer file_dyn_in


write(*,*) 'Mapping program within adiabatic representation.'
write(*,*) 'Ref: J. Chem. Phys. 147, 064112 (2017)'
write(*,*)
write(*,*) 'mapping_model: Please see JCP, 145, 204105(2016).'
write(*,*) 'The sequence is the same as that in the paper.'
write(*,*) 'Model 1. '
write(*,*) '    c_nn = x * p_y - y * p_x = 1 (occupied) or 0 (unoccupied)'
write(*,*) '    c_nm = x_n * p_y_m - y_m * p_x_n'
write(*,*)
write(*,*) 'Model 2. MM model'
write(*,*)
write(*,*) 'Model 3. '
write(*,*) '    c_nn = [(x_n + p_y_n)**2 + (y_n-p_x_n)**2]/4'
write(*,*) '    c_nm = x_n * p_y_m - y_m * p_x_n'

call sub_read_control
!write(*,*) 'sub_read_control done!'
write(*,*) 'mapping_model: ', mapping_model

if (mapping_model == 1) then
  write(*,*) 'The function for mapping model 1 (angular momentum) is not available now!'
  stop 
!  call sub_evolution_1
elseif (mapping_model == 2) then
  call sub_evolution_2
else
  write(*,*) 'mapping_model label error', mapping_model
  stop
endif


end Program main
