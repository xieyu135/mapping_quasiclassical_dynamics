subroutine sub_cal_gammas_1(x_elec, y_elec, p_x_elec, p_y_elec, gammas)
use mod_main
implicit none
! --- arguments ---
integer i_step
real(kind=8), dimension(n_state) :: x_elec, y_elec, p_x_elec, p_y_elec, gammas

! --- lacal variables ---
integer i, j, i_state
real(kind=8) tmp

do i_state = 1, n_state
  tmp = x_elec(i_state) * p_y_elec(i_state) - y_elec(i_state) * p_x_elec(i_state)
  if ( tmp >= 1.d0 ) then
    gammas(i_state) = tmp - 1.d0
  else
    gammas(i_state) = tmp
  endif
enddo

return
end
