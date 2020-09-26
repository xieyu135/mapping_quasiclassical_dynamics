#!/usr/bin/env python2
from __future__ import print_function
from __future__ import division
import os
import numpy as np
import sys
sys.path.append(os.path.split(os.path.realpath(__file__))[0])
import calc_atom_distance
import complete_check



def run_trj(i_atom1, i_atom2, work_path):
    os.chdir(work_path)
    x = calc_atom_distance.xyz_t()
    x.run()
    mat_distance = x.get_atom_distance_time(i_atom1, i_atom2)
    np.savetxt('dist_C_N.dat', mat_distance, fmt='%14.8f '*mat_distance.shape[1])
    return mat_distance
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
def bat_run(list_complete, i_atom1, i_atom2):
    main_dir = os.getcwd()
    list_mat_distance = []
    for i_traj in list_complete:
        work_path = os.path.join(main_dir, 'trajs', str(i_traj))
        mat_distance = run_trj(i_atom1, i_atom2, work_path)
        list_mat_distance.append(mat_distance)
    time = np.reshape(list_mat_distance[0][:,0], (-1,1))
    list_distance_all_traj = []
    for i in range(len(list_mat_distance)):
        list_distance_all_traj.append(list_mat_distance[i][:,1])
    mat_distance_all_traj = np.array(list_distance_all_traj).T
    mat_time_distance_all_traj = np.hstack((time, mat_distance_all_traj))
    #print(mat_time_distance_all_traj)
    os.chdir(main_dir)
    return mat_time_distance_all_traj

#def bat_run(list_traj, i_atom1, i_atom2):
if __name__ == "__main__":
    n_step = input('n_step:\n')
    n_trajs = input('n_trajs:\n')
    i_atom1 = input('i_atom1:\n')
    i_atom2 = input('i_atom2:\n')

    list_complete = get_list_traj(n_step, n_trajs)
    mat_time_distance_all_traj = bat_run(list_complete, i_atom1, i_atom2)
    np.savetxt('dist_C_N_all_trajs.dat', mat_time_distance_all_traj, fmt='%14.8f '*mat_time_distance_all_traj.shape[1])
