subroutine sub_nuc_bin_sam(x_mode, p_mode, freq)
use mod_main, only : n_state, n_mode
implicit none
include 'param.def'

! --- arguments ---
real(kind=8), dimension(n_mode) :: x_mode, p_mode
real(kind=8), dimension(n_state, n_mode) :: freq

! --- local variables ---
integer i_action(n_mode)
real(kind=8) d_action(n_mode)
real(kind=8) angle(n_mode)
real(kind=8), dimension(n_mode) :: ene, random_1, random_2
integer iindex(n_mode)
integer iindex2(n_mode)
integer i_mode, i_state, j_state
real(kind=8) tmp
integer seed

ene = 0.d0
iindex = -1
iindex2 = 0
ene = (x_mode**2 + p_mode**2 - 1.d0) * 0.5 * freq(1, :)



do while( .not. (sum(iindex) == 0) )
  tmp = 0.d0
  do i_mode = 1, n_mode
    if (ene(i_mode) >= 0.d0 ) then
      iindex(i_mode) = 0
    else
      iindex2(i_mode) = -1
      tmp = tmp + ene(i_mode) * freq(1, i_mode) ! the freqs are the same for different states.
      ene(i_mode) = 0.d0
    endif
  enddo
  tmp = tmp / (real( n_mode + sum(iindex2) )  )
  do i_mode = 1, n_mode
    if (iindex2(i_mode) == 0) ene(i_mode) = ene(i_mode) + tmp
  enddo
enddo

ene = ene/freq(1, :)
i_action = int(ene)

CALL RANDOM_SEED()
CALL RANDOM_NUMBER(random_1)
d_action = sqrt(2.d0 * (random_1 + real(i_action)) + 1.0)

seed = 1234567
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_2)
angle = 2* PI * random_2

x_mode = d_action * cos(angle)
p_mode = d_action * sin(angle)

return
end
