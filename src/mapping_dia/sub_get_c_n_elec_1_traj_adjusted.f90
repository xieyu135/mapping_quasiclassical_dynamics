subroutine sub_get_c_n_elec_1_traj_adjusted(x, y, p_x, p_y, gammas, c_n)
use mod_main, only : label_debug, n_state
implicit none

! --- arguments ---
real(kind=8) x(n_state)
real(kind=8) y(n_state)
real(kind=8) p_x(n_state)
real(kind=8) p_y(n_state)
real(kind=8) gammas(n_state)
real(kind=8) c_n(n_state, n_state)

! --- local variables ---
integer i, j


do i = 1, n_state
  c_n(i,i) = x(i) * p_y(i) - y(i) * p_x(i) - gammas(i)
enddo

do i = 1, n_state
  do j = i+1, n_state
    c_n(i,j) = (x(i) * p_y(j) - y(i) * p_x(j) + &
               x(j) * p_x(j) - y(j) * p_x(i)) * 0.50
    c_n(j,i) = c_n(i,j)
  enddo
enddo

if (label_debug > 1)then
open(10, file='c_n.dat', access='append')
do i = 1, n_state
  write(10, *) c_n(i,:)
enddo
close(10)
endif

return
end
