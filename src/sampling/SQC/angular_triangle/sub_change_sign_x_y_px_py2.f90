subroutine sub_change_sign_x_y_px_py2(x_tmp, &
                                     y_tmp, &
                                     p_x_tmp, &
                                     p_y_tmp)

implicit none
! by Yu Xie. Email: xieyu135@sina.com
! --- arguments ---
real(kind=8) x_tmp, y_tmp, p_x_tmp, p_y_tmp

! --- local variables ---
real(kind=8) t1, t2, t3, t4

t1 = x_tmp
t2 = y_tmp
t3 = p_x_tmp
t4 = p_y_tmp

x_tmp = t2
y_tmp = t1
p_x_tmp = t4
p_y_tmp = t3

end

