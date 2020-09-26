subroutine sub_evolution_11
use mod_main
implicit none

include 'param.def'

integer i_step
real(kind=8), allocatable, dimension(:) :: x_elec
real(kind=8), allocatable, dimension(:) :: y_elec
real(kind=8), allocatable, dimension(:) :: p_x_elec
real(kind=8), allocatable, dimension(:) :: p_y_elec
double precision, allocatable, dimension(:) :: x_cur, p_cur, &
                                               x_pre, p_pre, &
                                               exci_e

double precision, allocatable, dimension(:,:) :: c_n

complex (kind=8), allocatable, dimension(:,:) :: dtoa_u
double precision, allocatable, dimension(:,:) :: a_hamiton, &
                                                dia_hamiton, &
                                                 k_tun, &
                                               freq, &
                                                Ham
double precision, allocatable, dimension(:,:,:) :: lambda0, &
                                                   lambda1

allocate ( x_elec(n_state) )
allocate ( y_elec(n_state) )
allocate ( p_x_elec(n_state) )
allocate ( p_y_elec(n_state) )
allocate (x_cur(n_mode))
allocate (p_cur(n_mode))
allocate (x_pre(n_mode))
allocate (p_pre(n_mode))
allocate (exci_e(n_state))
allocate (c_n(n_state, n_state))
allocate ( a_hamiton (n_state, n_state))
allocate (dia_hamiton(n_state, n_state))
allocate (Ham(n_state, n_state))
allocate ( lambda0(n_mode,n_state, n_state) )
allocate ( lambda1(n_mode,n_state, n_state) )
allocate (dtoa_u(n_state, n_state))
allocate (k_tun(n_state,n_mode) )
allocate (freq(n_state,n_mode))

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!      
nuc_dt = nuc_dt / TOFS
!      call sub_init_random_seed()
call sub_read_ini_trj_1(label_restart,n_mode,n_state,x_cur,p_cur, &
                  x_elec, y_elec, p_x_elec, p_y_elec)
!write(*,*) 'sub_read_ini_trj_1 done!'
! vij = lambda0 + lambda1 * X
!
call sub_read_parameter(freq, k_tun, exci_e, &
                    lambda0, & ! 0th parameter of vij
                    lambda1  & ! 1th parameter of vij
                    )
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

x_pre = x_cur
p_pre = p_cur
!c_n = 0.d0
!c_n(1,1) = 1.d0
if (label_aver_PES == 1) then
  do i_step=0, n_step
     
  !   write(*,*) i_step
     if (mod(i_step,n_save_trj) .eq. 0 ) then
       call sub_get_dia_Ham_elec(x_cur, p_cur, &
                                 freq, k_tun, exci_e, &
                                 lambda0, lambda1, &
                                 Ham)
       !write(*,*) Ham
  !     write(*,*) 'sub_get_dia_Ham_elec done!'
       !write(*,*) exci_e
       call sub_write_trj_1(i_step, &
                          x_cur, p_cur, &
                          x_elec, y_elec, &
                          p_x_elec, p_y_elec, &
                          Ham)
     endif
     
     
  !         if(label_diabatic == 1)then
     call sub_elec_motion_11_aver_PES(x_cur, p_cur, &
                          x_pre, p_pre, &
                          x_elec, y_elec, &
                          p_x_elec, p_y_elec, &
                          freq, k_tun, exci_e, &
                          lambda0, lambda1)
  !   write(*,*) 'sub_elec_motion done'
  !   write(*,*) x_cur
  !   write(*,*) c_n
     call sub_get_c_n_elec_1(x_elec, y_elec, &
                           p_x_elec, p_y_elec, &
                           c_n)
  !   write(*,*) 'sub_get_c_n_elec done'
     
  !   write(*,*) x_cur
  !   write(*,*) c_n
     x_pre = x_cur
     p_pre = p_cur
     call sub_nuc_motion_aver_PES( x_cur, p_cur, &
                          c_n, &
                          freq, k_tun, exci_e, &
                          lambda0, lambda1)
  !   write(*,*) 'sub_nuc_motion done'
  !   write(*,*) x_cur
  !   write(*,*) c_n
  enddo
else
  do i_step=0, n_step
     
     !write(*,*) "i_step", i_step
     if (mod(i_step,n_save_trj) .eq. 0 ) then
       call sub_get_dia_Ham_elec(x_cur, p_cur, &
                                 freq, k_tun, exci_e, &
                                 lambda0, lambda1, &
                                 Ham)
       !write(*,*) Ham
       !write(*,*) 'sub_get_dia_Ham_elec done!'
       !write(*,*) exci_e
       call sub_write_trj_1(i_step, &
                          x_cur, p_cur, &
                          x_elec, y_elec, &
                          p_x_elec, p_y_elec, &
                          Ham)
       !write(*,*) 'sub_write_trj_1 done!'
     endif
     
     
  !         if(label_diabatic == 1)then
     call sub_elec_motion_11(x_cur, p_cur, &
                          x_pre, p_pre, &
                          x_elec, y_elec, &
                          p_x_elec, p_y_elec, &
                          freq, k_tun, exci_e, &
                          lambda0, lambda1)
     !write(*,*) 'sub_elec_motion done'
  !   write(*,*) x_cur
  !   write(*,*) c_n
     call sub_get_c_n_elec_1(x_elec, y_elec, &
                           p_x_elec, p_y_elec, &
                           c_n)
     !write(*,*) 'sub_get_c_n_elec done'
     
  !   write(*,*) x_cur
  !   write(*,*) c_n
     x_pre = x_cur
     p_pre = p_cur
     call sub_nuc_motion( x_cur, p_cur, &
                          c_n, &
                          freq, k_tun, exci_e, &
                          lambda0, lambda1)
     !write(*,*) 'sub_nuc_motion done'
  !   write(*,*) x_cur
  !   write(*,*) c_n
  enddo
endif
deallocate (x_cur)
deallocate (p_cur)
deallocate (x_pre)
deallocate (p_pre)
deallocate (c_n)


end
