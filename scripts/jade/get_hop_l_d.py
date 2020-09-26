#! /usr/bin/env python2
from __future__ import print_function
from __future__ import division
import os
import sys
sys.path.append(os.path.split(os.path.realpath(__file__))[0])
import numpy as np
#import complete_check
#import calc_atom_distance

def load_hop_point(fnm='hop_point.dat'):
    f = open(fnm, 'r')
    lines = f.readlines()
    list_hop_time = []
    list_hop_time2 = []
    for line in lines:
        list_hop_time.append(line.strip().split())
    for i_traj, i_hop in list_hop_time:
        if int(i_hop) != -1:
            list_hop_time2.append([int(i_traj), int(i_hop)])
    return list_hop_time2
def load_skip3(fnm):
    return np.loadtxt(fnm, skiprows=3)
def get_hop_value(list_hop_time, fnm):
    main_dir = os.getcwd()
    values = []
    for i_traj, i_hop in list_hop_time:
        #print(i_traj, i_hop)
        work_path = os.path.join(main_dir, 'trajs', str(i_traj))
        path_value_file = os.path.join(work_path, fnm)
        mat_value = load_skip3(path_value_file)
        values.append(mat_value[i_hop, 1])
    return values

def run():
    list_hop_time = load_hop_point()
    files = 'l12.dat  d1256.dat  d1265.dat  d2134.dat  d2143.dat  d3421.dat  d6512.dat'.split()
    multi_values = []
    for fnm in files:
        multi_values.append(get_hop_value(list_hop_time, fnm))
    mat_hop = np.array(list_hop_time)
    mat_values = np.array(multi_values).T
    #print(mat_hop.shape)
    #print(mat_values.shape)
    mat_hop_values = np.hstack((mat_hop, mat_values))
    np.savetxt('hop_l_d.dat', mat_hop_values, fmt='%8d%8d'+'%14.7f'*(mat_hop_values.shape[1]-2))

if __name__ == '__main__':
    run()
