subroutine sub_sampling_x_py_rate_abs_max_es_nes(arr_n, &
                             x, &
                             p_x, &
                             y, &
                             p_y)
use mod_main
implicit none
! by Yu Xie. Email: xieyu135@sina.com
! sign(x) is the same as sign(p_y)
! sign(y) is different from sign(p_x)

! --- arguments ---
real(kind=8) arr_n(n_traj, n_state)
real(kind=8) x(n_traj, n_state)
real(kind=8) p_x(n_traj, n_state)
real(kind=8) y(n_traj, n_state)
real(kind=8) p_y(n_traj, n_state)

call sub_gener_x_py_rate_lt_cons_same_sign(x, p_y) 

call sub_gener_x_py_rate_lt_cons_diff_sign(y, p_x)

! actually, no exchange for the current case.
call sub_exchange_xpy_ypx(arr_n, &
        x, &
        p_x, &
        y, &
        p_y)

end
