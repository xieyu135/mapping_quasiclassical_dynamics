#!/usr/bin/env python
import numpy as np


def win_func(n, N, delt_n):
    '''
    triangle window
    '''
    if N == 0 :
      if n >= -1./3. and n <= 2./3. :
        W = 1
      else :
        W = 0
    elif N == 1 :
      if n > 2./3. and n <= 5./3. :
        W = 1
      else :
        W = 0
    else :
      print "Wrong quantum number N!\nN should be 0 or 1."
    return W

def win_func_arr(n_arr, N, delt_n):
    L = n_arr.shape[0]
    W_arr = np.zeros(L)
    for i in range(L) :
        W_arr[i] = win_func(n_arr[i], N, delt_n)
    return W_arr

def calc_n(x, p, ggamma):
    '''
    n = 0.5 * ( x**2 + p**2 - ggamma)
    '''
    n = 0.5 * ( x**2 + p**2 - ggamma)
    return n

def get_W_t(n_state, ggamma, traj_file='trj_elec.dat'):
    '''
    get the values of window functions at time t.
    '''
    trj = np.loadtxt(traj_file)
    x = trj[:,1]
    p = trj[:,2]
    n = calc_n(x, p, ggamma)
    n = np.reshape( n, (-1, n_state) )
    sum_n = np.sum(n, axis=1)
    n_traj = n.shape[0]
    sum_n_max = n_state * 2. / 3.
    delt_n =  ggamma
    W_n_0 = np.zeros((n_traj, n_state))
    W_n_1 = np.zeros((n_traj, n_state))
    for i in range(n_traj):
        if sum_n[i] <= sum_n_max :
            W_n_0[i,:] = win_func_arr(n[i,:], 0, delt_n)
            W_n_1[i,:] = win_func_arr(n[i,:], 1, delt_n)

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
            ggamma, 
            traj_file='trj_elec.dat'
            ):
    '''
    get population of each state.
    '''
    fnm_pop = 'pop.dat'

    W_t_t_n_0, W_t_t_n_1 = get_W_t(n_state,
                                   ggamma,
                                   traj_file = traj_file)

    pop_t_t_part = calc_pop_t_t_part(n_state, W_t_t_n_0, W_t_t_n_1)
    pop = pop_t_t_part 
    np.savetxt(fnm_pop, pop, fmt='%10.8f  '*pop.shape[1])


if __name__ == '__main__':
    n_state = input('n_state:\n')
    #n_state = 2
    ggamma = input('ggamma:\n')
    #ggamma = 0.5
    get_pop(n_state,
            ggamma,
            traj_file='trj_elec.dat')
