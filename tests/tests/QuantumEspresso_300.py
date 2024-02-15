#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
USPEX 9.4.4 release
2015 Oganov's Lab. All rights reserved.
"""

# -------------------------------------------------------------------------------
# Variables:

example_name = 'QuantumEspresso_300'
columns2check = ['id', 'origin', 'composition', 'enthalpy', 'volume', 'kpoints', 'symm']

empty_dirs = []

files_list = [
    'AntiSeeds',
    'ANTISEEDS.mat',
    'ANTISEEDS.mat.backup',
    'CalcFold1',
    'CalcFold1/C.pbe-van_bm.upf',
    'CalcFold1/pp.save',
    'CalcFold1/pp.save/charge-density.old.dat',
    'CalcFold1/qe.in',
    'CalcFold1/qEspresso_options_1',
    'CalcFold1/qEspresso_options_2',
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
    'Specific/C.pbe-van_bm.upf',
    'Specific/qEspresso_options_1',
    'Specific/qEspresso_options_2',
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
