#!/usr/bin/env python
import os
import multiprocessing

def run_trj(work_path, com):
    os.chdir(work_path)
    print work_path
    os.system(com)

#com='/home/xieyu/forProgram/mapping/src/ver_vv_LVC/ver2/main.exe'
com='/home/xieyu/forProgram/mapping/src/ver_vv_vij_0_1/ver2/main.exe'
n_traj = 500
npro = 8
main_path = os.getcwd()

n_traj_1 = n_traj + 1


pool = multiprocessing.Pool(processes = npro)
for i in range(1, n_traj_1):
    work_path = main_path + '/trajs/' + str(i)
    pool.apply_async(run_trj, (work_path, com, ))
pool.close()
pool.join()
