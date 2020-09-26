#!/usr/bin/env python
import numpy as np
# coding
def win_coherence_func_arr(n):
    thresh = 1. - 1./3.
    n_state = n.shape[0]
    W_arr = np.zeros((n_state,n_state))
    for i in range(n_state-1):
        for j in range(i+1,n_state):
            #W_arr[i,j] = win_coherence_func(n[i],n[j]) \
            #             * win0_product(i,j,n) \
            #             * win0_product(j,i,n)
            if win_coherence_func(n[i],n[j]) == 1 \
            and win0_product(i,j,n) == 1 \
            and win0_product(j,i,n) == 1:
                W_arr[i,j] = 1
                W_arr[j,i] = 1 
    return W_arr

def win0(n1,n2):
    if n2 < 2. - 2./3. - n1:
        val = 1
    else:
        val = 0
    return val

def win0_product(k, # index of a state
    l, # index of a state 
    n): # action array
    n_state = n.shape[0]
    product = 1
    for i in range(n_state):
        if i != k and i != l:
            #product = product * win0(n[k], n[i])
            if win0(n[k], n[i]) == 0:
                product = 0
                break
    return product

def win_coherence_func(n1, n2):
    if n1==n2:
        val = 1
    elif (n1 >= 1./6. and n1 <= 7./6. 
    and n2 >= 1./6. and n2 <= 7./6.
    and n1 + n2 < 4./3.):
        val = 1
    else:
        val = 0
    return val

class TrjElec(object):
    def __init__(self, fnm='trj_elec.dat', n_state=101, ggamma=1./3.):
        self.fnm = fnm
        self.n_state = n_state
        self.ggamma = ggamma
        self.run()
    def get_x_p_elec_t(self):
        n_state = self.n_state
        mmat = np.loadtxt(self.fnm)
        x_elec_t = mmat[:,1].reshape(-1, n_state)
        p_elec_t = mmat[:,2].reshape(-1, n_state)
        self.x_elec_t = x_elec_t
        self.p_elec_t = p_elec_t
        self.n_time = x_elec_t.shape[0]
        return x_elec_t, p_elec_t
    def cal_dens_elec_real(self):
        n_time = self.n_time
        n_state = self.n_state
        x_elec_t = self.x_elec_t
        p_elec_t = self.p_elec_t
        dens_elec = np.ones((n_time, n_state, n_state))
        mat_I = np.diag(np.ones((n_state,)))
        mat_gamma = mat_I * self.ggamma
        for i_time in range(n_time):
            mat_x = x_elec_t[i_time].reshape(-1, 1)
            mat_x = np.dot(mat_x, mat_x.T)
            mat_p = p_elec_t[i_time].reshape(-1, 1)
            mat_p = np.dot(mat_p, mat_p.T)
            dens_elec[i_time] = 0.5 * (mat_x + mat_p)
        self.dens_elec_real = dens_elec
        #print(dens_elec[0,0,:])
        
    def cal_dens_elec_img(self):
        n_time = self.n_time
        n_state = self.n_state
        x_elec_t = self.x_elec_t
        p_elec_t = self.p_elec_t
        dens_elec_img = np.zeros((n_time, n_state, n_state))
        for i_time in range(n_time):
            mat_x = x_elec_t[i_time].reshape(-1, 1)
            mat_p = p_elec_t[i_time].reshape(-1, 1)
            mat_x_p = np.dot(mat_x, mat_p.T)
            mat_p_x = mat_x_p.T
            dens_elec_img[i_time] = 0.5 * (mat_x_p - mat_p_x)
        self.dens_elec_img = dens_elec_img
        #print(dens_elec_img[0,0,:])        
        
    def run(self):
        self.get_x_p_elec_t()
        self.cal_dens_elec_real()
        self.cal_dens_elec_img()

class window_pop_in():
    def __init__(self, 
                fnm_pop='pop_dia.dat', 
                fnm_trj_elec='trj_elec.dat',
                n_state=2, 
                ggamma=1.0/3.0, 
                n_time=0):
        self.fnm_pop = fnm_pop
        self.fnm_trj_elec = fnm_trj_elec
        self.n_state = n_state
        self.ggamma = ggamma
        self.n_time = n_time

    def get_coherence_t(self, flag_debug = False):
        n_state = self.n_state
        n = np.loadtxt(self.fnm_pop)[:,1:]
        if not self.n_time:
            self.n_time = n.shape[0]
        coherence_t = np.zeros((self.n_time, n_state, n_state))
        for it in range(self.n_time):
            coherence_t[it] = win_coherence_func_arr(n[it])
        if flag_debug:
            fnm = 'coherence_'+str(i+1)+'_'+str(j+1)+'.dat'
            np.savetxt(fnm, coherence, fmt = '%8.4f')
        return coherence_t
    def get_coherence_real_img_t(self):
        te = TrjElec(fnm=self.fnm_trj_elec, n_state=self.n_state)
        te.run()
        coherence_t = self.get_coherence_t()
        tmp = (te.dens_elec_real**2 + te.dens_elec_img**2)**0.5
        #print(tmp[0,0,:])
        #print(coherence_t[0,0,:])
        tmp = coherence_t / tmp
        dens_elec_real = te.dens_elec_real * tmp
        dens_elec_img = te.dens_elec_img * tmp
        return dens_elec_real, dens_elec_img

def main3():
    n = np.loadtxt('pop_dia.dat')[:,1:]
    W_arr = win_coherence_func_arr(n[1])
    print(W_arr[0,:])
    
def main2():
    win_tri = window_pop_in(fnm_pop='pop_dia.dat', 
            fnm_trj_elec='trj_elec.dat',
            n_state=101)
    coherence_t = win_tri.get_coherence_t()
    print(coherence_t[0,0,:])

def main():
    n_state = input('n_state:\n')
    #n_state = 2
    #ggamma = input('ggamma:\n')
    #ggamma = 0.5
    win_tri = window_pop_in(fnm_pop='pop_dia.dat', 
            fnm_trj_elec='trj_elec.dat',
            n_state=n_state)
    dens_elec_real, dens_elec_img = \
        win_tri.get_coherence_real_img_t()
    np.savetxt('dens_elec_real.dat', dens_elec_real[1])
    np.savetxt('dens_elec_img.dat', dens_elec_img[1])
    
if __name__ == '__main__':
    main()