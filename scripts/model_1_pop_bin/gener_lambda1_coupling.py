
n_site = 2
n_mode = 200

vij = 0
for i in range(n_site-1):
    j = i + 1
    print i+1, j+1
    print vij
    for i_mode in range(1, n_mode):
        print 0
    print j+1, i+1
    print vij
    for i_mode in range(1, n_mode):
        print 0
