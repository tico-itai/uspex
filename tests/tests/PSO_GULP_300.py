#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
USPEX 9.4.4 release
2015 Oganov's Lab. All rights reserved.
"""

# -------------------------------------------------------------------------------
# Variables:

example_name = 'PSO_GULP_300'
columns2check = ['id', 'origin', 'composition', 'enthalpy', 'volume', 'kpoints', 'symm']

empty_dirs = []

files_list = [
    'AntiSeeds',
    'ANTISEEDS.mat',
    'CalcFold1',
    'CalcFold1/ginput_1',
    'CalcFold1/ginput_2',
    'CalcFold1/ginput_3',
    'CalcFold1/goptions_1',
    'CalcFold1/goptions_2',
    'CalcFold1/goptions_3',
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
    'Current_POP.mat',
    'Current_POP.mat.backup',
    'INPUT.txt',
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
    'results1/generation1/POP_STRUC.mat',
    'results1/generation1/POP_STRUC.mat.backup',
    'results1/generation1/PSO.mat',
    'results1/generation1/PSO.mat.backup',
    'results1/generation2',
    'results1/generation2/ORG_STRUC.mat',
    'results1/generation2/ORG_STRUC.mat.backup',
    'results1/generation2/POP_STRUC.mat',
    'results1/generation2/POP_STRUC.mat.backup',
    'results1/generation2/PSO.mat',
    'results1/generation2/PSO.mat.backup',
    'results1/generation3',
    'results1/goodStructures',
    'results1/goodStructures_POSCARS',
    'results1/Individuals',
    'results1/gatheredPOSCARS_unrelaxed',
    'results1/origin',
    'results1/OUTPUT.txt',
    'results1/Parameters.txt',
    'results1/Properties',
    'results1/PSO.mat',
    'results1/PSO.mat.backup',
    'results1/symmetrized_structures.cif',
    'Seeds',
    'Specific',
    'Specific/ginput_1',
    'Specific/ginput_2',
    'Specific/ginput_3',
    'Specific/goptions_1',
    'Specific/goptions_2',
    'Specific/goptions_3',
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
