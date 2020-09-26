subroutine sub_sampling_infinitive_neglect_minus(arr_n, &
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

! --- local variables ---
real(kind=8) random_1(n_traj * 3, n_state)
real(kind=8) random_2(n_traj * 3, n_state)
real(kind=8) x_tmp_arr(n_traj * 3, n_state)
real(kind=8) p_x_tmp_arr(n_traj * 3, n_state)
real(kind=8) y_tmp_arr(n_traj * 3, n_state)
real(kind=8) p_y_tmp_arr(n_traj * 3, n_state)
integer i, j, k, seed, nr, n

nr = n_traj * 3

k = 1234566
seed = k
call sub_random_symm(nr, seed, x_tmp_arr)

k = k + 1
seed = k
call sub_random_symm(nr, seed, p_y_tmp_arr)

k = k + 1
seed = k
call sub_random_symm(nr, seed, y_tmp_arr)

k = k + 1
seed = k
call sub_random_symm(nr, seed, p_x_tmp_arr)

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
