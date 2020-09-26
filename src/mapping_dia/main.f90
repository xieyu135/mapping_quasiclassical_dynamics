Program main
use mod_main
implicit none


integer file_dyn_in


write(*,*) 'hamilton_type:'
write(*,*) '1. constant Vij; '
write(*,*) '2. LVC; '
write(*,*) '3. V_aa = E_a_0 + 0.5 * w_a_i * Q_i**2 + k_a_i * Q_i,'
write(*,*) '   V_ab = la_ab_0_i + la_ab_1_i * Q_i'
write(*,*) '4. M Type-3 modes, N torsional modes'
write(*,*) 'torsional potential: '
write(*,*) '0.5 * I_inverse * P_i **2 + 0.5 * V_i_n * ( 1 - cos(A) ) * c_n'
write(*,*) 
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
write(*,*)
write(*,*)
call sub_read_control
!write(*,*) 'sub_read_control done!'
write(*,*) 'mapping_model: ', mapping_model
if (hamilton_type == 3) then
  if (mapping_model == 1) then
    call sub_evolution_1
  elseif (mapping_model == 2) then
    call sub_evolution_2
  elseif (mapping_model == 3) then
    call sub_evolution_3
  elseif (mapping_model == 11) then
    call sub_evolution_11
  elseif (mapping_model == 10002) then
    call sub_evolution_2_nuc_bin_sam
  elseif (mapping_model == 22) then
    call sub_evolution_2_traj_adjusted
  elseif (mapping_model == 21) then
    call sub_evolution_1_traj_adjusted
  else
    write(*,*) 'mapping_model label error', mapping_model
    stop
  endif
elseif (hamilton_type == 4) then
  if (mapping_model == 1) then
    call sub_evolution_mapping_1_ham_4
    !stop "sub_evolution_mapping_1_ham_4.f90 is not available!"
  elseif (mapping_model == 2) then
    if (label_debug > 1) write(*,*) 'sub_evolution_mapping_2_Ham_4 starts!'
    call sub_evolution_mapping_2_Ham_4
  elseif (mapping_model == 3) then
    !call sub_evolution_mapping_3_ham_4
    stop "sub_evolution_mapping_3_ham_4.f90 is not available!"
  else
    write(*,*) 'mapping_model label error', mapping_model
    stop
  endif
else
  write(*,*) '------------------------------------------------------------------------'
  write(*,*) 'The function dealing with the Hamiltonian type'
  write(*,*) '    ', hamilton_type
  write(*,*) 'is not avialable now!'
  write(*,*) '------------------------------------------------------------------------'
endif

end Program main
