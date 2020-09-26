program main_action_angle_uni_angular_triangle_xy
implicit none

include 'param.def'

integer n_state
integer n_traj
character(len=72) filename_ini_n
character(len=72) filename_x_p_traj
real(kind=8), allocatable, dimension(:) :: ini_n
real(kind=8), allocatable, dimension(:,:) :: x, &
                                             y, &
                                             p_x, &
                                             p_y, &
                                             random_1, &
                                             random_2, &
                                             arr_n
real(kind=8) ggamma
real(kind=8) ggamma_half
real(kind=8) sum_n_max

integer i, j, k, seed, nr
real(kind=8) angle, aaction, sigma, tmp





CALL RANDOM_SEED()
do i = 1, 100
CALL RANDOM_NUMBER(ggamma)
write(*,*) ggamma
enddo




9999 format(4f18.14)

end
