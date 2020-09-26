#!/usr/bin/env python
import numpy as np

def get_W_t(n_state, gamma, pop_file='pop_dia.dat'):
    '''
    get the values of window functions at time t.
    '''
    n = np.loadtxt(pop_file)[:,1:]
    a0 = gamma - abs(n - 0)
    a1 = gamma - abs(n - 1)
    W_n_0 = np.where(a0 >= 0, 1, 0)
    W_n_1 = np.where(a1 >= 0, 1, 0)
    if n.shape[1] != n_state :
        raise IOError('Please check '+pop_file+' where is not '+str(n_state)+' states.')
    np.savetxt('W_t_t_n_0.dat', W_n_0, fmt='%8.4f  '*W_n_0.shape[1])
    np.savetxt('W_t_t_n_1.dat', W_n_1, fmt='%8.4f  '*W_n_1.shape[1])
    return W_n_0, W_n_1

def calc_pop_t_t_part(n_state, W_t_t_n_0, W_t_t_n_1) :
    '''
    calculate pop_t_t_part
    # pop_t_0_part: W_i(n_i(0), 1) * mul( w_l(n_l(0), 0) ) [l != i]
    # pop_t_t_part: W_k(n_k(t), 1) * mul( w_l(n_l(t), 0) ) [l != k]
    # pop[k] = pop_t_0_part * pop_t_t_part
    '''
    pop = np.zeros(W_t_t_n_0.shape)
    n_time = W_t_t_n_0.shape[0]
    for i_time in range(n_time):
        for k in range(n_state):
            pop[i_time,k] = W_t_t_n_1[i_time,k]
            for l in range(n_state):
                if l == k :
                    continue
                pop[i_time,k] = pop[i_time,k] * W_t_t_n_0[i_time,l]
    return pop # pop_t_t_part

def get_pop(n_state, 
            gamma, 
            pop_file='pop_dia.dat'
            ):
    '''
    get population of each state.
    '''
    fnm_pop = 'pop.dat'

    W_t_t_n_0, W_t_t_n_1 = get_W_t(n_state,
                                   gamma,
                                   pop_file = pop_file)

    pop_t_t_part = calc_pop_t_t_part(n_state, W_t_t_n_0, W_t_t_n_1)
    pop = pop_t_t_part
    np.savetxt(fnm_pop, pop, fmt='%10.8f  '*pop.shape[1])


if __name__ == '__main__':
    n_state = input('n_state:\n')
    #n_state = 2
    gamma = input('gamma:\n')
    #gamma = 0.5
    get_pop(n_state,
            gamma,
            pop_file='pop_dia.dat')
