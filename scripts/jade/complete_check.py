#! /usr/bin/env python
from __future__ import print_function
import os
import numpy as np

class trajs_complete_check():
    """checking which traj is not completed"""
    def __init__(self, n_step, n_trajs, fnm='pop_adia.dat'):
        self.n_step = n_step
        self.n_trajs = n_trajs
        self.fnm = fnm
    def complete_check(self, fnm):
        if not os.path.exists(fnm) :
            complete = None
        else :
            pop_adia = np.loadtxt(fnm)
            if len(pop_adia.shape) == 1 :
                complete = None
            else:
                complete = (pop_adia[-1, 0] == self.n_step)
        return complete
    def bat_check(self):
        list_not_complete = []
        for i in range(1, self.n_trajs +1):
            #print (i)
            fnm = os.path.join("trajs", str(i), self.fnm)
            complete = self.complete_check(fnm)
            if not complete :
                list_not_complete.append(i)
        return list_not_complete
def run_dyn(jobs):
    main_dir = os.getcwd()
    for i in jobs:
        work_dir = os.path.join(main_dir, "trajs", str(i))
        os.chdir(work_dir)
        print(work_dir + "  submit jade")
        #os.system('jade.exe > jade.out&') 
        os.system('bsub sub_jade.sh')
if __name__ == "__main__":
    n_step = input('n_step:')
    n_trajs = input('n_trajs:')
    check = trajs_complete_check(n_step, n_trajs)
    list_not_complete = check.bat_check()
    print(list_not_complete)
#    run_dyn(list_not_complete)




