#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
USPEX 9.4.4 release
2015 Oganov's Lab. All rights reserved.
"""

# -------------------------------------------------------------------------------
# Variables:

example_name = 'Lammps_300'
columns2check = ['id', 'origin', 'composition', 'enthalpy', 'volume', 'kpoints', 'symm']

empty_dirs = []

files_list = [
    'AntiSeeds',
    'ANTISEEDS.mat',
    'ANTISEEDS.mat.backup',
    'CalcFold1',
    'CalcFold1/coo',
    'CalcFold1/lammps.in',
    'CalcFold1/lammps.in_1',
    'CalcFold1/lammps.in_2',
    'CalcFold1/lammps.in_3',
    'CalcFold1/lammps.in_4',
    'CalcFold1/lammps.in_5',
    'CalcFold1/lammps.out',
    'CalcFold1/log.lammps',
    'CalcFold1/out.xyz',
    'CalcFold1/SiC.tersoff',
    'CalcFoldTemp',
    'CalcFoldTemp/.data',
    'CalcFoldTemp/.data/data_space2d.txt',
    'CalcFoldTemp/.data/data_space.txt',
    'CalcFoldTemp/.data/data_wyckoff.txt',
    'CalcFoldTemp/findsym.log',
    'CalcFoldTemp/rc.in',
    'CalcFoldTemp/rc.out',
    'CalcFoldTemp/sym.in',
    'CalcFoldTemp/symmetrized.cif',
    'CalcFoldTemp/sym.out',
    'Current_ORG.mat',
    'Current_ORG.mat.backup',
    'Current_POP.mat',
    'Current_POP.mat.backup',
    'INPUT.txt',
    'POSCAR',
    'POSCAR_order',
    'results1',
    'results1/AuxiliaryFiles',
    'results1/BESTgatheredPOSCARS',
    'results1/BESTgatheredPOSCARS_order',
    'results1/BESTIndividuals',
    'results1/Energy_vs_N.pdf',
    'results1/Energy_vs_Volume.pdf',
    'results1/enthalpies_complete.dat',
    'results1/E_series.pdf',
    'results1/Fitness_vs_N.pdf',
    'results1/gatheredPOSCARS',
    'results1/gatheredPOSCARS_order',
    'results1/generation1',
    'results1/generation1/ORG_STRUC.mat',
    'results1/generation1/ORG_STRUC.mat.backup',
    'results1/generation1/POOL.mat',
    'results1/generation1/POOL.mat.backup',
    'results1/generation1/POP_STRUC.mat',
    'results1/generation1/POP_STRUC.mat.backup',
    'results1/generation1/USPEX.mat',
    'results1/generation1/USPEX.mat.backup',
    'results1/generation2',
    'results1/generation2/ORG_STRUC.mat',
    'results1/generation2/ORG_STRUC.mat.backup',
    'results1/generation2/POOL.mat',
    'results1/generation2/POOL.mat.backup',
    'results1/generation2/POP_STRUC.mat',
    'results1/generation2/POP_STRUC.mat.backup',
    'results1/generation2/USPEX.mat',
    'results1/generation2/USPEX.mat.backup',
    'results1/generation3',
    'results1/goodStructures',
    'results1/goodStructures_POSCARS',
    'results1/Individuals',
    'results1/gatheredPOSCARS_unrelaxed',
    'results1/origin',
    'results1/OUTPUT.txt',
    'results1/Parameters.txt',
    'results1/POOL.mat',
    'results1/POOL.mat.backup',
    'results1/Properties',
    'results1/symmetrized_structures.cif',
    'results1/USPEX.mat',
    'results1/USPEX.mat.backup',
    'results1/Variation-Operators.pdf',
    'Seeds',
    'Specific',
    'Specific/lammps.in_1',
    'Specific/lammps.in_2',
    'Specific/lammps.in_3',
    'Specific/lammps.in_4',
    'Specific/lammps.in_5',
    'Specific/SiC.tersoff',
    'Submission',
    'Submission/checkStatusC.m',
    'Submission/checkStatus_local.m',
    'Submission/checkStatus_remote.m',
    'Submission/README',
    'Submission/run-uspex.sh',
    'Submission/submitJob_local.m',
    'Submission/submitJob.m',
    'Submission/submitJob_remote.m',
    'USPEX_IS_DONE',
]
# -------------------------------------------------------------------------------
