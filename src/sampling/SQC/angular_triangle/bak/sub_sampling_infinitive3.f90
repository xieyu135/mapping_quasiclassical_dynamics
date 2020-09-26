subroutine sub_sampling_infinitive3(arr_n, &
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
real(kind=8) random_1(n_traj, n_state)
real(kind=8) random_2(n_traj, n_state)
real(kind=8) random_3(n_traj, n_state)
real(kind=8) random_4(n_traj, n_state)
real(kind=8) random_5(n_traj, n_state)
integer i, j, k, seed, nr, n
real(kind=8) angle, aaction, sigma, tmp, rran
real(kind=8) x_tmp, y_tmp, p_x_tmp, p_y_tmp

seed = 1234566
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
seed = 1234567
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_2)
seed = 1234568
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_3)
seed = 1234569
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_4)
seed = 1234570
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_5)
seed = 1234571
CALL RANDOM_SEED(seed)

do i = 1, n_traj
  x_tmp = (random_1(i, ini_state) - 0.5d0)
  y_tmp = (random_3(i, ini_state) - 0.5d0)
  p_x_tmp = (random_2(i, ini_state) - 0.5d0)
  p_y_tmp = (random_4(i, ini_state) - 0.5d0)
  p_x_tmp = - sign(p_x_tmp, y_tmp)
  p_y_tmp = sign(p_y_tmp, x_tmp)
  tmp = x_tmp * p_y_tmp - y_tmp * p_x_tmp
  if (tmp < 0) then
    write(*,*) 'x_tmp * p_y_tmp - y_tmp * p_x_tmp < 0'
    write(*,*) 'Please check it!'
    stop
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
    x_tmp = (random_1(i, j) - 0.5d0)
    p_x_tmp = (random_2(i, j) - 0.5d0)
    y_tmp = (random_3(i, j) - 0.5d0)
    p_y_tmp = (random_4(i, j) - 0.5d0)
    p_x_tmp = - sign(p_x_tmp, y_tmp)
    p_y_tmp = sign(p_y_tmp, x_tmp)
    tmp = x_tmp * p_y_tmp - y_tmp * p_x_tmp
    if (tmp < 0) then
      write(*,*) 'x_tmp * p_y_tmp - y_tmp * p_x_tmp < 0'
      write(*,*) 'Please check it!'
      stop
    endif
    aaction = random_5(i, j) * (2.d0 - arr_n(i, ini_state))
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
