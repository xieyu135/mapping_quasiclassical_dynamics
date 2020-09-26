subroutine sub_read_arr_1d(fnm, n, arr)
use mod_main, only: label_debug
implicit none
character(len=72) fnm
integer n
real(kind=8), dimension(n) :: arr

integer i


open(10, file=fnm)
do i = 1, n
  read(10, *) arr(i)
enddo
close(10)
if(label_debug==1)then
  write(*,*) fnm
  do i = 1, n
    write(*, *) i, arr(i)
  enddo
  write(*,*)
endif

return
end
