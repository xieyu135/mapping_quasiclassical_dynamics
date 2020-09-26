#! /usr/bin/env python2
from __future__ import print_function
from __future__ import division
import os
import sys
sys.path.append(os.path.split(os.path.realpath(__file__))[0])
import numpy as np
import complete_check
import calc_atom_distance

def get_hop_time(fnm = 'pop_adia.dat', fnm2='ene.dat', ini_state = 2, final_state = 1):
    pop_adia = np.loadtxt(fnm)
    n_time = pop_adia.shape[0]
    i_hop = -1
    for i in range(n_time):
        if pop_adia[i, final_state] > pop_adia[i, ini_state]:
            i_hop = i
            break
    return i_hop
def get_hop_time_2(fnm = 'pop.dat', fnm2='ene.dat', ini_state = 2, final_state = 1):
    '''
    When the final state is occupied (using window tricks), it is regarded as hop. 
    '''
    pop_win = np.loadtxt(fnm)
    n_time = pop_win.shape[0]
    i_hop = -1
    ind_f = final_state - 1
    ind_f_ene = ind_f + 4
    ind_i_ene = ini_state + 3
    mat_ene = np.loadtxt(fnm2, skiprows=1)
    delt_ene = abs(mat_ene[:, ind_i_ene] - mat_ene[:, ind_f_ene])
    for i in range(n_time):
        if pop_win[i, ind_f] == 1:
            i_hop = i
            break
    if i_hop != -1 :
        i_hop = np.argmin(delt_ene[:i_hop+1])
    return i_hop
def get_list_traj(n_step, n_trajs):
    check = complete_check.trajs_complete_check(n_step, n_trajs)
    list_not_complete = check.bat_check()
    #print(list_not_complete)
    list_complete = []
    for i in range(1, n_trajs+1):
        if i not in list_not_complete:
            #print(i)
            list_complete.append(i)
    return list_complete

def bat_get_hop_time(list_complete, 
                     func_get_hop=get_hop_time,
                     fnm = 'pop_adia.dat', 
                     fnm2 = 'ene.dat',
                     ini_state = 2, 
                     final_state = 1):
    main_dir = os.getcwd()
    list_hop_time = []
    for i_traj in list_complete:
        work_path = os.path.join(main_dir, 'trajs', str(i_traj))
        path_pop = os.path.join(work_path, fnm)
        path_fnm2 = os.path.join(work_path, fnm2)
        i_hop = func_get_hop(fnm = path_pop,
                             fnm2 = path_fnm2,
                             ini_state = 2, 
                             final_state = 1)
        list_hop_time.append([i_traj, i_hop])
    return list_hop_time
def get_hop_geoms(list_hop_time):
    main_dir = os.getcwd()
    #list_trajs = [i[0] for i in list_hop_time]
    lines = []
    for i_traj, i_hop in list_hop_time:
        #print(i_traj, i_hop)
        if i_hop == -1:
            continue
        work_path = os.path.join(main_dir, 'trajs', str(i_traj))
        path_geom = os.path.join(work_path, 'geom.xyz')
        x = calc_atom_distance.xyz_t(fnm = path_geom)
        n_atom = x.get_n_atom()
        coords_t = x.get_coords_t()
        atom_labels = x.get_atom_labels()
        unit = x.unit
        lines.append(str(n_atom))
        line = '%s traj: %8d  step: %s  time: %s' % (unit, 
                                                     i_traj,
                                                     x.steps[i_hop],
                                                     x.times[i_hop])
        lines.append(line)
        for i in range(n_atom):
            line = '%2s       %14.8f%14.8f%14.8f' % (atom_labels[i],
                                                     coords_t[i_hop, i, 0],
                                                     coords_t[i_hop, i, 1],
                                                     coords_t[i_hop, i, 2])
            lines.append(line)
    lines = [ line+'\n' for line in lines]
    f = open('hop_geoms.dat', 'w')
    f.writelines(lines)
    f.close()


def run():
    n_step = input('n_step:\n')
    n_trajs = input('n_trajs:\n')
    list_complete = get_list_traj(n_step, n_trajs)
    list_hop_time = bat_get_hop_time(list_complete,
                     func_get_hop=get_hop_time_2,
                     fnm = 'pop.dat', 
                     ini_state = 2, 
                     final_state = 1)
    f = open('hop_point.dat', 'w')
    for i in list_hop_time:
        line = '%8i %8i' % tuple(i)
        f.write(line+'\n')
    f.close()
    get_hop_geoms(list_hop_time)
if __name__ == '__main__':
    run()
