subroutine sub_read_trj_2(x_nuc_cur, p_nuc_cur, &
                    x_nuc_pre, p_nuc_pre, &
                    x_elec, p_elec) 
use mod_main
implicit none

include "param.def"

integer i_mode
integer i_state

!double precision :: q
real(kind=8), dimension(n_mode) :: x_nuc_cur, p_nuc_cur
real(kind=8), dimension(n_mode) :: x_nuc_pre, p_nuc_pre
real(kind=8), dimension(n_state) :: x_elec, p_elec




open(unit=11, file="x_p_nuc_cur.input")
do i_mode=1, n_mode
   read (11, *)  x_nuc_cur(i_mode), p_nuc_cur(i_mode)
enddo
close(11)

open(unit=12, file="x_p_nuc_pre.input")
do i_mode=1, n_mode
   read (12, *)  x_nuc_pre(i_mode), p_nuc_pre(i_mode)
enddo
close(12)

open(21, file="x_p_elec.input")
do i_state = 1, n_state
  read(21, *) x_elec(i_state), p_elec(i_state)
enddo
close(21)

if(label_debug == 1)then

write(*,*) "x_nuc_cur, p_nuc_cur"
do i_mode=1, n_mode
  write(*,*) x_nuc_cur(i_mode), p_nuc_cur(i_mode)
enddo
write(*,*) 

write(*,*) "x_nuc_pre, p_nuc_pre"
do i_mode=1, n_mode
  write(*,*) x_nuc_pre(i_mode), p_nuc_pre(i_mode)
enddo
write(*,*) 

write(*,*) "x_elec, p_elec"
do i_state = 1, n_state
  write(*,*) x_elec(i_state), p_elec(i_state)
enddo
write(*,*)

endif

end
