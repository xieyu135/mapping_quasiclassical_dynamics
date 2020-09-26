subroutine sub_gener_x_py_rate_lt_cons_same_sign(x, p_y)
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

k = 1234566
seed = k
call sub_random_symm(n_traj, seed, x)

k = k + 1
seed = k
call sub_random_symm(n_traj, seed, p_y)

k = k + 1
seed = k

k = k + 1
seed2 = k

call sub_random_rate_seed(n_traj, &
               n_state, &
               seed, &
               seed2, &
               x, &
               p_y)

end
