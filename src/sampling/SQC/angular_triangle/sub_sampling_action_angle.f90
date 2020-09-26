subroutine sub_sampling_action_angle(arr_n, &
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
real(kind=8) arr_n2(n_traj, n_state)

integer i, j, k, seed, n
real(kind=8) angle, aaction, sigma, tmp, rran

CALL RANDOM_SEED()
CALL RANDOM_NUMBER(random_1)
seed = 1234571
CALL RANDOM_SEED(seed)
do i = 1, n_traj
  call RANDOM_NUMBER(aaction)
  call RANDOM_NUMBER(rran)
  do while( 1 - aaction < rran)
    call RANDOM_NUMBER(aaction)
    call RANDOM_NUMBER(rran)
  enddo
  tmp = aaction
  if ( tmp == 0.d0 ) then
    arr_n(i, ini_state) = tmp  + 1 - ggamma + 1.d-9
  else
    arr_n(i, ini_state) = tmp  + 1 - ggamma
  endif
  do j = 1, n_state
    if (j == ini_state) cycle
    arr_n(i, j) = random_1(i, j) * (1 - tmp) - ggamma
  enddo
enddo
write(*,*)arr_n

do i = 1, n_traj
  do j = 1, n_state
    arr_n2(i, j) = sqrt(arr_n(i, j) + ggamma)
  enddo
enddo


seed = 1234567
CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_2)


do i = 1, n_traj
  do j = 1, n_state
    angle = 2* PI * random_2(i, j)
    !aaction = ini_n(j)
    aaction = arr_n2(i, j)
    x(i, j) = aaction * cos(angle)
    y(i, j) = - aaction * sin(angle)
    p_x(i, j) = aaction * sin(angle)
    p_y(i, j) = aaction * cos(angle)
  enddo
enddo

end
