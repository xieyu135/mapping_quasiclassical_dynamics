program main_action_angle_uni_angular_triangle_xy
! action does not distribute uniformly

implicit none

include 'param.def'

integer n_state
integer n_traj
character(len=72) filename_ini_n
character(len=72) filename_x_p_traj
real(kind=8), allocatable, dimension(:) :: ini_n
real(kind=8), allocatable, dimension(:,:) :: x, &
                                             p_x, &
                                             y, &
                                             p_y, &
                                             random_1, &
                                             random_2, &
                                             random_3, &
                                             random_4, &
                                             random_5, &
                                             arr_n
real(kind=8) ggamma
real(kind=8) ggamma_half
real(kind=8) sum_n_max

integer i, j, k, seed, nr, i_occ, n
real(kind=8) angle, aaction, sigma, tmp
real(kind=8) x_tmp, y_tmp, p_x_tmp, p_y_tmp

write(*,*) 'n_state:'
read(*,*) n_state

write(*,*) 'n_traj:'
read(*,*) n_traj

write(*,*) 'filename of initial n(occupation):'
read(*,*) filename_ini_n

write(*,*) 'gamma:'
read(*,*) ggamma
write(*,*) ggamma
write(*,*) 'Acturally, we choose ggamma = 2/3 in triangle window sampling.'
write(*,*) 'If the input value is not the same as it, please check the input. The sampling will go on with ggamma = 2/3.'

ggamma = 2.d0 / 3.d0
ggamma_half = ggamma / 2.d0
sum_n_max = n_state * ggamma
nr = n_traj !*2**n_state

allocate( ini_n(n_state) )
allocate( random_1(n_traj, n_state) )
allocate( random_2(n_traj, n_state) )
allocate( random_3(n_traj, n_state) )
allocate( random_4(n_traj, n_state) )
allocate( random_5(n_traj, n_state) )
allocate( arr_n(n_traj, n_state) )
allocate( x(n_traj, n_state) )
allocate( p_x(n_traj, n_state) )
allocate( y(n_traj, n_state) )
allocate( p_y(n_traj, n_state) )

open(10, file=filename_ini_n)
do i = 1, n_state
  read(10, *) ini_n(i)
enddo
close(10)

n = 0
do i = 1, n_state
  if ( ini_n(i) == 1) then
    i_occ = i
    n = n + 1
  endif
enddo

if (n .ne. 1) then
  write(*,*) "Wrong initial action input! Please check the file of ", filename_ini_n
  stop
endif

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

do i = 1, n_traj
  tmp = 2.d0**0.5d0
  x_tmp = (random_1(i, i_occ) - 0.5d0) * tmp
  p_x_tmp = (random_2(i, i_occ) - 0.5d0) * tmp
  y_tmp = (random_3(i, i_occ) - 0.5d0) * tmp
  p_y_tmp = (random_4(i, i_occ) - 0.5d0) * tmp
  tmp = x_tmp * p_y_tmp - y_tmp * p_x_tmp
  if (tmp < 0) then
    x_tmp = - x_tmp
    y_tmp = - y_tmp
    p_x_tmp = - p_x_tmp
    p_y_tmp = - p_y_tmp
    tmp = -tmp
  endif
  arr_n(i, i_occ) = tmp + 1
  tmp = (( tmp + 1) / tmp)**0.5d0
  x_tmp = x_tmp * tmp
  y_tmp = y_tmp * tmp
  p_x_tmp = p_x_tmp * tmp
  p_y_tmp = p_y_tmp * tmp
  x(i, i_occ) = x_tmp
  y(i, i_occ) = y_tmp
  p_x(i, i_occ) = p_x_tmp
  p_y(i, i_occ) = p_y_tmp
enddo

do i = 1, n_traj
  do j = 1, n_state
    if (j == i_occ) cycle
    tmp = ((2.d0 - arr_n(i, i_occ)) * 2.d0)**0.5d0
    x_tmp = (random_1(i, j) - 0.5d0) * tmp
    p_x_tmp = (random_2(i, j) - 0.5d0) * tmp
    y_tmp = (random_3(i, j) - 0.5d0) * tmp
    p_y_tmp = (random_4(i, j) - 0.5d0) * tmp
    tmp = x_tmp * p_y_tmp - y_tmp * p_x_tmp
    if (tmp < 0) then
      x_tmp = - x_tmp
      y_tmp = - y_tmp
      p_x_tmp = - p_x_tmp
      p_y_tmp = - p_y_tmp
      tmp = -tmp
    endif
    arr_n(i, j) = tmp
    x(i, j) = x_tmp
    y(i, j) = y_tmp
    p_x(i, j) = p_x_tmp
    p_y(i, j) = p_y_tmp
  enddo
enddo


arr_n = arr_n - 1.d0/3.d0
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
