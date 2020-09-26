subroutine sub_gener_arr_n_triangle(arr_n)
use mod_main
implicit none
! by Yu Xie. Email: xieyu135@sina.com
! sign(x) is the same as sign(p_y)
! sign(y) is different from sign(p_x)

! --- arguments ---
real(kind=8) arr_n(n_traj, n_state)

! --- local variables ---
integer i, j, seed
real(kind=8) aaction, rran
real(kind=8) random_1(n_traj, n_state)


seed = 1983
CALL RANDOM_SEED(seed)

do i = 1, n_traj
  call RANDOM_NUMBER(aaction)
  call RANDOM_NUMBER(rran)
  do while( 1 - aaction < rran)
    call RANDOM_NUMBER(aaction)
    call RANDOM_NUMBER(rran)
  enddo
  aaction = aaction + 1
  arr_n(i, ini_state) = aaction
enddo

do i = 1, n_traj
  do j = 1, n_state
    if (j == ini_state) cycle
    aaction = random_1(i, j) * (2.d0 - arr_n(i, ini_state))
    arr_n(i, j) = aaction
  enddo
enddo

arr_n = arr_n - ggamma

end
