#!/usr/bin/env python
import numpy as np

def win_func_arr(n):
    thresh = 1. - 1./3.
    n_state = n.shape[0]
    W_arr = np.ones((n_state,))
    for i in range(n_state):
        for j in range(n_state):
            if ( j==i and n[j] < thresh ) or ( j!=i and n[j] >= thresh ) :
                W_arr[i] = 0.
    return W_arr

class window_pop_in():
    def __init__(self, fnm_pop, n_state, ggamma=1.0/3.0):
        self.fnm_pop = fnm_pop
        self.n_state = n_state
        self.ggamma = ggamma
    def get_pop(self):
        n_state = self.n_state
        n = np.loadtxt(self.fnm_pop)[:,1:]
        n_traj = n.shape[0]
        for i in range(n_traj):
            pop[i,:] = win_func_arr(n[i,:])
        fnm_pop = 'pop.dat'
        np.savetxt(fnm_pop, pop, fmt='%10.8f  '*pop.shape[1])

if __name__ == '__main__':
    n_state = input('n_state:\n')
    #n_state = 2
    ggamma = input('ggamma:\n')
    #ggamma = 0.5
    win_tri = window_pop_in('pop_dia.dat', n_state)
    win_tri.get_pop()
