    def periodictable(self):
        """ read in periodic table """
        fp = open("elements.dat", "r")
        line = fp.readline()
        line = fp.readline()
        n_atom = int(line.split()[0])
        self.table['number'] = n_atom
        self.table['elements'] = []
        # read in p table
        line = fp.readline()
        for i in xrange(n_atom):
            line = fp.readline()
            #atom-label; atom-std-type; atom-eng-type; charge; mass(a.u.)
            record = line.split()
            atom_label = record[0]
            atom_type  = record[1]
            atom_eng_type = record[2]
            charge = float(record[3])
            mass = float(record[4])
            element = {'atom_label': atom_label, 'atom_type': atom_type, \
                       'atom_eng_type': atom_eng_type, 'atom_number': charge, \
                       'mass': mass}
            self.table['elements'].append(element)
        return
