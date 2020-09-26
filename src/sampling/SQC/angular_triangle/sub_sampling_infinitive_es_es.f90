subroutine sub_sampling_infinitive_es_es(arr_n, &
                             x, &
                             p_x, &
                             y, &
                             p_y)
use mod_main
implicit none
! by Yu Xie. Email: xieyu135@sina.com
! sign(x) is the same as sign(p_y)
! sign(y) is the same as sign(p_x)

! --- arguments ---
real(kind=8) arr_n(n_traj, n_state)
real(kind=8) x(n_traj, n_state)
real(kind=8) p_x(n_traj, n_state)
real(kind=8) y(n_traj, n_state)
real(kind=8) p_y(n_traj, n_state)

! --- local variables ---
integer i, j, k
integer seed
real(kind=8) x_tmp, y_tmp, p_x_tmp, p_y_tmp

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

do i = 1, n_traj
  do j = 1, n_state
    x_tmp = x(i, j)
    p_x_tmp = p_x(i, j)
    y_tmp = y(i, j)
    p_y_tmp = p_y(i, j)
    p_x_tmp = sign(p_x_tmp, y_tmp)
    p_y_tmp = sign(p_y_tmp, x_tmp)
  enddo
enddo

call sub_exchange_xpy_ypx(arr_n, &
        x, &
        p_x, &
        y, &
        p_y)

end
