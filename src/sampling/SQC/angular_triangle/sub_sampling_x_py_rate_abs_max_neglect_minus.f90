subroutine sub_sampling_x_py_rate_abs_max_neglect_minus(arr_n, &
                             x, &
                             p_x, &
                             y, &
                             p_y)
use mod_main
implicit none
! by Yu Xie. Email: xieyu135@sina.com


! --- arguments ---
real(kind=8) arr_n(n_traj, n_state)
real(kind=8) x(n_traj, n_state)
real(kind=8) p_x(n_traj, n_state)
real(kind=8) y(n_traj, n_state)
real(kind=8) p_y(n_traj, n_state)

! --- local variables ---
integer nr
real(kind=8) random_1(n_traj * 3, n_state)
real(kind=8) random_2(n_traj * 3, n_state)
real(kind=8) x_tmp_arr(n_traj * 3, n_state)
real(kind=8) p_x_tmp_arr(n_traj * 3, n_state)
real(kind=8) y_tmp_arr(n_traj * 3, n_state)
real(kind=8) p_y_tmp_arr(n_traj * 3, n_state)
integer i, j, k, seed,  n
real(kind=8) angle, aaction, sigma, tmp, rran
real(kind=8) x_tmp, y_tmp, p_x_tmp, p_y_tmp
real(kind=8) x_py_rate_abs_diff

nr = n_traj * 3

x_py_rate_abs_diff = x_py_rate_abs_max - 1

k = 1234566
seed = k
call sub_random_symm(nr, seed, x_tmp_arr)

k = k + 1
seed = k
call sub_random_symm(nr, seed, p_y_tmp_arr)

k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_2)

call sub_random_rate(nr, n_state, x_tmp_arr, p_y_tmp_arr, random_1, random_2) 

k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
call sub_random_sign(random_1)

p_y_tmp_arr = p_y_tmp_arr * random_1

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

k = k + 1
seed = k
call sub_random_symm(nr, seed, y_tmp_arr)

k = k + 1
seed = k
call sub_random_symm(nr, seed, p_x_tmp_arr)

k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_2)

call sub_random_rate(nr, n_state, y_tmp_arr, p_x_tmp_arr, random_1, random_2) 

k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
call sub_random_sign(random_1)

p_x_tmp_arr = p_x_tmp_arr * random_1

k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)

call sub_neglect_minus(nr, &
        arr_n, &
        x_tmp_arr, &
        p_x_tmp_arr, &
        y_tmp_arr, &
        p_y_tmp_arr, &
        x, &
        p_x, &
        y, &
        p_y)

end
