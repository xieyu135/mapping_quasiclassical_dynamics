subroutine sub_write_ene_symm_2(i_step, &
                         x_cur, p_cur, &
                         x_elec, p_elec, &
                         Ham)
use mod_main
include "param.def"
integer i_step
! --- arguments ---
real(kind=8), dimension(n_mode) :: x_cur, p_cur
real(kind=8), dimension(n_state) :: x_elec, p_elec
real(kind=8), dimension(n_state, n_state) :: Ham

! --- local variables ---
real(kind=8) ene_all, ene_nuc_kin, time, tmp
integer i_state, j_state, i_mode

ene_all = 0.d0
tmp = 0.d0
do i_state = 1, n_state
    tmp = tmp + Ham(i_state, i_state)
enddo
ene_all = ene_all + tmp/dble(n_state)

tmp = 0.d0
do i_state = 1, n_state - 1
    do j_state = i_state + 1, n_state
        tmp = tmp + (Ham(i_state, i_state) - Ham(j_state, j_state)) * &
              0.5 * (x_elec(i_state)**2 + p_elec(i_state)**2 - &
                     x_elec(j_state)**2 + p_elec(j_state)**2)
    enddo
enddo
ene_all = ene_all + tmp/dble(n_state)

do i_state = 1, n_state - 1
    do j_state = i_state + 1, n_state
        ene_all = (x_elec(i_state) * x_elec(j_state) + &
                   p_elec(i_state) * p_elec(j_state)) * &
                   Ham(i_state, j_state) + ene_all
    enddo
enddo

if(i_step == 0) then
    open(10, file="ene.dat")
else
    open(10, file="ene.dat", position="append")
endif

time = dble(i_step) * nuc_dt * TOFS
if (mod(i_step,n_save_trj) .eq. 0 ) then
    write(10, *) i_step, time, ene_all
endif

return
end
