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
#LIB = -llapack -lblas
#LIB = -mkl
#
# Compilers
#
#F90C = ifort
F90C = gfortran
F90FLAGS = -FR #-I${INCDIR} #-CB -CU
#F90FLAGS =  -fastsse -tp athlonxp -I${INCDIR}
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

F90SRC =  mod_main.o  \
sub_read_input.o \
sub_sampling_action_angle.o \
sub_random_sign.o  \
sub_change_sign_x_y_px_py1.o  \
sub_change_sign_x_y_px_py2.o  \
sub_random_inverse.o  \
sub_random_rate.o  \
sub_sampling_x_py_rate_abs_max2.o  \
sub_sampling_infinitive.o \
sub_sampling_infinitive2.o \
sub_sampling_infinitive_neglect_minus.o  \
sub_sampling_infinitive_es_nes.o \
sub_sampling_infinitive_es_es.o  \
sub_sampling_infinitive_nes_nes.o \
sub_sampling_x_py_rate_abs_max_es_nes.o  \
sub_sampling_x_py_rate_abs_max_neglect_minus.o \
sub_neglect_minus.o \
sub_random_symm.o \
sub_random_rate_seed.o \
sub_exchange_xpy_ypx.o \
sub_gener_x_py_rate_lt_cons_same_sign.o \
sub_gener_x_py_rate_lt_cons_random_sign.o \
sub_gener_x_py_rate_lt_cons_diff_sign.o \
sub_gener_arr_n_triangle.o

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
