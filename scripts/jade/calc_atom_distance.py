#! /usr/bin/env python2
from __future__ import print_function
from __future__ import division
import os
import numpy as np

class xyz_t():
    def __init__(self, fnm='geom.xyz'):
        self.fnm = fnm
        self.n_atom = 0
        self.unit = ''
        self.n_step = 0
        self.interval = 0.
        self.xyz_t = np.zeros((12, 6, 3))
        self.atom_labels = []
        self.steps = []
        self.times = []
    def check_exist(self):
        if not os.path.exists(self.fnm):
            print('The file "'+self.fnm+'" does not exist.')
            exit()
    def get_n_atom(self):
        f = open(self.fnm, 'r')
        self.n_atom = int(f.readline().strip())
        self.unit = f.readline().split()[0]
        #print('n_atom: '+str(self.n_atom))
        f.close()
        return self.n_atom
    def get_atom_labels(self):
        self.get_n_atom()
        f = open(self.fnm, 'r')
        f.readline()
        f.readline()
        atom_labels = []
        for i in range(self.n_atom):
           atom_labels.append(f.readline().split()[0])
        self.atom_labels = atom_labels
        return atom_labels
    def load_xyz_t(self, fnm='geom.xyz'):
        f = open(self.fnm, 'r')
        lines = f.readlines()
        f.close()
        self.n_step = len(lines)//(self.n_atom + 2)
        self.interval = float(lines[self.n_atom + 3].split()[4])
        #print('time interval: '+str(self.interval))
        self.xyz_t = np.zeros((self.n_step, self.n_atom, 3))
        self.steps = []
        self.times = []
        for i_step in range(self.n_step):
            ind = i_step * (self.n_atom + 2) + 1
            list = lines[ind].split()
            self.steps.append(list[2])
            self.times.append(list[4])
            for i_atom in range(self.n_atom):
                ind = i_step * (self.n_atom + 2) + 2 + i_atom
                coord = lines[ind].split()[1:]
                for i_coord in range(3):
                    self.xyz_t[i_step, i_atom, i_coord] = float(coord[i_coord])
        #print(self.xyz_t[0,:,:])
    def get_coords_t(self):
        self.get_n_atom()
        self.load_xyz_t()
        return self.xyz_t
    def calc_distance(self, vec1, vec2):
        diff = vec2 - vec1
        return np.sum(diff**2)**0.5
    def get_atom_distance(self, geom, i_atom1, i_atom2):
        vec1 = geom[i_atom1 - 1,:]
        vec2 = geom[i_atom2 - 1,:]
        return self.calc_distance(vec1, vec2)
    def get_atom_distance_time(self, i_atom1, i_atom2):
        distance_time = np.zeros((self.n_step,))
        for i_step in range(self.n_step):
            geom = self.xyz_t[i_step, :, :]
            distance_time[i_step] = self.get_atom_distance(geom, i_atom1, i_atom2)
        time = np.arange(self.n_step) * self.interval
        mat_distance_time = np.vstack((time, distance_time))
        #print(mat_distance_time.T)
        return mat_distance_time.T

        
         
    def run(self):
        self.check_exist()
        self.get_n_atom()
        self.load_xyz_t()


if __name__ == '__main__':
    x = xyz_t()
    x.run()
    mat_distance = x.get_atom_distance_time(1,2)
    np.savetxt('dist_C_N.dat', mat_distance, fmt='%14.8f '*mat_distance.shape[1])
    
    


