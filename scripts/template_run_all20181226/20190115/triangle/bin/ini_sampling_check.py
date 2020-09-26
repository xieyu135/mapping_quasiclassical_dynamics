
import numpy as np
import matplotlib.pyplot as plt

def get_pop(fnm='trj_elec.input', ggamma=1./3.):
    trj = np.loadtxt(fnm)
    pop = np.sum(trj**2, axis=1)
    pop = 0.5*pop - ggamma
    return pop

def gather_all_pop(n_trajs):
    pop_all = []
    for i in range(1, n_trajs+1):
        #fnm = "trajs/"+str(i)+"/trj_elec.input"
        fnm = "trajs/"+str(i)+"/trj_elec_dia.input"
        pop = get_pop(fnm=fnm)
        pop_all.append(pop)
    pop_all = np.array(pop_all)
    return pop_all

def plot_pop_scatter(pop_all):
    n1 = pop_all[:,0]
    n2 = pop_all[:,1]
    plt.scatter(n1, n2)
    plt.show()

if __name__ == '__main__':
    pop_all = gather_all_pop(1000)
#    print(pop_all)
    plot_pop_scatter(pop_all)
