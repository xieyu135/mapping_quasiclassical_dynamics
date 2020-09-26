subroutine sub_sampling_x_py_rate_abs_max(arr_n, &
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
real(kind=8) random_1(n_traj, n_state)
real(kind=8) random_2(n_traj, n_state)
integer i, j, k, seed, nr, n
real(kind=8) angle, aaction, sigma, tmp, rran
real(kind=8) x_tmp, y_tmp, p_x_tmp, p_y_tmp
real(kind=8) x_py_rate_abs_diff

x_py_rate_abs_diff = x_py_rate_abs_max - 1

k = 1234566
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
x = random_1 - 0.5d0 ! x

k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_2)
call sub_random_rate(random_1, random_2) ! random_1 is rate
p_y = random_1 ! rate

k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
call sub_random_sign(random_1)
p_y = x * p_y * random_1 

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
y = random_1 - 0.5d0 ! y

k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_2)
call sub_random_rate(random_1, random_2) ! random_1 is rate
p_x = random_1 ! rate

k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
call sub_random_sign(random_1)
p_x = y * p_x * random_1 

k = k + 1
seed = k
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)

do i = 1, n_traj
  x_tmp = x(i, ini_state)
  y_tmp = y(i, ini_state)
  p_x_tmp = p_x(i, ini_state)
  p_y_tmp = p_y(i, ini_state)
  tmp = x_tmp * p_y_tmp - y_tmp * p_x_tmp
  if (tmp < 0) then
    call sub_change_sign_x_y_px_py1(x_tmp, y_tmp, p_x_tmp, p_y_tmp)
    tmp = -tmp
  endif
  call RANDOM_NUMBER(aaction)
  call RANDOM_NUMBER(rran)
  do while( 1 - aaction < rran)
    call RANDOM_NUMBER(aaction)
    call RANDOM_NUMBER(rran)
  enddo
  aaction = aaction + 1
  arr_n(i, ini_state) = aaction
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

    tmp = x_tmp * p_y_tmp - y_tmp * p_x_tmp
    if (tmp < 0) then
      call sub_change_sign_x_y_px_py1(x_tmp, y_tmp, p_x_tmp, p_y_tmp)
      tmp = -tmp
    endif
    aaction = random_1(i, j) * (2.d0 - arr_n(i, ini_state))
    arr_n(i, j) = aaction
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

arr_n = arr_n - 1.d0/3.d0

end
