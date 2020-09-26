#!/usr/bin/env python
import numpy as np


def win_func(n, N, delt_n):
    '''
    W(n,N) = heaviside( 0.5*delt_n - abs(n - N) ) / delt_n
    The actual window width is 0.5*delt_n, generally 0.366.
    N = 0:
    W(n,N) = heaviside( 0.5*delt_n - (n - N) )
           = heaviside( 0.5*delt_n - n)
    N = 1:
    W(n,N) = heaviside( 0.5*delt_n - (N - n) )
           = heaviside( 0.5*delt_n - 1 + n )
    '''
    if N == 0 :
      x = 0.5*delt_n - n
    elif N == 1 :
      x = 0.5*delt_n - 1 + n
    else :
      print "Wrong quantum number N!\nN should be 0 or 1."
    
    if x < 0 :
        W = 0
    else :
        W = 1./delt_n
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

def get_W_0(n_state, ggamma, traj_file='trj_elec.input'):
    '''
    get the values of window functions at time 0.
    '''
    trj = np.loadtxt(traj_file)
    if n_state != trj.shape[0] :
        print 'The number of lines in '+traj_inp_file+' is not '+str(n_state)
        raise IOError
    x = trj[:,0]
    p = trj[:,1]
    n = calc_n(x, p, ggamma)
    #print n

    delt_n =  ggamma
    W_n_0 = win_func_arr(n, 0, delt_n)
    #print W_n_0
    W_n_1 = win_func_arr(n, 1, delt_n)
    #print W_n_1
    W = np.vstack((W_n_0, W_n_1))
    np.savetxt('W_t_0.dat', W, fmt='%8.4f  '*W.shape[1])
    return W_n_0, W_n_1

def get_W_t(n_state, ggamma, traj_file='trj_elec.dat'):
    '''
    get the values of window functions at time t.
    '''
    trj = np.loadtxt(traj_file)
    x = trj[:,1]
    p = trj[:,2]
    n = calc_n(x, p, ggamma)
    delt_n =  ggamma
    W_n_0 = win_func_arr(n, 0, delt_n)
    W_n_0 = np.reshape( W_n_0, (-1, n_state) )
    W_n_1 = win_func_arr(n, 1, delt_n)
    W_n_1 = np.reshape( W_n_1, (-1, n_state) )

    np.savetxt('W_t_t_n_0.dat', W_n_0, fmt='%8.4f  '*W_n_0.shape[1])
    np.savetxt('W_t_t_n_1.dat', W_n_1, fmt='%8.4f  '*W_n_1.shape[1])
    return W_n_0, W_n_1

def calc_pop_t_0_part(n_state, W_t_0_n_0, W_t_0_n_1):
    '''
    calculate pop_t_0_part
    # pop_t_0_part: W_i(n_i(0), 1) * mul( w_l(n_l(0), 0) ) [l != i]
    # pop_t_t_part: W_k(n_k(t), 1) * mul( w_l(n_l(t), 0) ) [l != k]
    # pop[k] = pop_t_0_part * pop_t_t_part
    '''
    pop_t_0_part = 0
    count = 0
    for i in range(n_state) :
        if W_t_0_n_1[i] != 0 :
            ini_state = i
            count = count + 1
    if count == 0 :
        return pop_t_0_part
    elif count > 1 :
        print '''Please check your electronic traj input!
More than 1 state occupation!'''
        raise

    # pop_t_0_part: W_i(n_i(0), 1) * mul( w_l(n_l(0), 0) ) [l != i]
    # pop_t_t_part: W_k(n_k(t), 1) * mul( w_l(n_l(t), 0) ) [l != k]
    # pop[k] = pop_t_0_part * pop_t_t_part
    pop_t_0_part = W_t_0_n_1[ini_state]
    for i in range(n_state):
        if i == ini_state :
            continue
        pop_t_0_part = pop_t_0_part * W_t_0_n_0[i]

    return pop_t_0_part

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
            traj_inp_file='trj_elec.input', 
            traj_file='trj_elec.dat'
            ):
    '''
    get population of each state.
    '''
    fnm_pop = 'pop.dat'
    W_t_0_n_0, W_t_0_n_1 = get_W_0(n_state, 
                                   ggamma, 
                                   traj_file = traj_inp_file)

    pop_t_0_part = calc_pop_t_0_part(n_state, W_t_0_n_0, W_t_0_n_1)
    if pop_t_0_part == 0 :
        f_pop = open(fnm_pop, 'w')
        f_pop.write(str(pop_t_0_part)+'\n')
        f_pop.close()
        return

    W_t_t_n_0, W_t_t_n_1 = get_W_t(n_state,
                                   ggamma,
                                   traj_file = traj_file)

    pop_t_t_part = calc_pop_t_t_part(n_state, W_t_t_n_0, W_t_t_n_1)
    pop = pop_t_t_part * pop_t_0_part
    np.savetxt(fnm_pop, pop, fmt='%10.8f  '*pop.shape[1])


if __name__ == '__main__':
    n_state = input('n_state:\n')
    #n_state = 2
    ggamma = input('ggamma:\n')
    #ggamma = 0.5
    get_pop(n_state,
            ggamma,
            traj_inp_file='trj_elec.input',
            traj_file='trj_elec.dat')
