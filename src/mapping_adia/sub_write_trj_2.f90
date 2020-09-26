subroutine sub_write_trj_2(x_elec, p_elec, x_nuc, p_nuc)
use mod_main, only : n_mode, n_state, ggamma, label_debug
implicit none
! --- arguments ---
integer i_step
real(kind=8), dimension(n_mode) :: x_nuc, p_nuc
real(kind=8), dimension(n_state) :: x_elec, p_elec

! --- local variables ---
real(kind=8), dimension(n_state) :: pop_adia
real(kind=8), dimension(n_state, n_state) :: mat_pop_adia
integer f_trj
integer f_trj_elec
integer f_pop_adia

integer i, j

do i = 1, n_state
  mat_pop_adia(i,i) = 0.5 * ( x_elec(i)**2 + p_elec(i)**2 - ggamma)
enddo

do i = 1, n_state-1
  do j = i+1, n_state
    mat_pop_adia(i,j) = 0.5 * ( x_elec(i) * x_elec(j) + p_elec(i) * p_elec(j) )
    mat_pop_adia(j,i) = mat_pop_adia(i,j)
  enddo
enddo

do i = 1, n_state
  pop_adia(i) = mat_pop_adia(i,i)
enddo

f_trj = 11
f_trj_elec = 12
f_pop_adia = 13

open(f_trj, file='x_p_nuc.dat')
open(f_trj_elec, file='x_p_elec.dat')
open(f_pop_adia, file='pop_adia.dat')

do i = 1, n_mode
  write(f_trj, 9998) x_nuc(i), p_nuc(i)
enddo

do i = 1, n_state
  write(f_trj_elec, 9998) x_elec(i), p_elec(i)
enddo


write(f_pop_adia, 9998) pop_adia(:)




close(f_trj_elec)
close(f_pop_adia)
close(f_trj)




9998  format(10(f20.10, 1x))
9999 format(i8,1x,999(f20.10, 1x))
return
end
