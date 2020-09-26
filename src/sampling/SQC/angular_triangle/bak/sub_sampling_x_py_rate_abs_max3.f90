subroutine sub_sampling_x_py_rate_abs_max3(arr_n, &
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
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
x_tmp_arr = random_1 - 0.5d0 ! x

k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
p_y_tmp_arr = random_1 - 0.5d0

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
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
y_tmp_arr = random_1 - 0.5d0 ! y

k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
p_x_tmp_arr = random_1 - 0.5d0

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

n = 0
do i = 1, nr
  x_tmp = x_tmp_arr(i, ini_state)
  y_tmp = y_tmp_arr(i, ini_state)
  p_x_tmp = p_x_tmp_arr(i, ini_state)
  p_y_tmp = p_y_tmp_arr(i, ini_state)
  tmp = x_tmp * p_y_tmp - y_tmp * p_x_tmp
  if (tmp < 0) then
    cycle
  endif
  n = n + 1
  call RANDOM_NUMBER(aaction)
  call RANDOM_NUMBER(rran)
  do while( 1 - aaction < rran)
    call RANDOM_NUMBER(aaction)
    call RANDOM_NUMBER(rran)
  enddo
  aaction = aaction + 1
  arr_n(n, ini_state) = aaction
  tmp = (aaction / tmp)**0.5d0
  x_tmp = x_tmp * tmp
  y_tmp = y_tmp * tmp
  p_x_tmp = p_x_tmp * tmp
  p_y_tmp = p_y_tmp * tmp
  x(n, ini_state) = x_tmp
  y(n, ini_state) = y_tmp
  p_x(n, ini_state) = p_x_tmp
  p_y(n, ini_state) = p_y_tmp
  if (n == n_traj) exit
enddo

n = 0
do i = 1, n_traj
  do j = 1, n_state
    if (j == ini_state) cycle
    x_tmp = x_tmp_arr(i, j)
    y_tmp = y_tmp_arr(i, j)
    p_x_tmp = p_x_tmp_arr(i, j)
    p_y_tmp = p_y_tmp_arr(i, j)

    tmp = x_tmp * p_y_tmp - y_tmp * p_x_tmp
    if (tmp < 0) then
      cycle
    endif
    n = n + 1
    aaction = random_1(n, j) * (2.d0 - arr_n(n, ini_state))
    arr_n(n, j) = aaction
    tmp = (aaction / tmp)**0.5d0
    x_tmp = x_tmp * tmp
    y_tmp = y_tmp * tmp
    p_x_tmp = p_x_tmp * tmp
    p_y_tmp = p_y_tmp * tmp
    x(i, j) = x_tmp
    y(i, j) = y_tmp
    p_x(i, j) = p_x_tmp
    p_y(i, j) = p_y_tmp
    if (n == n_traj) exit
  enddo
enddo

arr_n = arr_n - 1.d0/3.d0

end
