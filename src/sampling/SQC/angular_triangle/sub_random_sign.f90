subroutine sub_random_sign(random_1)
use mod_main
implicit none
! by Yu Xie. Email: xieyu135@sina.com

! --- arguments ---
real(kind=8) random_1(n_traj, n_state)

! --- local variables ---
integer i, j

do i = 1, n_traj
  do j = 1, n_state
    if (random_1(i, j) < 0.5) then
      random_1(i, j) = 1.d0
    else
      random_1(i, j) = -1.d0
    endif
  enddo
enddo



end
