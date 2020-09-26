subroutine sub_gener_x_py_rate_lt_cons_random_sign(x, p_y)
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

k = 9127123
k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
call sub_random_sign(random_1)

p_y = p_y * random_1

end
