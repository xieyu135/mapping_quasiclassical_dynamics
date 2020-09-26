subroutine sub_read_input
use mod_main
implicit none
! by Yu Xie. Email: xieyu135@sina.com

write(*,*) 'n_state:'
read(*,*) n_state

write(*,*) 'n_traj:'
read(*,*) n_traj

write(*,*) 'ini_state:'
read(*,*) ini_state

write(*,*) 'gamma:'
read(*,*) ggamma
write(*,*) ggamma
write(*,*) 'Acturally, we choose ggamma = 1/3 in triangle window sampling.'
write(*,*) 'If the input value is not the same as it, please check the input. '
write(*,*) 'The sampling will go on with ggamma = 1/3.'

ggamma = 1.d0 / 3.d0


write(*,*) "label_x_py_rate_abs_max:"
write(*,*) '0. label_x_py_rate_abs_max is infinitive;'
write(*,*) '1. label_x_py_rate_abs_max = 1;'
write(*,*) '2. label_x_py_rate_abs_max > 1 and is not infinitive.'
read(*,*) label_x_py_rate_abs_max

if (label_x_py_rate_abs_max .ne. 0 ) then
  write(*,*) 'The maxmum of abs(x/py):'
  read(*,*) x_py_rate_abs_max
endif

if (label_x_py_rate_abs_max == 0) then
  continue
elseif (x_py_rate_abs_max > 1.d0 .and. label_x_py_rate_abs_max == 2) then
  continue
elseif (x_py_rate_abs_max < 1.d0) then
  write(*,*) 'The maxmum of abs(x/py) should be equal or greater than 1.'
  stop
else
  write(*,*) 'label_x_py_rate_abs_max does not match x_py_rate_abs_max.'
  write(*,*) 'label_x_py_rate_abs_max:', label_x_py_rate_abs_max
  write(*,*) 'x_py_rate_abs_max:', x_py_rate_abs_max
endif
x_py_rate_abs_min = 1.d0/x_py_rate_abs_max

end
