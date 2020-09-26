
import numpy as np

n_state = input('n_state:\n')
n_mode = input('n_mode:\n')

vmat = np.loadtxt('vmat.data')

#print vmat
f_lambda0 = open('lambda0_coupling.input', 'w')

for i in range(n_state-1):
    j = i + 1
    print >> f_lambda0, i+1, j+1
    print >> f_lambda0, vmat[i, j]
    for i_mode in range(1, n_mode):
        print >> f_lambda0, 0
    print >> f_lambda0, j+1, i+1
    print >> f_lambda0, vmat[j, i]
    for i_mode in range(1, n_mode):
        print >> f_lambda0, 0

f_lambda0.close()

f_ene = open('ene.input', 'w')

for i in range(n_state):
    print >> f_ene, vmat[i, i]

f_ene.close()
