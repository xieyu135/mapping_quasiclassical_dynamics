#!/usr/bin/env python
import numpy as np

def gener_dyn_control_file(n_state,
                           n_mode,
                           ggamma,
                           n_step,
                           nuc_dt,
                           n_ele_dt,
                           n_save_trj,
                           label_restart,
                           label_diabatic,
                           label_debug):
    f = open('dyn.input', 'w')
    print >>f, '&dyn_control'
    print >>f, 'n_state = ', n_state
    print >>f, 'n_mode = ', n_mode
    print >>f, 'ggamma = ', ggamma
    print >>f, 'n_step = ', n_step
    print >>f, 'nuc_dt = ', nuc_dt
    print >>f, 'n_ele_dt = ', n_ele_dt
    print >>f, 'n_save_trj = ', n_save_trj
    print >>f, 'label_restart = ', label_restart
    print >>f, 'label_diabatic = ', label_diabatic
    print >>f, 'label_debug = ', label_debug
    print >>f, '/'
    f.close()

def gener_sampling_action_angle_elec_input(n_state,
                                           n_trajs,
                                           elec_init_occ_file,
                                           ggamma
                                           ):
    f = open('main_action_angle_elec_input', 'w')
    print >>f, n_state, ' # n_state'
    print >>f, n_trajs, ' # n_trajs'
    print >>f, elec_init_occ_file, ' # filename of initial n(occupation)'
    print >>f, ggamma, ' # ggamma'
    f.close()

def gener_elec_init_occ_file(elec_init_occ_file,
                             n_state,
                             occ_state):
    f = open(elec_init_occ_file, 'w')
    arr = [0]
    arr = arr * n_state
    arr[occ_state - 1] = 1
    for i in arr:
        print >>f, i
    f.close()

def gener_sampling_action_angle_nuc_input(n_mode,
                                          n_trajs,
                                          nuc_init_occ_file,
                                          ggamma):
    f = open('main_action_angle_nuc_input', 'w')
    print >>f, n_state, ' # n_state'
    print >>f, n_trajs, ' # n_trajs'
    print >>f, nuc_init_occ_file, ' # filename of initial n(occupation)'
    print >>f, ggamma, ' # ggamma'
    f.close()

def gener_nuc_init_occ_file(nuc_init_occ_file,
                            n
                            ):
    f = open(nuc_init_occ_file, 'w')
    arr = [0]
    arr = arr * n
    for i in arr:
        print >>f, i
    f.close()
def gener_sampling_Tk_nuc_input(fnm, 
                                n_mode,
                                n_trajs,
                                label_method,
                                Tk):
    nr = n_mode * n_trajs
    content = '''1 read (*,*) n_atom
%d read (*,*) n_mode
read (*,*)
1 read (*,*) label_random
%d read (*,*) nr
50 read (*,*) nbin
read (*,*)
2 read (*,*) label_read_vib
3 read (*,*) label_es_output
freq.log  read (*,*) filename_es_output
read (*,*)
0 read (*,*) label_displacement
read (*,*)
0 read (*,*) label_dis_wigner
read (*,*)
%d read (*,*) n_geom
%d read (*,*) label_method
%d read (*,*) t_k
read (*,*)
0 read (*,*) label_frozen
2 read (*,*) number_frozen
1  2  read (*,*) list_frozen
''' % (n_mode, nr, n_trajs, label_method, Tk)
    f = open(fnm, 'w')
    f.write(content)
    f.close()

def gener_extra_ini_trj_input(n_trajs,
                              n_mode):
    f = open('extra_ini_trj_input', 'w')
    print >>f, n_trajs, ' # n_trajs'
    print >>f, n_mode, ' # n_mode'
    f.close()

def gener_traj_pop_aver_SQC_input(n_state,
                                  dt_save,
                                  n_trajs,
                                  n_time):
    f = open('traj_pop_aver_SQC_input', 'w')
    print >>f, n_state, ' # n_state'
    print >>f, dt_save, ' # dt_save'
    print >>f, n_trajs, ' # n_trajs'
    print >>f, n_time, ' # n_time'
    f.close()


n_state = input('n_state:\n')
n_mode = input('n_mode:\n')
ggamma = input('ggamma:\n')
n_trajs = input('n_trajs:\n')
occ_state = input('occupied state:\n')
n_step  = input('n_step:\n')
nuc_dt = input('nuc_dt:\n')
n_ele_dt = input('n_ele_dt:\n')
n_save_trj = input('n_save_trj:\n')
label_restart = input('label_restart:\n')
label_diabatic = input('label_diabatic:\n')
label_debug = input('label_debug:\n')
nuc_sampling_method = input('''
nuc_sampling_method:
1. action_angle
2. wigner (temperature)
3. action angle (temperature)
''')
if nuc_sampling_method == 1 :
    nuc_init_occ_file = 'ini_n_nuc.inp'
    gener_sampling_action_angle_nuc_input(n_mode,
                                          n_trajs,
                                          nuc_init_occ_file,
                                          1)
    gener_nuc_init_occ_file(nuc_init_occ_file, n_mode)
elif nuc_sampling_method == 2 :
    fnm = 'main_Tk_nuc_input'
    label_method = 11
    Tk = input('Temperature(K):\n')
    gener_sampling_Tk_nuc_input(fnm, 
                                n_mode,
                                n_trajs,
                                label_method,
                                Tk)
    gener_extra_ini_trj_input(n_trajs,
                              n_mode)
elif nuc_sampling_method == 3 :
    fnm = 'main_Tk_nuc_input'
    label_method = 6
    Tk = input('Temperature(K):\n')
    gener_sampling_Tk_nuc_input(fnm, 
                                n_mode,
                                n_trajs,
                                label_method,
                                Tk)
    gener_extra_ini_trj_input(n_trajs,
                              n_mode)
else :
    print 'Wrong nuc_sampling_method input!'
    raise IOError
elec_init_occ_file = 'ini_n_elec.inp'
n_time = n_step//n_save_trj + 1
dt_save = n_save_trj * nuc_dt
#print n_state


gener_sampling_action_angle_elec_input(n_state,
                                       n_trajs,
                                       elec_init_occ_file,
                                       ggamma)

gener_elec_init_occ_file(elec_init_occ_file, 
                         n_state, 
                         occ_state)

gener_dyn_control_file(n_state,
                       n_mode,
                       ggamma,
                       n_step,
                       nuc_dt,
                       n_ele_dt,
                       n_save_trj,
                       label_restart,
                       label_diabatic,
                       label_debug)

gener_traj_pop_aver_SQC_input(n_state,
                              dt_save,
                              n_trajs,
                              n_time)

