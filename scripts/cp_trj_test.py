
import sys
import os
import shutil
sys.path.append(os.path.split(os.path.realpath(__file__))[0])
from tool_xy import mkdir_p
from d2a_ini_trj_elec import test as ini_trj_elec

n_traj = 100
inp_list = ['dyn.input', 
            'ene.input', 
            'freq.input', 
            'k_tun.input',
            'lambda0_coupling.input',
            'lambda1_coupling.input',
            'trj.input']

main_dir = os.getcwd()
for i in range(1, n_traj+1):
#    mkdir_p('trajs' + os.path.sep + str(i))
    work_dir = os.path.join(main_dir, 'trajs', str(i))
#    print(work_dir)
    mkdir_p(work_dir)
    for fnm in inp_list:
        source_dir = main_dir
        target_dir = work_dir
        source_file = os.path.join(source_dir,  fnm)
        target_file = os.path.join(target_dir, fnm)
        shutil.copyfile(source_file, target_file)
    os.chdir(work_dir)
    ini_trj_elec()
