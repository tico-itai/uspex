#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""
USPEX 9.4.4 release
2015 Oganov's Lab. All rights reserved.
"""

# -------------------------------------------------------------------------------
# Variables:

example_name = 'vcNEB_111'
columns2check = []

empty_dirs = []

files_list = [
    'CalcFold1',
    'CalcFold1/ginput_1',
    'CalcFold1/goptions_1',
    'CalcFold1/gulp-old.output',
    'CalcFoldTemp',
    'CalcFoldTemp/.data',
    'CalcFoldTemp/.data/data_space2d.txt',
    'CalcFoldTemp/.data/data_space.txt',
    'CalcFoldTemp/.data/data_wyckoff.txt',
    'CalcFoldTemp/findsym.log',
    'CalcFoldTemp/sym.in',
    'CalcFoldTemp/symmetrized.cif',
    'CalcFoldTemp/sym.out',
    'Current_ORG.mat',
    'Current_ORG.mat.backup',
    'Current_POP.mat',
    'Current_POP.mat.backup',
    'Images',
    'INPUT.txt',
    'results1',
    'results1/AuxiliaryFiles',
    'results1/AuxiliaryFiles/enthalpies_nospace.dat',
    'results1/AuxiliaryFiles/enthalpy_all.dat',
    'results1/AuxiliaryFiles/gatheredPOSCARS',
    'results1/AuxiliaryFiles/ImageMapping.dat',
    'results1/AuxiliaryFiles/ImageStructure.dat',
    'results1/BarrierFig',
    'results1/Energy',
    'results1/EnergyBarrier.pdf',
    'results1/EnergyBarrier.tif',
    'results1/EnergyBarrier_vs_Step.pdf',
    'results1/Force',
    'results1/ImageStructure',
    'results1/initialImages',
    'results1/OUTPUT.txt',
    'results1/Parameters.txt',
    'results1/PATH',
    'results1/PATH/path0.xsf',
    'results1/PATH/path10.xsf',
    'results1/PATH/path20.xsf',
    'results1/SelectedEnergyBarrier.pdf',
    'results1/SpaceGroup',
    'results1/STEP',
    'results1/STEP/step0',
    'results1/STEP/step0/ORG_STRUC.mat',
    'results1/STEP/step0/ORG_STRUC.mat.backup',
    'results1/STEP/step0/POP_STRUC.mat',
    'results1/STEP/step0/POP_STRUC.mat.backup',
    'results1/STEP/step10',
    'results1/STEP/step10/ORG_STRUC.mat',
    'results1/STEP/step10/ORG_STRUC.mat.backup',
    'results1/STEP/step10/POP_STRUC.mat',
    'results1/STEP/step10/POP_STRUC.mat.backup',
    'results1/STEP/step20',
    'results1/STEP/step20/ORG_STRUC.mat',
    'results1/STEP/step20/ORG_STRUC.mat.backup',
    'results1/STEP/step20/POP_STRUC.mat',
    'results1/STEP/step20/POP_STRUC.mat.backup',
    'results1/CellParameters_vs_ImageNumber.pdf',
    'results1/transitionPath_POSCARs',
    'results1/USPEX.mat',
    'results1/USPEX.mat.backup',
    'results1/VCNEBReports',
    'Specific',
    'Specific/ginput_1',
    'Specific/goptions_1',
    'Submission',
    'Submission/checkStatusC.m',
    'Submission/checkStatus_local.m',
    'Submission/checkStatus_remote.m',
    'Submission/README',
    'Submission/run-uspex_py.sh',
    'Submission/run-uspex.sh',
    'Submission/submitJob_local.m',
    'Submission/submitJob.m',
    'Submission/submitJob_remote.m',
    'VCNEB_IS_DONE',
]
# -------------------------------------------------------------------------------
