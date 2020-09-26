#!/usr/bin/env python
from __future__ import print_function
import os
import sys
import numpy as np


def calAveragedCoherentLength(fnm='coherent_length.dat'):
    coherent_length = np.loadtxt(fnm)
    n_site = coherent_length.shape[1]
    tmp = np.reshape(np.arange(n_site+1, 1, -1),(1,-1))
    averaged_coherent_length = np.sum(coherent_length/tmp, axis=1)
    np.savetxt('averaged_coherent_length.dat', averaged_coherent_length)
    

        
if __name__ == '__main__':
    calAveragedCoherentLength()

