
n_state = input('n_state:\n')
n_mode = input('n_mode:\n')

f_lambda1 = open('lambda1_coupling.input', 'w')

vij = 0
for i in range(n_state-1):
    j = i + 1
    print >> f_lambda1, i+1, j+1
    print >> f_lambda1, vij
    for i_mode in range(1, n_mode):
        print >> f_lambda1, 0
    print >> f_lambda1, j+1, i+1
    print >> f_lambda1, vij
    for i_mode in range(1, n_mode):
        print >> f_lambda1, 0
f_lambda1.close()
