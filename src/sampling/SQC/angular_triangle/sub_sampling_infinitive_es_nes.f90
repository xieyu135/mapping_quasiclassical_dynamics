subroutine sub_sampling_infinitive_es_nes(arr_n, &
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
integer i, j, k, seed, nr, n
real(kind=8) aaction, tmp
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

call sub_gener_arr_n_triangle(arr_n)
arr_n = arr_n + ggamma

do i = 1, n_traj
  x_tmp = x(i, ini_state)
  y_tmp = y(i, ini_state)
  p_x_tmp = p_x(i, ini_state)
  p_y_tmp = p_y(i, ini_state)
  p_x_tmp = - sign(p_x_tmp, y_tmp)
  p_y_tmp = sign(p_y_tmp, x_tmp)
  tmp = x_tmp * p_y_tmp - y_tmp * p_x_tmp
  if (tmp < 0) then
    write(*,*) 'x_tmp * p_y_tmp - y_tmp * p_x_tmp < 0'
    write(*,*) 'Please check it!'
    stop
  endif
  aaction = arr_n(i, ini_state)
  tmp = (aaction / tmp)**0.5d0
  x_tmp = x_tmp * tmp
  y_tmp = y_tmp * tmp
  p_x_tmp = p_x_tmp * tmp
  p_y_tmp = p_y_tmp * tmp
  x(i, ini_state) = x_tmp
  y(i, ini_state) = y_tmp
  p_x(i, ini_state) = p_x_tmp
  p_y(i, ini_state) = p_y_tmp
enddo

do i = 1, n_traj
  do j = 1, n_state
    if (j == ini_state) cycle
    x_tmp = x(i, j)
    y_tmp = y(i, j)
    p_x_tmp = p_x(i, j)
    p_y_tmp = p_y(i, j)
    p_x_tmp = - sign(p_x_tmp, y_tmp)
    p_y_tmp = sign(p_y_tmp, x_tmp)
    tmp = x_tmp * p_y_tmp - y_tmp * p_x_tmp
    aaction = arr_n(i, j)
    tmp = (aaction / tmp)**0.5d0
    x_tmp = x_tmp * tmp
    y_tmp = y_tmp * tmp
    p_x_tmp = p_x_tmp * tmp
    p_y_tmp = p_y_tmp * tmp
    x(i, j) = x_tmp
    y(i, j) = y_tmp
    p_x(i, j) = p_x_tmp
    p_y(i, j) = p_y_tmp
  enddo
enddo

arr_n = arr_n - ggamma

end
