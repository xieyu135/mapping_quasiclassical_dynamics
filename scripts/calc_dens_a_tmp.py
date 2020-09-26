
import numpy as np

def pop(x,p):
    return 0.5*(x**2+p**2-0.66666666)

def cor(x1,p1,x2,p2):
    return 0.5*(x1*x2 + p1*p2)
    
def cal_dens(x1,p1,x2,p2):
    dens= np.zeros((2,2))
    dens[0,0] = pop(x1,p1)
    dens[1,1] = pop(x2,p2)
    dens[0,1] = cor(x1,p1,x2,p2)
    dens[1,0] = dens[0,1]
    return dens


