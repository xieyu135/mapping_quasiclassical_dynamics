subroutine sub_gener_x_py_rate_lt_cons_diff_sign(x, p_y)
use mod_main
implicit none
! by Yu Xie. Email: xieyu135@sina.com
! sign(x) is the same as sign(p_y)
! sign(y) is different from sign(p_x)

! --- arguments ---
real(kind=8) x(n_traj, n_state)
real(kind=8) p_y(n_traj, n_state)

! --- local variables ---
integer k, seed, seed2
real(kind=8) random_1(n_traj, n_state)

call sub_gener_x_py_rate_lt_cons_same_sign(x, p_y)

p_y = - p_y

end
