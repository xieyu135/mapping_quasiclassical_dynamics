subroutine sub_random_rate_seed(nr, &
               n_state, &
               seed1, &
               seed2, &
               x, &
               p_y)
implicit none
! by Yu Xie. Email: xieyu135@sina.com
! sign(x) is the same as sign(p_y)
! sign(y) is different from sign(p_x)

! --- arguments ---
integer nr
integer n_state
integer seed1
integer seed2
real(kind=8) x(nr, n_state)
real(kind=8) p_y(nr, n_state)

! --- local variables ---
real(kind=8) random_1(nr, n_state)
real(kind=8) random_2(nr, n_state)

CALL RANDOM_SEED(seed1)
CALL RANDOM_NUMBER(random_1)

CALL RANDOM_SEED(seed2)
CALL RANDOM_NUMBER(random_2)

call sub_random_rate(nr, n_state, x, p_y, random_1, random_2) 


end
