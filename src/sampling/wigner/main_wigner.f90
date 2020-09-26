program main_action_angle
implicit none

include 'param.def'

integer n_mode
integer n_traj
character(len=72) filename_freq
character(len=72) filename_x_p_traj
real(kind=8) t_k
real(kind=8), allocatable, dimension(:) : frequency
real(kind=8), allocatable, dimension(:,:) :: x, &
                                             p, &
                                             random_1, &
                                             random_2


integer i, j


write(*,*) 'n_mode:'
read(*,*) n_mode

write(*,*) 'n_traj:'
read(*,*) n_traj

write(*,*) 'Temperature(K):'
read(*,*) t_k

write(*,*) 'filename_freq:'
read(*,*) filename_freq


allocate( frequency(n_mode) )
allocate( x(n_traj, n_mode) )
allocate( p(n_traj, n_mode) )
allocate( random_1(n_traj, n_mode) )
allocate( random_2(n_traj, n_mode) )

open(10, file=filename_freq)
do j = 1, n_mode
  read(10, *) frequency(j)
enddo
CALL RANDOM_SEED()
CALL RANDOM_NUMBER(random_1)

do i = 1, n_traj
  do j = 1, n_mode
    alpha = tanh( ( frequency(j)/ TOCM) /   &
            (2 * KB * t_k )  )
    random_1(i, j) = (-   log( random_1(i, j)  )    &
                      / log(2.718281828)    &
                      ) ** 0.5
  enddo
enddo

CALL RANDOM_SEED()
CALL RANDOM_NUMBER(random_2)


do i = 1, n_traj
  do j = 1, n_mode
    angle = 2* PI * random_2(i, j)
    aaction = random_1(i, j)
    x(i, j) = aaction * cos(angle)
    p(i, j) = aaction * sin(angle)
  enddo
enddo

do i = 1, n_traj
  write(filename_x_p_traj,*) i
  filename_x_p_traj = 'traj_' // trim(adjustl(filename_x_p_traj))//'.inp'
  open(10, file=filename_x_p_traj)
  do j = 1, n_mode
    write(10,9999) x(i, j), p(i, j)
  enddo
  close(10)
enddo



deallocate( ini_n )
deallocate( x )
deallocate( p )

9999 format(2f18.14)

end
