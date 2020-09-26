subroutine sub_write_ene_2_aver(x_elec, p_elec, &
                     x_nuc_cur, p_nuc_kin_cur, &
                     exci_e_cur, i_step, mass)

use mod_main
implicit none
include 'param.def'
real(kind=8) x_elec(n_state)
real(kind=8) p_elec(n_state)
real(kind=8) x_nuc_cur(n_mode)
real(kind=8) p_nuc_kin_cur(n_mode)
real(kind=8) exci_e_cur(n_state)
real(kind=8) mass(n_mode)
integer i_step

integer i_state, j_state, i_mode
real(kind=8) ene_all_cur
real(kind=8) ene_nuc_kin
real(kind=8) tmp
real(kind=8) time

time = dble(i_step) * nuc_dt * TOFS

ene_all_cur = 0.d0
tmp = 0.d0
do i_state = 1, n_state
  tmp = tmp + exci_e_cur(i_state)
enddo
ene_all_cur = ene_all_cur + tmp/dble(n_state)

tmp = 0.d0
do i_state = 1, n_state
  do j_state = 1, n_state
    tmp = tmp + (x_elec(i_state)**2 + p_elec(i_state)**2 - &
                 x_elec(j_state)**2 - p_elec(j_state)**2) * &
                (exci_e_cur(i_state) - exci_e_cur(j_state))
  enddo
enddo
ene_all_cur = ene_all_cur + tmp/(dble(n_state)*4.d0)

ene_nuc_kin = 0.d0
do i_mode = 1, n_mode
  ene_nuc_kin = ene_nuc_kin + 0.5 * p_nuc_kin_cur(i_mode) **2 / mass(i_mode)
enddo

ene_all_cur = ene_all_cur + ene_nuc_kin

if (i_step .eq. 0) then
  open(100, file="ene.dat")
  write(100,*) "#i_step     time     ene_all(AU)    ene_nuc_kin   ene_1   ene_2  ..."
else
  open(100, position='append', file="ene.dat")
endif
write(100,9997) i_step, time, ene_all_cur, ene_nuc_kin, exci_e_cur(:)

close(100)
9997   format(i10, 1x, 20(f20.10, 1x))

return
end
