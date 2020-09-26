
import numpy as np
import math

def calc_coeff(freq_c, w_kdw_sq):
    m, n = w_kdw_sq.shape
    for i in range(m):
        #print "freq_c, freq"
        #print freq_c, w_kdw_sq[i,0]
        if freq_c <= w_kdw_sq[i,0]:
            n_cut = i
            break
    #print n_cut
    sum_kdw_sq = sum(w_kdw_sq[n_cut:,1])
    #print "sum_kdw_sq", sum_kdw_sq
    coeff = math.e**(-0.25 * sum_kdw_sq*2)
    #print "coeff", coeff
    return coeff

def iter_calc_freq_cut(V_12, p, delt_freq, w_kdw_sq):
    '''
    wc = p * V_12
    c_0 = exp(-0.25 * sum_i( -0.25 * (k/w)**2) ) # sum over freq > wc
    iteration: V_12_1 = c_0 * V_12
               wc_1 = p * V_12_1
               c_1 = exp(-0.25 * sum_i( -0.25 * (k/w)**2) ) # sum over freq > wc_1
    until wc_(n) - wc_(n-1) < delt_w (0.003 eV) 
    '''
    freq_c = p * V_12
    freq_c_pre = 10
    while( (freq_c_pre - freq_c) > delt_freq ):
        c = calc_coeff(freq_c, w_kdw_sq)
        #print c
        freq_c_pre = freq_c
        freq_c = p * V_12 * c
        print "freq_c_pre  freq_c"
        print freq_c_pre, freq_c
        print "freq_c_pre - freq_c:", freq_c_pre - freq_c
        print "delt_freq:", delt_freq
    return freq_c, c * V_12

if __name__ == '__main__':
    p = input('p:\n')
    V_12 = input('V12:\n') #0.0124
    delt_freq = input('delt_freq\n') #0.001
    file_w_k = raw_input('file_freq_kappa\n') #'wc_1000/kdw_0.7/w_k_out.dat'
    
    w_k = np.loadtxt(file_w_k)
    #print w_k.shape
    w_kdw_sq = np.zeros(w_k.shape)
    w_kdw_sq[:,0] = w_k[:,0]
    w_kdw_sq[:,1] = (w_k[:,1]/w_k[:,0])**2

    freq_c, V_12_new = iter_calc_freq_cut(V_12, p, delt_freq, w_kdw_sq)
    print freq_c, V_12_new




