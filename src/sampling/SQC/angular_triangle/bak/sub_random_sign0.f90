subroutine sub_random_sign0(ssign)

implicit none
! by Yu Xie. Email: xieyu135@sina.com

! --- arguments ---
real(kind=8) ssign

! --- local variables ---
real(kind=8) rran

CALL RANDOM_SEED()
CALL RANDOM_NUMBER(rran)

if (rran > 0.5) then
  ssign = 1.d0
else
  ssign = -1.d0
endif


end
