#!/usr/bin/env python
import os
import multiprocessing
import sys
sys.path.append(os.path.split(os.path.realpath(__file__))[0])
import window_angular

def run_trj(n_state, delt_n, work_path):
    os.chdir(work_path)
    print work_path
    window_angular.get_pop(n_state, 
		   delt_n, 
		   pop_file='pop_dia.dat')

#com='/home/xieyu/forProgram/mapping/src/ver_vv_LVC/ver2/main.exe'
def bat_run(n_state, delt_n, i_op, i_ed):
    npro = 8
    main_path = os.getcwd()
    
    pool = multiprocessing.Pool(processes = npro)
    for i in range(i_op, i_ed+1):
        work_path = main_path + '/trajs/' + str(i)
        pool.apply_async(run_trj, (n_state, delt_n, work_path, ))
    pool.close()
    pool.join()
if __name__ == '__main__':
    n_state = input('n_state:\n')
    n_mode = input('n_mode:\n')
    delt_n = input('delt_n:\n')
    n_traj = input('n_traj:\n')
    bat_run(n_state, delt_n, 1, n_traj)
    

