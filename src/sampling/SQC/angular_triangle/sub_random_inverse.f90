subroutine sub_random_inverse(tmp)

implicit none
! by Yu Xie. Email: xieyu135@sina.com
! --- arguments ---
real(kind=8) tmp

! --- local variables ---
real(kind=8) rran

CALL RANDOM_SEED()
CALL RANDOM_NUMBER(rran)

if (rran < 0.5) then
  tmp = 1.d0/tmp
endif


end

