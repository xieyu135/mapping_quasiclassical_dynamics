#!/usr/bin/env python
from __future__ import print_function
import os
import sys
import numpy as np
from window_triangle_coherence_pop_in_rescale import window_pop_in

def calDiffusionLength(fnm_pop='pop_t.dat'):
    pop_t = np.loadtxt(fnm_pop)
    time = pop_t[:,0]
    pop_t = pop_t[:,1:]
    # i * pop[i]
    n_time, n_state = pop_t.shape
    diff_len_t = np.zeros((n_time,2))
    diff_len_t[:,0] = time
    for i_time in range(n_time):
        aver_i = 0
        aver_i_sq = 0
        for i_state in range(n_state):
            aver_i = aver_i + i_state * pop_t[i_time, i_state]
            aver_i_sq = aver_i_sq + i_state**2 * pop_t[i_time, i_state]
        aver_i = aver_i/float(n_state)
        aver_i_sq = aver_i_sq/float(n_state)
        diff_len_t[i_time,1] = (aver_i_sq - aver_i**2)**0.5
    np.savetxt('diff_len_t.dat', diff_len_t)

        
if __name__ == '__main__':
    calDiffusionLength()

