
import numpy as np

def get_x_p(trj_elec, n_state):
    x = trj_elec[:, 0]
    p = trj_elec[:, 1]

    x = np.reshape(x, (-1, n_state) )
    p = np.reshape(p, (-1, n_state) )
    return x, p



n_state = input('n_state:\n')

dt = input('dt:\n')

n_traj = input('n_traj:\n')

n_time = input('n_time:\n')

gamma = input('delt_n:\n')

gamma_half = gamma/2.0

pop = np.zeros((n_time, n_state))
n_traj_done = np.zeros((n_time,1))
for i in range(1, n_traj+1):
#    print i
    file_pop = 'trajs/'+str(i)+'/pop_dia.dat'
    pop_dia_i = np.delete( np.loadtxt(file_pop), 0, 1)
    if pop_dia_i.shape != (n_time, n_state) :
        print 'Traj ', i, 'is not completed!'
        continue
    pop_i = np.zeros((n_time, n_state))
    for j in range(n_time):
        for k in range(n_state):
            tmp = pop_dia_i[j,k]
            if ( tmp < 0.25 - gamma_half) or ( tmp > 0.25 + gamma_half and tmp < 0.75 - gamma_half) or (tmp > 0.75 + gamma_half):
                continue
            n_traj_done[j,0] = n_traj_done[j,0] + 1.
            if tmp >= 0.75 - gamma_half and tmp <= 0.75 + gamma_half:
                pop_i[j,k] = 1
    pop = pop + pop_i

#pop = pop / n_traj_done
sum_pop = np.sum(pop, axis=1)
for i in range(n_time):
    if sum_pop[i] == 0:
        continue
    pop[i,:] = pop[i,:] / sum_pop[i]
#np.savetxt('pop.dat', pop, fmt='%20.14f '*np.shape(pop)[1])
time = np.arange(n_time) * dt
time = np.reshape(time, (-1,1) )
pop_t = np.hstack((time, pop) )
np.savetxt('pop_t.dat', pop_t, fmt='%20.14f '*np.shape(pop_t)[1])
#file_pop_adia = 'trajs/1/pop_adia.dat'
#file_pop_dia = 'trajs/1/pop_dia.dat'
#pop_adia = np.delete( np.loadtxt(file_pop_adia), 0, 1)
#pop_dia = np.delete( np.loadtxt(file_pop_dia), 0, 1)
#for i in range(2, n_traj+1):
#    file_pop_adia = 'trajs/'+str(i)+'/pop_adia.dat'
#    file_pop_dia = 'trajs/'+str(i)+'/pop_dia.dat'
#    pop_adia = pop_adia + np.delete( np.loadtxt(file_pop_adia), 0, 1)
#    pop_dia = pop_dia + np.delete( np.loadtxt(file_pop_dia), 0, 1)
#
#pop_adia = pop_adia/float(n_traj)
#pop_dia = pop_dia/float(n_traj)

#x, p = get_x_p(trj_elec, n_state)

#print np.shape(x)
#
#n_step = np.shape(pop_dia)[0]
#
#time = np.arange(n_step)
#time = time * dt
#
#time = np.reshape(time, (-1,1) )
#
#pop_adia_t = np.hstack((time,pop_adia))
#pop_dia_t = np.hstack((time,pop_dia))
#
#np.savetxt('pop_adia_t.dat', pop_adia_t, fmt='%20.14f '*np.shape(pop_adia_t)[1])
#np.savetxt('pop_dia_t.dat', pop_dia_t, fmt='%20.14f '*np.shape(pop_dia_t)[1])
#
#print time
