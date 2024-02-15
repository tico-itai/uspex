#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
USPEX 9.4.4 release
2015 Oganov's Lab. All rights reserved.
"""


def parse_OUTPUT(processing='USPEX'):
    def extract(array, indices):
        new_array = []
        for i in indices:
            new_array.append(array[i])
        return new_array

    f = open('OUTPUT.txt', 'rb')
    lines = f.readlines()
    f.close()

    list1 = []

    if processing == 'PROTEIN1':
        for lin in lines:
            if lin.find("N/A") >= 0:
                splitted = lin.split()
                list1.append(splitted)
    else:
        for lin in lines:
            if lin.find("[") > 0:
                start = "["
                end = "]"
                STP = lin.find(start)
                ENP = lin.find(end)
                COMP = lin[STP:ENP + 1]
                NOC = len(COMP.split()) - 2
                splitted = lin.split()
                list1.append(splitted)

    id_list = []
    op_list = []
    composition = []
    enthalpy = []
    volume = []
    K_point = []
    symmetry = []

    for i in range(len(list1)):
        if len(list1[i]) == len(list1[2]):
            id_list.append(int(list1[i][0]))
            if processing == 'USPEX':
                op_list.append(list1[i][1])
                composition.append(' '.join(list1[i][3:3 + NOC + 1]).replace(']', '').strip())
                enthalpy.append(float(list1[i][NOC + 4]))
                volume.append(float(list1[i][NOC + 5]))
                K_point.append(' '.join(list1[i][NOC + 7:NOC + 10]).replace(']', '').strip())
                symmetry.append(int(list1[i][NOC + 10]))
            elif processing == 'META':
                composition.append(' '.join(list1[i][2:2 + NOC]))
                enthalpy.append(float(list1[i][NOC + 3]))
                volume.append(float(list1[i][NOC + 4]))
                K_point.append(' '.join(list1[i][NOC + 6:NOC + 9]).replace(']', '').strip())
                symmetry.append(int(list1[i][NOC + 9]))
            elif processing == 'PROTEIN':
                op_list.append(list1[i][1])
                composition.append(' '.join(list1[i][3:3 + NOC + 1]).replace(']', '').strip())
                enthalpy.append(float(list1[i][NOC + 4]))

    return_dict = {}
    if processing == 'USPEX':
        return_dict = {
            'id': id_list,
            'origin': op_list,
            'composition': composition,
            'enthalpy': enthalpy,
            'volume': volume,
            'kpoints': K_point,
            'symm': symmetry,
        }

    elif processing == 'META':
        uniq_id_list = []
        indices = []
        for i, id in enumerate(id_list):
            if id not in uniq_id_list:
                uniq_id_list.append(id)
            else:
                indices.append(i)

        id_list = extract(id_list, indices)
        composition = extract(composition, indices)
        enthalpy = extract(enthalpy, indices)
        volume = extract(volume, indices)
        K_point = extract(K_point, indices)
        symmetry = extract(symmetry, indices)

        return_dict = {
            'id': id_list,
            'composition': composition,
            'enthalpy': enthalpy,
            'volume': volume,
            'kpoints': K_point,
            'symm': symmetry,
        }

    elif processing == 'PROTEIN':
        return_dict = {
            'id': id_list,
            'origin': op_list,
            'composition': composition,
            'enthalpy': enthalpy,
        }

    return return_dict
