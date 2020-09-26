subroutine sub_sampling_infinitive(arr_n, &
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
integer k
integer seed

k = 1234566
seed = k
! generate random array x(n_traj, n_state) within [-0.5, 0.5]
call sub_random_symm(n_traj, seed, x)

k = k + 1
seed = k
call sub_random_symm(n_traj, seed, p_y)

k = k + 1
seed = k
call sub_random_symm(n_traj, seed, y)

k = k + 1
seed = k
call sub_random_symm(n_traj, seed, p_x)

call sub_exchange_xpy_ypx(arr_n, &
        x, &
        p_x, &
        y, &
        p_y)

end
