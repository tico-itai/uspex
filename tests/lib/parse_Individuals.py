#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
USPEX 9.4.4 release
2015 Oganov's Lab. All rights reserved.
"""


# -------------------------------------------------------------------------------
# Function to parse Individuals file:
def get_individuals_content(infile, processing='USPEX'):
    f = open(infile, 'rb')
    content = f.readlines()
    f.close()

    gen_list = []
    id_list = []
    origin_list = []
    composition_list = []
    enthalpy_list = []
    volume_list = []
    density_list = []
    fitness_list = []
    kpoints_list = []
    symm_list = []
    q_entropy_list = []
    a_order_list = []
    s_order_list = []

    if processing == 'USPEX' or processing == 'PROTEIN':
        start_line = 2
    elif processing == 'META':
        start_line = 1

    for i in xrange(start_line, len(content)):
        a = content[i]

        gen = 0
        id = 0
        origin = ''
        composition = ''
        enthalpy = 0
        volume = 0
        density = 0
        fitness = 0
        kpoints = ''
        symm = 0
        q_entropy = 0
        a_order = 0
        s_order = 0

        a1 = a.split('[')[0].split()

        if processing == 'USPEX':

            a2 = a.split('[')[1].split(']')[0].split()
            a3 = a.split(']')[1].split('[')[0].split()
            a4 = a.split('[')[2].split(']')[0].split()
            a5 = a.split(']')[2].split()

            gen = int(a1[0])
            id = int(a1[1])
            origin = str(a1[2])
            composition = ' '.join(a2)
            enthalpy = float(a3[0])
            volume = float(a3[1])
            density = float(a3[2])
            fitness = float(a3[3])
            kpoints = ' '.join(a4)
            symm = int(a5[0])
            q_entropy = float(a5[1])
            a_order = float(a5[2])
            s_order = float(a5[3])
        elif processing == 'META':

            a2 = a.split('[')[1].split(']')[0].split()
            a3 = a.split(']')[1].split('[')[0].split()
            a4 = a.split('[')[2].split(']')[0].split()
            a5 = a.split(']')[2].split()

            gen = int(a1[0])
            id = int(a1[1])
            composition = ' '.join(a2)
            enthalpy = float(a3[0])
            volume = float(a3[1])
            kpoints = ' '.join(a4)
            symm = int(a5[0])
        elif processing == 'PROTEIN':

            a2 = a.split('[')[1].split(']')[0].split()
            a3 = a.split(']')[1].split('[')[0].split()

            gen = int(a1[0])
            id = int(a1[1])
            origin = str(a1[2])
            composition = ' '.join(a2)
            enthalpy = float(a3[0])

        gen_list.append(gen)
        id_list.append(id)
        origin_list.append(origin)
        composition_list.append(composition)
        enthalpy_list.append(enthalpy)
        volume_list.append(volume)
        density_list.append(density)
        fitness_list.append(fitness)
        kpoints_list.append(kpoints)
        symm_list.append(symm)
        q_entropy_list.append(q_entropy)
        a_order_list.append(a_order)
        s_order_list.append(s_order)

    # Header (new format):
    # Gen   ID    Origin   Composition    Enthalpy   Volume  Density   Fitness   KPOINTS  SYMM  Q_entr A_order S_order
    #                                       (eV)     (A^3)  (g/cm^3)

    individuals_dict = {
        'gen': {'header': 'Gen', 'values': gen_list, 'format': '%5i'},  # INT
        'id': {'header': 'ID', 'values': id_list, 'format': '%6i'},  # INT
        'origin': {'header': 'Origin', 'values': origin_list, 'format': '%-15s'},  # STR
        'composition': {'header': 'Composition', 'values': composition_list, 'format': '%12s'},  # STR
        'enthalpy': {'header': 'Enthalpy', 'values': enthalpy_list, 'format': '%15.3f'},  # FLOAT
        'volume': {'header': 'Volume', 'values': volume_list, 'format': '%15.3f'},  # FLOAT
        'density': {'header': 'Density', 'values': density_list, 'format': '%15.3f'},  # FLOAT
        'fitness': {'header': 'Fitness', 'values': fitness_list, 'format': '%15.3f'},  # FLOAT
        'kpoints': {'header': 'KPOINTS', 'values': kpoints_list, 'format': '%10s'},  # STR
        'symm': {'header': 'SYMM', 'values': symm_list, 'format': '%5i'},  # INT
        'q_entropy': {'header': 'Q_entropy', 'values': q_entropy_list, 'format': '%9.3f'},  # FLOAT
        'a_order': {'header': 'A_order', 'values': a_order_list, 'format': '%9.3f'},  # FLOAT
        's_order': {'header': 'S_order', 'values': s_order_list, 'format': '%9.3f'},  # FLOAT
    }

    # Header for META:
    # Gen   ID   Composition  Enthalpy(eV/atom)  Volume(A^3/atom)  KPOINTS  SYMMETRY

    if processing == 'META':
        individuals_dict = {
            'id': {'header': 'ID', 'values': id_list, 'format': '%6i'},  # INT
            'composition': {'header': 'Composition', 'values': composition_list, 'format': '%12s'},  # STR
            'enthalpy': {'header': 'Enthalpy', 'values': enthalpy_list, 'format': '%15.3f'},  # FLOAT
            'volume': {'header': 'Volume', 'values': volume_list, 'format': '%15.3f'},  # FLOAT
            'kpoints': {'header': 'KPOINTS', 'values': kpoints_list, 'format': '%10s'},  # STR
            'symm': {'header': 'SYMM', 'values': symm_list, 'format': '%5i'},  # INT
        }

    if processing == 'PROTEIN':
        individuals_dict = {
            'id': {'header': 'ID', 'values': id_list, 'format': '%6i'},  # INT
            'origin': {'header': 'Origin', 'values': origin_list, 'format': '%-15s'},  # STR
            'composition': {'header': 'Composition', 'values': composition_list, 'format': '%12s'},  # STR
            'enthalpy': {'header': 'Enthalpy', 'values': enthalpy_list, 'format': '%15.3f'},  # FLOAT
        }

    return individuals_dict

# -------------------------------------------------------------------------------
