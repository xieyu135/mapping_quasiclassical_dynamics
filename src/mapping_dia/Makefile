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
LIB = -mkl
#
# Compilers
#
F90C = ifort
#F90C = gfortran
F90FLAGS = -FR #-I${INCDIR} #-CB -CU
#F90FLAGS =  -fastsse -tp athlonxp -I${INCDIR}
FC = ifort
#FC = gfortran
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

F90SRC =  mod_main.o  sub_read_control.o  sub_nuc_motion.o  \
sub_nuc_get_dH_div_dX_or_dP.o  sub_nuc_get_dHmn_div_dP.o  \
sub_nuc_get_dHmn_div_dX.o  sub_move.o  \
sub_write_trj_1.o  sub_write_trj_2.o \
sub_read_parameter.o  sub_read_ini_trj_1.o  sub_read_ini_trj_2.o \
sub_elec_get_dH_div_dx_or_dp.o  \
sub_get_dia_Ham_elec.o  sub_get_c_n_elec_1.o  sub_get_c_n_elec_2.o \
sub_evolution_1.o  sub_evolution_2.o  sub_elec_motion_1.o  sub_elec_motion_2.o \
sub_read_ini_trj_1.o  sub_read_ini_trj_2.o  \
sub_evolution_3.o  sub_write_trj_3.o sub_elec_motion_3.o  \
sub_sum_sq_sum_by4.o  sub_elec_motion_3_step1.o  sub_elec_motion_3_step1_2.o  \
sub_elec_motion_3_step2.o  sub_elec_motion_3_step2_2.o  \
sub_elec_get_dH_div_dx_or_dp_3.o  sub_get_c_n_elec_3.o  \
sub_elec_get_dH_div_dx_or_dp_aver_PES.o  \
sub_elec_motion_2_aver_PES.o  \
sub_nuc_motion_aver_PES.o  \
sub_nuc_get_dH_div_dX_or_dP_aver_PES.o  \
sub_nuc_get_dH_div_dP_aver_PES.o  \
sub_evolution_mapping_2_Ham_4.o  \
sub_read_parameter_Ham_4.o  \
sub_get_dia_Ham_elec_Ham_4.o  \
sub_get_dia_Ham_elec_Ham_tor.o  \
sub_elec_motion_mapping_2_Ham_4_aver_PES.o  \
sub_nuc_motion_Ham_4_aver_PES.o  \
sub_nuc_get_dHmn_div_dX_Ham_tor.o  \
sub_elec_motion_mapping_1_Ham_4.o  \
sub_evolution_mapping_1_Ham_4.o  \
sub_nuc_motion_Ham_4.o  \
sub_nuc_get_dH_div_dP.o  \
sub_write_ene_nosymm_2.o  \
sub_elec_motion_1_aver_PES.o  \
sub_write_ene_symm_2.o  \
sub_evolution_2_nuc_bin_sam.o  \
sub_nuc_motion_aver_PES_bin_sam.o  \
sub_nuc_bin_sam.o  \
sub_evolution_11.o  \
sub_elec_motion_11.o  \
sub_elec_motion_11_aver_PES.o  \
sub_evolution_2_traj_adjusted.o  \
sub_cal_gammas.o  \
sub_get_c_n_elec_2_traj_adjusted.o  \
sub_write_trj_2_traj_adjusted.o  \
sub_evolution_1_traj_adjusted.o  \
sub_write_trj_1_traj_adjusted.o  \
sub_get_c_n_elec_1_traj_adjusted.o  \
sub_cal_gammas_1.o  


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
