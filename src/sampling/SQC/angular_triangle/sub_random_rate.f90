subroutine sub_random_rate(n_traj, n_state, x, p_y, random_1, random_2)
use mod_main, only : x_py_rate_abs_max
implicit none
! by Yu Xie. Email: xieyu135@sina.com

! --- arguments ---
integer n_traj, n_state
real(kind=8) random_1(n_traj, n_state)
real(kind=8) random_2(n_traj, n_state)
real(kind=8) x(n_traj, n_state)
real(kind=8) p_y(n_traj, n_state)

! --- local variables ---
integer i, j
real(kind=8) tmp

tmp = 1.d0 / x_py_rate_abs_max
random_1 = random_1 * (1.d0 -  tmp) + tmp
do i = 1, n_traj
  do j = 1, n_state
    if (random_2(i, j) < 0.5) then
      p_y(i, j) = x(i, j) * random_1(i, j)
    else
      x(i, j) = p_y(i, j) * random_1(i, j)
    endif
  enddo
enddo

end
