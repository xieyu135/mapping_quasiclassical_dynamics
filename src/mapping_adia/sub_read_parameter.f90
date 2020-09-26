subroutine sub_read_parameter(exci_e_cur, exci_e_pre, &
                    grad, dij_cur, dij_pre, mass) 
use mod_main
implicit none
include "param.def"
real(kind=8), dimension(n_state) :: exci_e_cur, &
                                    exci_e_pre
real(kind=8), dimension(n_state, n_mode) :: grad
real(kind=8), dimension(n_state, n_state, n_mode) :: dij_cur, &
                                                     dij_pre
real(kind=8), dimension(n_mode) :: mass

integer i_state, j_state, i_mode, itmp
character(len=72) ctmp

exci_e_cur = 0.d0
exci_e_pre = 0.d0
grad = 0.d0
dij_cur = 0.d0
dij_pre = 0.d0

ctmp = 'ene_cur.input'
call sub_read_arr_1d(ctmp, n_state, exci_e_cur)

ctmp = 'ene_pre.input'
call sub_read_arr_1d(ctmp, n_state, exci_e_pre)

ctmp = 'mass.input'
call sub_read_arr_1d(ctmp, n_mode, mass)

ctmp = 'grad.input'
call sub_read_grad(ctmp, grad)

ctmp = 'dij_cur.input'
call sub_read_dij(ctmp, dij_cur)

ctmp = 'dij_pre.input'
call sub_read_dij(ctmp, dij_pre)

exci_e_cur = exci_e_cur/TOEV
exci_e_pre = exci_e_pre/TOEV
grad = grad/TOEV
dij_cur = dij_cur/TOEV
dij_pre = dij_pre/TOEV


return
end
