
import numpy as np
from numpy import random as nr
import random
import sys

def triangle_sampling(ini_n, ggamma = 1./3.):
    if np.sum(ini_n) != 1:
        raise ValueError('The sum of populations is not 1.')
    n_state = ini_n.shape[0]
    pop = np.zeros((n_state,))
    ggamma_twice = 2. * ggamma
    sum_n_max = n_state * ggamma_twice
    while True:
        for i in range(n_state):
            if ini_n[i] == 0 :
                pop[i] = nr.rand(1,)[0] - ggamma
            elif ini_n[i] == 1 :
                rr = nr.rand(1,)[0]
                if rr == 0 :
                    pop[i] = rr + ggamma_twice + 1.e-10
                else :
                    pop[i] = rr + ggamma_twice
            else :
                raise ValueError('Wrong "action" input! N = 1 or 0 and it cannot be the other values')
        ssum = np.sum(pop)
        if ssum < sum_n_max:
            break
    #print(pop)
    action = ( 2. * ( pop + ggamma ) ) **0.5
    angle = nr.rand(n_state,) * np.pi * 2.
    x = action * np.cos(angle)
    p = action * np.sin(angle)
    return x, p

def calc_mat_d2a(mat_ham):
    e, mat_d2a = np.linalg.eig(mat_ham)
    mat_d2a = -mat_d2a[:,::-1]
    return mat_d2a

def calc_dens_a(dens_d, mat_d2a):
    return mat_d2a.dot(dens_d).dot(mat_d2a.T)

def gener_ini_trj_elec(dens, ggamma):
    n_state = dens.shape[0]
    if n_state != 2 :
        print("Now the program only supports 2-state cases!")
        sys.exit()
    action = np.zeros((n_state,))
    angle = np.zeros((n_state,))
    x = np.zeros((n_state,))
    p = np.zeros((n_state,))
    cos_differ = np.zeros((n_state,))
    angle_differ = np.zeros((n_state-1,))
    #print(dens)
    for i_state in range(n_state):
        action[i_state] = (2.*dens[i_state,i_state] + ggamma)**0.5
    for i_state in range(1, n_state):
        cos_differ[i_state] = 2.*dens[0,i_state]/(action[0]*action[i_state])
        if cos_differ[i_state] < -1.0 :
            cos_differ[i_state] = -1.0
        if cos_differ[i_state] > 1.0 :
            cos_differ[i_state] = 1.0
        #print(cos_differ[i_state])
    angle_differ = np.arccos(cos_differ)
    angle_differ[0] = 0.
    angle[0] = nr.rand(1,)[0]*np.pi*2.
    angle = angle[0]
    cchoice = random.choice([1., 0.])
    angle = angle + angle_differ * (-1)**cchoice
    x = action * np.cos(angle)
    p = action * np.sin(angle)
    return x, p

def gener_ini_trj_elec_adia(mat_ham, dens_d, ggamma):
    mat_d2a = calc_mat_d2a(mat_ham)
    dens_a = calc_dens_a(dens_d, mat_d2a)
    x, p = gener_ini_trj_elec(dens_a, ggamma)
    return x, p

def vec_trans(mat_u, vec):
    return mat_u.dot(vec.reshape(-1, 1)).reshape(-1,)

def gener_ini_trj_elec_adia_direct_trans(ini_n_dia, mat_d2a):
    n_state = ini_n_dia.shape[0]
    x_dia, p_dia = triangle_sampling(ini_n_dia)
    save_x_p(x_dia, p_dia, 'trj_elec_dia.input')
    x_adia = vec_trans(mat_d2a, x_dia)
    p_adia = vec_trans(mat_d2a, p_dia)
    return x_adia, p_adia

def gener_ini_trj_elec_adia_triangle_trj_trans(mat_ham, ini_n_dia):
    mat_d2a = calc_mat_d2a(mat_ham)
    x_adia, p_adia = gener_ini_trj_elec_adia_direct_trans(ini_n_dia, mat_d2a)
    return x_adia, p_adia

def save_x_p(x, p, fnm):
    trj = np.vstack((x,p)).T
    np.savetxt(fnm, trj, fmt = "%14.8f" * trj.shape[1])

def test_triangle():
    mat_ham = np.array([[0.0124, 0.0124],[0.0124,0.]])
    ini_n_dia = np.array([1.,0.])
    x, p = gener_ini_trj_elec_adia_triangle_trj_trans(mat_ham, ini_n_dia)
    save_x_p(x, p, 'trj_elec.input')

def test():
    mat_ham = np.array([[0.0124, 0.0124],[0.0124,0.]])
    dens_d = np.array([[1.,0.],[0.,0.]])
    ggamma = 0.66666666
    x, p = gener_ini_trj_elec_adia(mat_ham, dens_d, ggamma)
    trj = np.vstack((x,p))
    trj = trj.T
    np.savetxt('trj_elec.input', trj, fmt = "%14.8f" * trj.shape[1])
    
if __name__ == "__main__":    
    test_triangle()
