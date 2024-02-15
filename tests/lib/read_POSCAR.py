#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
USPEX 9.4.4 release
2015 Oganov's Lab. All rights reserved.
"""


# -------------------------------------------------------------------------------
def read_POSCAR(gathered_file, id, format='POSCARS'):
    EA = 'EA'
    if format == 'PDB':
        EA = 'HEADER    EA'

    POSCAR = []
    f = open(gathered_file, 'rb')
    content = f.readlines()
    f.close()

    start_list = []
    end_list = []
    id_list = []
    for i, row in enumerate(content):
        if row.find('EA') >= 0:
            start_list.append(i)
            this_id = int(row.replace(EA, '').split()[0])
            id_list.append(this_id)
    for i in range(len(start_list) - 1):
        end_list.append(start_list[i + 1])
    end_list.append(len(content))

    try:
        id_pos = id_list.index(id)
        POSCAR = content[start_list[id_pos]:end_list[id_pos]]
    except ValueError:
        id_pos = -1

    return POSCAR


# -------------------------------------------------------------------------------


# -------------------------------------------------------------------------------
def count_POSCARS(gathered_file, format='POSCARS'):
    EA = 'EA'
    if format == 'PDB':
        EA = 'HEADER    EA'

    f = open(gathered_file, 'rb')
    content = f.readlines()
    f.close()

    id_list = []
    for i, row in enumerate(content):
        if row.find(EA) >= 0:
            this_id = int(row.replace(EA, '').split()[0])
            id_list.append(this_id)
    return id_list
    # -------------------------------------------------------------------------------
