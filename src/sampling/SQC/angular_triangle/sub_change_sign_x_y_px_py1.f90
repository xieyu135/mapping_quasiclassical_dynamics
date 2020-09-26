subroutine sub_change_sign_x_y_px_py1(x_tmp, &
                                     y_tmp, &
                                     p_x_tmp, &
                                     p_y_tmp)

implicit none
! by Yu Xie. Email: xieyu135@sina.com
! --- arguments ---
real(kind=8) x_tmp, y_tmp, p_x_tmp, p_y_tmp

! --- local variables ---
real(kind=8) rran

CALL RANDOM_SEED()
CALL RANDOM_NUMBER(rran)
if (rran < 0.5) then
    x_tmp = - x_tmp
else
    p_y_tmp = - p_y_tmp
endif

CALL RANDOM_SEED()
CALL RANDOM_NUMBER(rran)
if (rran < 0.5) then
    y_tmp = - y_tmp
else
    p_x_tmp = - p_x_tmp
endif

end

