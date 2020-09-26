#!/usr/bin/env python
import numpy as np
#import sys
#import os
#sys.path.append(os.path.split(os.path.realpath(__file__))[0])
from window import calc_pop_t_0_part
from window import get_W_0

def ffilter(n_state, 
            ggamma, 
            traj_inp_file='trj_elec.input' 
            ):
    '''
    Identify trajs with pop_t_0_part = 0,
    and do not run them in the following precedure.
    '''
    W_t_0_n_0, W_t_0_n_1 = get_W_0(n_state, 
                                   ggamma, 
                                   traj_file = traj_inp_file)

    pop_t_0_part = calc_pop_t_0_part(n_state, W_t_0_n_0, W_t_0_n_1)
    fnm_pop_t_0_part = 'pop_t_0_part.dat'
    f_pop = open(fnm_pop_t_0_part, 'w')
    f_pop.write(str(pop_t_0_part)+'\n')
    f_pop.close()
    return pop_t_0_part

if __name__ == '__main__':
    n_state = input('n_state:\n')
    #n_state = 2
    ggamma = input('ggamma:\n')
    #ggamma = 0.5
    iindex = ffilter(n_state,
                     ggamma,
                     traj_inp_file='trj_elec.input')
    #print iindex

