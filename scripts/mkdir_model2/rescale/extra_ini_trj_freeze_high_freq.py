#!/usr/bin/python
import os
import math
from os import system
from sys import exit
import numpy as np


n_traj = input('n_traj:\n')
n_mode = input('n_mode:\n')
high_freq_cutoff = input('Freeze modes with frequency > ?\n')

mat_freq = np.loadtxt('freq.input')
for i in range(n_mode):
    if mat_freq[i,0] >= high_freq_cutoff :
        n_mode_low = i
        break

n_line = int(n_traj * n_mode)

trj = []
pop1= []
pop2= []

for i_line in range(n_line):
   trj.append([])
   for i_x in range(2):
       trj[i_line].append(0.0)


line_text =[]
for i_line in range(n_line):
    line_text.append(0.0)

filein1=open('random_gau.dat','r')
line_all=filein1.read()
filein1.close()

line_text=line_all.split('\n')
for i_line in range(n_line): 
    trj[i_line][0] = float(line_text[i_line].split()[0])
    trj[i_line][1] = float(line_text[i_line].split()[1])

for i_trj in range(n_traj):
    filein2=open('traj_' + str(i_trj+1) + '.inp','w')
    for i_mode in range(n_mode):
        if mat_freq[i_mode,0] < high_freq_cutoff :
            filein2.write( str(trj[int(n_mode*i_trj + i_mode)][0]) + '   ' + str(trj[int(n_mode*i_trj + i_mode)][1]) +  '\n' )
        else :
            filein2.write( '0.0   0.0'  +  '\n' )
    filein2.close()

