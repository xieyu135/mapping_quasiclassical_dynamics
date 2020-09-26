subroutine sub_read_dij(fnm, dij)
use mod_main
implicit none
include "param.def"
character(len=72) fnm
real(kind=8), dimension(n_state, n_state, n_mode) :: dij

integer i_state, j_state, i_mode, itmp
character(len=72) ctmp


open(10, file=fnm)
do while(.true.)
  read(10,*, end=135)  ctmp, i_state, j_state
  do i_mode = 1, n_mode
    read(10, *) itmp, dij(i_state, j_state, i_mode)
  enddo
  if(label_debug==1) then
    write(*,*) fnm
    write(*,*) trim(adjustl(ctmp)), i_state, j_state
    do i_mode = 1, n_mode
      write(*, *) i_mode, dij(i_state, j_state, i_mode)
    enddo
    write(*,*)
  endif
enddo
135 close(10)

if(label_debug==1) then
  do i_state = 1, n_state
    do i_mode = 1, n_mode
      if(dij(i_state, i_state, i_mode) /= 0.d0 ) then
        write(*,*) 'Error in', fnm
        write(*,*) "dij(", i_state, i_state, i_mode, ") does not equal to 0."
        stop
      endif
    enddo
  enddo
endif

if(label_debug==1) then
  do i_state = 1, n_state-1
    do j_state = i_state+1, n_state
      do i_mode = 1, n_mode
        if(dij(i_state, j_state, i_mode) /= &
         - dij(j_state, i_state, i_mode) ) then
          write(*,*) 'Error in', fnm
          write(*,*) "dij(", i_state, j_state, i_mode, ")"
          write(*,*) " does not equal to "
          write(*,*) " - dij(", j_state, i_state, i_mode, ")."
          stop
        endif
      enddo
    enddo
  enddo
endif

return
end
