subroutine sub_evolution_2
use mod_main
implicit none

include 'param.def'

integer i_step

real(kind=8), allocatable, dimension(:) :: x_nuc_cur, p_nuc_cur, &
                                           p_nuc_kin_cur, &
                                           delt_p_nuc, & 
                                           x_nuc_pre, p_nuc_pre, &
                                           p_nuc_kin_pre, &
                                           mass, &
                                           x_elec, p_elec, &
                                           exci_e_cur, &
                                           exci_e_pre
real(kind=8), allocatable, dimension(:,:) :: a_hamiton, &
                                             dia_hamiton, &
                                             c_n, &
                                             grad
real(kind=8), allocatable, dimension(:,:,:) :: dij_cur, &
                                               dij_pre


complex(kind=8), allocatable, dimension(:,:) :: dtoa_u

! --- local variables ---
real(kind=8), dimension(n_mode) :: p_nuc_kin_cur_div_mass
real(kind=8), dimension(n_mode) :: p_nuc_kin_pre_div_mass

allocate (x_nuc_cur(n_mode))
allocate (p_nuc_cur(n_mode))
allocate (x_nuc_pre(n_mode))
allocate (p_nuc_pre(n_mode))
allocate (p_nuc_kin_cur(n_mode))
allocate (p_nuc_kin_pre(n_mode))
allocate (mass(n_mode))
allocate (x_elec(n_state))
allocate (p_elec(n_state))
allocate (exci_e_cur(n_state))
allocate (exci_e_pre(n_state))
allocate (c_n(n_state, n_state))
allocate ( a_hamiton (n_state, n_state))
allocate (dia_hamiton(n_state, n_state))
allocate (grad(n_state, n_mode))
allocate (dij_cur(n_state, n_state, n_mode))
allocate (dij_pre(n_state, n_state, n_mode))
allocate (dtoa_u(n_state, n_state))


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!      
nuc_dt = nuc_dt / TOFS
!      call sub_init_random_seed()
call sub_read_trj_2(x_nuc_cur, p_nuc_cur, &
                    x_nuc_pre, p_nuc_pre, &
                    x_elec, p_elec)
                    
call sub_read_parameter(exci_e_cur, exci_e_pre, &
                    grad, dij_cur, dij_pre, mass)

p_nuc_kin_cur = 0.d0

write(*,*) "cur"
call sub_p_to_p_kin(p_nuc_cur, p_nuc_kin_cur, &
                    dij_cur, &
                    x_elec, p_elec)
write(*,*)

write(*,*) "pre"                
call sub_p_to_p_kin(p_nuc_pre, p_nuc_kin_pre, &
                    dij_pre, &
                    x_elec, p_elec)
write(*,*)
p_nuc_kin_cur_div_mass = p_nuc_kin_cur / mass
p_nuc_kin_pre_div_mass = p_nuc_kin_pre / mass

if (label_aver_PES == 1) then
  call sub_elec_motion_2_aver_PES(p_nuc_kin_cur_div_mass, &
                    p_nuc_kin_pre_div_mass, &
                    x_elec, p_elec, &
                    exci_e_cur, exci_e_pre, dij_cur, dij_pre)
!#  write(*,*) 'sub_elec_motion done'
!#!     call sub_get_c_n_elec_2(x_elec, p_elec, c_n)
!#!     
!#  x_nuc_pre = x_nuc_cur
!#  p_nuc_pre = p_nuc_cur
  call sub_nuc_motion_2_aver_PES( x_nuc_cur, &
                    p_nuc_kin_cur, &
                    mass, &
                    x_elec, p_elec, &
                    grad, dij_cur)
!#!   write(*,*) 'sub_nuc_motion done'
!#
else
  write(*,*) "Subroutines for non-aver_PES are not available now!"
endif

call sub_p_kin_to_p(p_nuc_cur, p_nuc_kin_cur, &
                    dij_cur, &
                    x_elec, p_elec)
call sub_write_trj_2(x_elec, p_elec, x_nuc_cur, p_nuc_cur)
call sub_write_ene_2_aver(x_elec, p_elec, &
                    x_nuc_cur, p_nuc_kin_cur, &
                    exci_e_cur, i_step, mass)

deallocate (x_nuc_cur)
deallocate (p_nuc_cur)
deallocate (x_nuc_pre)
deallocate (p_nuc_pre)
deallocate (mass)
deallocate (x_elec)
deallocate (p_elec)
deallocate (exci_e_cur)
deallocate (exci_e_pre)
deallocate (c_n)
deallocate ( a_hamiton )
deallocate (dia_hamiton)
deallocate (grad)
deallocate (dij_cur)
deallocate (dij_pre)
deallocate (dtoa_u)

end
