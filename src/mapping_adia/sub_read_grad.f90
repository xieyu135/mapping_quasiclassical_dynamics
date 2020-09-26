subroutine sub_read_grad(fnm, grad)
use mod_main
implicit none
include "param.def"
character(len=72) fnm
real(kind=8), dimension(n_state, n_mode) :: grad

integer i_state, i_mode, itmp
character(len=72) ctmp


open(10, file=fnm)
do i_state = 1, n_state
  read(10, '(a72)') ctmp
  do i_mode = 1, n_mode
    read(10, *) itmp, grad(i_state, i_mode)
  enddo
  if(label_debug==1) then
    write(*,*) "grad"
    write(*,*) ctmp
    do i_mode = 1, n_mode
      write(*, *) i_mode, grad(i_state, i_mode)
    enddo
    write(*, *)
  endif
enddo
close(10)

return
end
