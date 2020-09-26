subroutine sub_read_ene(fnm, ene)
use mod_main
implicit none
include "param.def"
character(len=72) fnm
real(kind=8), dimension(n_state) :: ene

integer i_state

open(10, file=fnm)
do i_state = 1, n_state
  read(10, *) ene(i_state)
enddo
close(10)
if(label_debug==1)then
  write(*, *) "state energy (eV)"
  do i_state = 1, n_state
    write(*, *) i_state, ene(i_state)
  enddo
  write(*, *)
endif

return
end
