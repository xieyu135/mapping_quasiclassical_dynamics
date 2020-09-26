
import numpy as np
from numpy import random as nr
import sys

def calc_mat_d2a(mat_ham):
    e, mat_d2a = np.linalg.eig(mat_ham)
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
    for i_state in range(n_state):
        action[i_state] = (2.*dens[i_state,i_state] + ggamma)**0.5
    for i_state in range(1, n_state):
        cos_differ[i_state] = 2.*dens[0,i_state]/(action[0]*action[i_state])
    angle_differ = np.arccos(cos_differ)
    angle_differ[0] = 0.
    angle[0] = nr.rand(1,)[0]*np.pi*2.
    angle = angle[0]
    angle = angle - angle_differ
    x = action * np.cos(angle)
    p = action * np.sin(angle)
    return x, p

def gener_ini_trj_elec_adia(mat_ham, dens_d, ggamma):
    mat_d2a = calc_mat_d2a(mat_ham)
    dens_a = calc_dens_a(dens_d, mat_d2a)
    x, p = gener_ini_trj_elec(dens_a, ggamma)
    return x, p

if __name__ == "__main__":    
    mat_ham = np.array([[0.0124, 0.0124],[0.0124,0.]])
    dens_d = np.array([[1.,0.],[0.,0.]])
    ggamma = 0.66666666
    x, p = gener_ini_trj_elec_adia(mat_ham, dens_d, ggamma)
    trj = np.vstack((x,p))
    trj = trj.T
    np.savetxt('trj_elec.input', trj, fmt = "%14.8f" * trj.shape[1])
    
