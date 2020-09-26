subroutine sub_sampling_x_py_rate_abs_max2(arr_n, &
                             x, &
                             p_x, &
                             y, &
                             p_y)
use mod_main
implicit none
! by Yu Xie. Email: xieyu135@sina.com
! random sign, exchange x*py and y*px to avoid action < 0

! --- arguments ---
real(kind=8) arr_n(n_traj, n_state)
real(kind=8) x(n_traj, n_state)
real(kind=8) p_x(n_traj, n_state)
real(kind=8) y(n_traj, n_state)
real(kind=8) p_y(n_traj, n_state)

! --- local variables ---
integer k
integer seed
integer seed2

call sub_gener_x_py_rate_lt_cons_random_sign(x, p_y)

call sub_gener_x_py_rate_lt_cons_random_sign(y, p_x)

call sub_exchange_xpy_ypx(arr_n, &
        x, &
        p_x, &
        y, &
        p_y)

end
