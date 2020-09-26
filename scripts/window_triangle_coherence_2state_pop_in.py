#!/usr/bin/env python
import numpy as np

def win_coherence_func(n1, n2):
    if (n1 >= 1./6. and n1 <= 7./6. 
    and n1 >= 1./6. and n1 <= 7./6.
    and n1 + n2 < 4./3.):
        return 1
    else:
        return 0

def win_arr_coherence_func(n1_arr, n2_arr)：
    coherence = []
    for n1, n2 in zip(n1_arr, n2_arr):
        coherence.append(win_coherence_func(n1, n2))
    return np.array(coherence)
class window_pop_in():
    def __init__(self, fnm_pop, n_state=2, ggamma=1.0/3.0):
        self.fnm_pop = fnm_pop
        self.n_state = n_state
        self.ggamma = ggamma
    def get_coherence_t(self):
        n_state = self.n_state
        n = np.loadtxt(self.fnm_pop)[:,1:]
        n1_arr, n2_arr = n[:,0], n[:,1]
        coherence = win_arr_coherence_func(n1_arr, n2_arr)
        np.savetxt('coherence.dat', coherence, fmt = '%8.4f')

if __name__ == '__main__':
    n_state = input('n_state:\n')
    #n_state = 2
    ggamma = input('ggamma:\n')
    #ggamma = 0.5
    win_tri = window_pop_in('pop_dia.dat', n_state)
    win_tri.get_coherence_t()
