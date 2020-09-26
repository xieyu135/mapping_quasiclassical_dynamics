#!/usr/bin/env python
from __future__ import print_function
import os
import sys
import numpy as np
from window_triangle_coherence_pop_in_rescale import window_pop_in


class BatGetCoherenceT():
    def __init__(self, fnm_pop='pop_t.dat',
        n_state=2, n_traj=2, n_time=2):
        self.fnm_pop = fnm_pop
        self.n_state = n_state
        self.n_traj = n_traj
        self.n_time = n_time
        
    def getAbsCoherence(self):
        self.dens_elec_real_t, self.dens_elec_img_t = \
            self.batGetCoherenceT()
        abs_coherence_t = (self.dens_elec_real_t**2 + self.dens_elec_img_t**2)**0.5
        return abs_coherence_t

    def batGetCoherenceT(self):
        sum_pop_win = np.zeros((self.n_time, 1, 1))
        sum_coherence_real_t = np.zeros((self.n_time, self.n_state, self.n_state))
        sum_coherence_img_t = np.zeros((self.n_time, self.n_state, self.n_state))
        for i in range(1, self.n_traj+1):
            fnm_pop = 'trajs/'+str(i)+'/pop_dia.dat'
            fnm_trj_elec= 'trajs/'+str(i)+'/trj_elec.dat'
            fnm_pop_win = os.path.join('trajs', str(i), 'pop.dat')
            if os.path.exists(fnm_pop_win):
                pop_win = np.loadtxt(fnm_pop_win)
                pop_win = np.sum(pop_win, axis=1).reshape((self.n_time, 1, 1))
                if pop_win.shape[0] == self.n_time:
                    coh = window_pop_in(fnm_pop=fnm_pop, 
                        fnm_trj_elec=fnm_trj_elec,
                        n_state=self.n_state,
                        n_time=self.n_time)
                    dens_elec_real, dens_elec_img = coh.get_coherence_real_img_t()
                    sum_coherence_real_t += dens_elec_real
                    sum_coherence_img_t += dens_elec_img
                    sum_pop_win += pop_win
                    print(sum_pop_win[0,0,0])
        tmp = 1.0/(sum_coherence_real_t**2 + sum_coherence_img_t**2)**0.5
        sum_coherence_real_t = sum_coherence_real_t / sum_pop_win
        sum_coherence_img_t = sum_coherence_img_t / sum_pop_win
        return sum_coherence_real_t, sum_coherence_img_t
        
    def saveCoherenceMat(self):
        for i in range(self.n_time):
            fnm_real = 'coherent_real_mat_{0}.dat'.format(i)
            fnm_img = 'coherent_img_mat_{0}.dat'.format(i)
            np.savetxt('coherent_real_mat.dat', self.dens_elec_real_t[i,:,:],
                fmt='%10.6f '*self.dens_elec_real_t.shape[1])
            np.savetxt('coherent_img_mat.dat', self.dens_elec_img_t[i,:,:],
                fmt='%10.6f '*self.dens_elec_img_t.shape[1])
        
    def get_coherent_length(self):
        '''
        L_k = sum_i(Psi(i).conj * Psi(i+k)), i = 0...N-1, k = 0...N-1
        '''
        coherent_length = np.zeros((self.n_time, self.n_state))
        dens_elec_abs = self.abs_coherence_t
        for it in range(self.n_time):
            for k in range(self.n_state):
                coherent_length[it,k] = np.sum(np.diag(dens_elec_abs[it],k))
        return coherent_length
        
    def saveCoherenceLength(self):
        #print(self.coherent_length.shape)
        #print(self.coherent_length)
        self.coherent_length[:,0] = 1
        np.savetxt('coherent_length.dat', self.coherent_length, fmt='%10.6f '*self.coherent_length.shape[1])
    def run(self):
        self.abs_coherence_t = self.getAbsCoherence()
        self.saveCoherenceMat()
        self.coherent_length = self.get_coherent_length()
        self.saveCoherenceLength()
        
if __name__ == '__main__':
    n_state = input('n_state:\n')
    n_tmp = input('input any number to pass:\n')
    n_traj = input('n_traj:\n')
    n_time = input('n_time:\n')
    bgc = BatGetCoherenceT(n_state=n_state,
                n_traj=n_traj, 
                n_time=n_time)
    bgc.run()

