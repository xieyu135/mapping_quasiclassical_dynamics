
f = open('gener_input_files_input', 'r')
f.readline()
f.readline()
n_state = int(f.readline().split()[0])
n_mode = int(f.readline().split()[0])

vij = 0.0
for i in range(n_state-1):
    j = i + 1
    print i+1, j+1
    print vij
    for i_mode in range(1, n_mode):
        print 0
    print j+1, i+1
    print vij
    for i_mode in range(1, n_mode):
        print 0
