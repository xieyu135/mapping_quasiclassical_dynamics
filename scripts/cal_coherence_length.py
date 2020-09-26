#!/home-gg/users/nscc540_WJ/program/anaconda3/bin/python3

import os
import sys
import numpy as np
import json
sys.path.append(os.path.split(os.path.realpath(__file__))[0])
import complete_check

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
    def cal_dens_elec(self):
        n_time = self.n_time
        n_state = self.n_state
        x_elec_t = self.x_elec_t
        p_elec_t = self.p_elec_t
        dens_elec = np.zeros((n_time, n_state, n_state))
        mat_I = np.diag(np.ones((n_state,)))
        mat_gamma = mat_I * self.ggamma
        for i_time in range(n_time):
            mat_x = x_elec_t[i_time].reshape(-1, 1)
            mat_x = mat_x.dot(mat_x.T)
            mat_p = p_elec_t[i_time].reshape(-1, 1)
            mat_p = mat_p.dot(mat_p.T)
            dens_elec[i_time] = 0.5 * (mat_x + mat_p) - mat_gamma
        self.dens_elec = dens_elec
        
    def cal_dens_elec_img(self):
        n_time = self.n_time
        n_state = self.n_state
        x_elec_t = self.x_elec_t
        p_elec_t = self.p_elec_t
        dens_elec_img = np.zeros((n_time, n_state, n_state))
        for i_time in range(n_time):
            mat_x = x_elec_t[i_time].reshape(-1, 1)
            mat_p = p_elec_t[i_time].reshape(-1, 1)
            mat_x_p = mat_x.dot(mat_p.T)
            mat_p_x = mat_x_p.T
            dens_elec_img[i_time] = 0.5 * (mat_x_p - mat_p_x)
        self.dens_elec_img = dens_elec_img   
        
    def run(self):
        self.get_x_p_elec_t()
        self.cal_dens_elec()
        self.cal_dens_elec_img()

class TrajsAverDensElec(object):
    def __init__(self, fnm='trj_elec.dat', 
                 n_state=101, 
                 ggamma=1./3., 
                 n_trajs = 10000,
                 n_steps = 12000):
        self.fnm = fnm
        self.n_state = n_state
        self.ggamma = ggamma
        self.n_trajs = n_trajs
        self.n_steps = n_steps
        self.list_complete = self.get_list_complete()
        self.n_complete = len(self.list_complete)
        self.n_time = self.get_n_time()
        self.dens_elec = self.get_trajs_aver_dens_elec()
        self.coherent_length = self.get_coherent_length()
    def get_list_complete(self):
        t = complete_check.trajs_complete_check(self.n_steps, 
                                                self.n_trajs,
                                                fnm=self.fnm)
        t.bat_check()
        return t.list_complete
    def get_n_time(self):
        fnm = os.path.join("trajs", str(self.list_complete[0]), self.fnm)
        t = TrjElec(fnm=fnm,
            n_state=self.n_state,
            ggamma=self.ggamma)
        self.n_time = t.n_time
        return self.n_time
    def get_trajs_aver_dens_elec(self):
        dens_elec = np.zeros((self.n_time, self.n_state, self.n_state))
        for i in self.list_complete:
            fnm = os.path.join("trajs", str(i), self.fnm)
            t = TrjElec(fnm=fnm,
                        n_state=self.n_state,
                        ggamma=self.ggamma)
            dens_elec = dens_elec + t.dens_elec
        return dens_elec / float(self.n_complete)
    def get_coherent_length(self):
        '''
        L_k = sum_i(Psi(i).conj * Psi(i+k)), i = 0...N-1, k = 0...N-1
        '''
        coherent_length = np.zeros((self.n_time, self.n_state))
        dens_elec_abs = abs(self.dens_elec)
        for it in range(self.n_time):
            for k in range(self.n_state):
                coherent_length[it,k] = np.sum(np.diag(dens_elec_abs[it],k))
        return coherent_length

def run():
    t = TrajsAverDensElec(fnm='trj_elec.dat', 
                 n_state=101, 
                 ggamma=1./3., 
                 n_trajs = 10000,
                 n_steps = 12000)
    #t.run()
    #x_elec_t, p_elec_t = t.get_x_p_elec_t()
    #print(x_elec_t[0,])
    print(t.dens_elec[0])
    np.savetxt('coherent_length.dat', t.coherent_length, 
               fmt='%14.7f '* t.coherent_length.shape[1])
    np.savetxt('dens_elec_t0.dat', t.dens_elec[0], 
               fmt='%14.7f '* t.dens_elec[0].shape[1])
    np.savetxt('dens_elec_t0_diag.dat', np.diag(t.dens_elec[0],0),fmt='%14.7f')
    print(np.sum(np.diag(t.dens_elec[0],0)))
    json_data = json.dumps({'n_state':t.n_state,
                           'ggamma':t.ggamma,
                           'n_trajs':t.n_trajs,
                           'n_steps':t.n_steps,
                           'n_time':t.n_time,
                           })
    with open('param.json', 'w') as f:
        json.dump(json_data, f)
    

if __name__ == '__main__':
    run()
