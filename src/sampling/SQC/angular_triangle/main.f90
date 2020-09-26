program main
use mod_main
implicit none
! by Yu Xie. Email: xieyu135@sina.com

character(len=72) filename_x_p_traj
real(kind=8), allocatable, dimension(:,:) :: x, &
                                             p_x, &
                                             y, &
                                             p_y, &
                                             arr_n
integer i, j, k, seed, nr, i_occ, n
real(kind=8) angle, aaction, sigma, tmp, rran
real(kind=8) x_tmp, y_tmp, p_x_tmp, p_y_tmp

call sub_read_input
allocate( arr_n(n_traj, n_state) )
allocate( x(n_traj, n_state) )
allocate( p_x(n_traj, n_state) )
allocate( y(n_traj, n_state) )
allocate( p_y(n_traj, n_state) )

if (label_x_py_rate_abs_max == 0)then
  call sub_sampling_infinitive_neglect_minus(arr_n, &
                             x, &
                             p_x, &
                             y, &
                             p_y)
elseif (label_x_py_rate_abs_max == 1) then
  call sub_sampling_action_angle(arr_n, &
                             x, &
                             p_x, &
                             y, &
                             p_y)
elseif (label_x_py_rate_abs_max == 2) then
  call sub_sampling_x_py_rate_abs_max_neglect_minus(arr_n, &
                             x, &
                             p_x, &
                             y, &
                             p_y)
else
  write(*,*) 'wrong label_x_py_rate_abs_max value:', label_x_py_rate_abs_max
  stop
endif



open(10, file='quantum_number.dat')
do i = 1, n_traj
  write(10,*) arr_n(i,:)
enddo
close(10)

do i = 1, n_traj
  write(filename_x_p_traj,*) i
  filename_x_p_traj = 'traj_' // trim(adjustl(filename_x_p_traj))//'.inp'
  open(10, file=filename_x_p_traj)
  do j = 1, n_state
    write(10,9999) x(i, j), y(i, j), p_x(i, j), p_y(i, j)
  enddo
  close(10)
enddo

9999 format(4f18.14)

end
