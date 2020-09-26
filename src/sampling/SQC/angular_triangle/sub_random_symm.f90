subroutine sub_random_symm(nr, seed, random_1)
use mod_main
implicit none
! by Yu Xie. Email: xieyu135@sina.com
! sign(x) is the same as sign(p_y)
! sign(y) is different from sign(p_x)

! --- arguments ---
integer nr
integer seed
real(kind=8) random_1(nr, n_state)

! --- local variables ---


CALL RANDOM_SEED(seed)
CALL RANDOM_NUMBER(random_1)
random_1 = random_1 - 0.5d0 ! x


end
