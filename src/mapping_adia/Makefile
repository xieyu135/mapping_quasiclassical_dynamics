#
# Paths to directories commands
#
LIBDIR = ./
INCDIR = ${LIBDIR}/include
#
# UNIX commands
#
CP    = /bin/cp -f
RM    = /bin/rm -f
MKEXE = /bin/chmod 755
AR    = /usr/bin/ar
#
# Libraries
#
LIB = -llapack -lblas
#LIB = -mkl
#
# Compilers
#
#F90C = ifort
F90C = gfortran
F90FLAGS = -FR -fcheck=bounds -I${INCDIR} #-CB -CU
#F90FLAGS = # -fastsse -tp athlonxp -I${INCDIR}
#FC = ifort
FC = gfortran
FFLAGS = 
#-O2  -funroll-loops  -march=athlon -mcpu=athlon
CC = gcc
CFLAGS = -O2 -mcpu=i486 -I. -DLINUX -D__I8=0 -D__ENDIAN=0   
RUNAR = ar rv
#
# Executable, source and objects
#
EXE  = main.exe
ARCHI = ${LIBDIR}/${EXE:.exe=.a}
MAIN = ${EXE:.exe=.f90}

FSRC = #fft3d.o

#FMOD = $(F90C) -O2 -x f95 -c

#MODSRCS = $(wildcard *.module)
#MODOBJS = $(MODSRCS:.module=.o)
#MODS = $(MODSRCS:.module=.mod)

#$(MODS) $(MODOBJS): $(MODSRCS)
#$(FC) $(CFLAGS) -x f95 -c $^

F90SRC =  mod_main.o  sub_read_control.o  \
sub_evolution_2.o  sub_read_trj_2.o  \
sub_read_parameter.o  \
sub_read_arr_1d.o  sub_read_grad.o  \
sub_read_dij.o  \
sub_p_to_p_kin.o  \
sub_p_kin_to_p.o  \
sub_elec_motion_2_aver_PES.o  \
sub_elec_motion_2_aver_PES_1step.o  \
sub_elec_motion_2_aver_PES_1step_dx_div_dt.o  \
sub_move.o  \
sub_nuc_motion_2_aver_PES.o  \
sub_nuc_motion_2_aver_PES_1step_dp_div_dt.o  \
sub_calc_dV_eff_div_dx_nuc.o  \
sub_calc_dp_nuc_kin__dij_term.o  \
sub_write_trj_2.o  \
sub_write_ene_2_aver.o


CSRC = 

#
# Dependencies
#
${ARCHI}: ${FSRC} ${F90SRC} ${CSRC}
	${AR} rv ${ARCHI} *.o

${EXE}: ${ARCHI} ${MAIN}
#	${AR} rv ${ARCHI} *.o
	${F90C} -o $@ ${F90FLAGS} ${MAIN} ${ARCHI} ${LIB}

install: ${EXE} clean

clean:
	${RM} *.o *.mod *.a

veryclean:
	${RM} ${EXE} *.o ${ARCHI}

#
# Suffix rules
#
.SUFFIXES: $(SUFFIXES) .f90
.f90.o:
	${F90C} -c ${F90FLAGS} $*.f90
.f.o:
	${FC} -c ${FFLAGS} $*.f
.c.o:
	${CC} -c ${CFLAGS} $*.c
