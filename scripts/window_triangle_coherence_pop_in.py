#!/usr/bin/env python
import numpy as np
# coding
def win_coherence_func(n1, n2):
    if (n1 >= 1./6. and n1 <= 7./6. 
    and n2 >= 1./6. and n2 <= 7./6.
    and n1 + n2 < 4./3.):
        return 1
    else:
        return 0

def win_arr_coherence_func(n1_arr, n2_arr):
    coherence = []
    for n1, n2 in zip(n1_arr, n2_arr):
        coherence.append(win_coherence_func(n1, n2))
    return np.array(coherence)
class window_pop_in():
    def __init__(self, 
                fnm_pop, 
                n_state=2, 
                ggamma=1.0/3.0, 
                n_time=0):
        self.fnm_pop = fnm_pop
        self.n_state = n_state
        self.ggamma = ggamma
        self.n_time = n_time
    def get_coherence_t(self, flag_debug = False):
        n_state = self.n_state
        n = np.loadtxt(self.fnm_pop)[:,1:]
        if not self.n_time:
            self.n_time = n.shape[0]
        coherence_t = np.zeros((self.n_time, n_state, n_state))
        for i in range(n_state -1):
            for j in range(i+1, n_state):
                n1_arr, n2_arr = n[:,i], n[:,j]
                coherence = win_arr_coherence_func(n1_arr, n2_arr)
                for it in range(self.n_time):
                    coherence_t[it,i,j] = coherence[it]
                    coherence_t[it,j,i] = coherence[it]
                if flag_debug:
                    fnm = 'coherence_'+str(i+1)+'_'+str(j+1)+'.dat'
                    np.savetxt(fnm, coherence, fmt = '%8.4f')
        return coherence_t

if __name__ == '__main__':
    n_state = input('n_state:\n')
    #n_state = 2
    #ggamma = input('ggamma:\n')
    #ggamma = 0.5
    win_tri = window_pop_in('pop_dia.dat', n_state)
    win_tri.get_coherence_t(flag_debug = True)
