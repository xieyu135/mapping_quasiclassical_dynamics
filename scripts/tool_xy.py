#!/usr/bin/python
###########################################################################
import os
#import sys
import errno
#import re
#import shutil
import numpy as np
#sys.path.append('./ppy_src')
#print sys.path




def mkdir_p(path):
    try:
        os.makedirs(path)
    except OSError as exc: # Python >2.5 (except OSError, exc: for Python <2.5)
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else: raise

def mat_orth(mmat):
    mmat_T_Conj = mmat.T.conjugate()
    mat_A = np.dot(mmat_T_Conj, mmat)
    eig, mat_U = np.linalg.eig(mat_A)
    eig_m_sqrt = eig**(-0.5)
    mat_eig_m_sqrt = np.diag(eig_m_sqrt)
    mat_U_T_Conj = mat_U.T.conjugate()
    mat_A_m_sqrt = np.dot(mat_U, mat_eig_m_sqrt)
    mat_A_m_sqrt = np.dot(mat_A_m_sqrt, mat_U_T_Conj)
    mmat = np.dot(mmat, mat_A_m_sqrt)
    return mmat

def reduce_mat(mat, cols):
    n_re = len(cols)
    mat_r = np.ones((n_re,n_re))
#    print(mat_r)
    for i in range(n_re):
        for j in range(n_re):
            mat_r[i,j] = mat[cols[i], cols[j]]
    return mat_r



        
if __name__ == "__main__":
    print('Hi')

    


