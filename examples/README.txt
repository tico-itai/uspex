******************************************************
* Here we give examples of calculations using USPEX. *
******************************************************
Please consult these examples before doing your own calculations. These are rather high-quality calculations.
If any problems, contact us.
We also recommend that when you do your own calculations, you start with one of these examples and edit input files - instead of creating them from scratch.
Before running examples, put executables of VASP, SIESTA, GULP,... (whichever codes you are using) in folders Specific as ./Specific/vasp,
./Specific/siesta, ./Specific/gulp.

To run USPEX, simply type:

    nohup matlab < USPEX.m > log &
or
    nohup USPEX -r > log &

(or analogous command line with Octave). Well, this is described in the Manual - and before doing anything, you should read the Manual!
When analyzing your examples - you can compare your results with the "standard" results that can be found in folders "reference". The "reference" folders contain only essential files, the rest being removed to save disk space.
Folders AuxiliaryFiles and generationNN are removed from reference in all examples (except example #4) to decrease the size of the examples folders.

Keep in mind that to get reliable results for physical systems you really need to do ab initio calculations, as most forcefields are not sufficiently accurate.

******************
LIST OF EXAMPLES:

EX01-3D_Si_vasp: Silicon (8 atoms/cell) at zero pressure. Variable-cell DFT calculation using VASP, PBE96 functional. Many thanks to G.Kresse for permission to include his PAW files (POTCAR) in our distribution.

EX02-3D_MgAl2O4_gulp: MgAl2O4 (28 atoms/cell) at 100 GPa pressure. Variable-cell calculation using Buckingham potentials, GULP code. This example has direct bearing on the physics of the Earth's interior.

EX03-3D-const_cell_MgSiO3_gulp: this example shows how to do structure prediction when you know cell parameters. MgSiO3 (20 atoms/cell) with Buckingham potentials, GULP code. Cell parameters correspond to post-perovskite. The discovery of post-perovskite (Oganov & Ono, Nature 2004; Murakami et al., Science 2004) was a major breakthrough in Earth sciences.

EX04-3D_C_lammps: this example shows how to do crystal structure prediction using combination of USPEX with the LAMMPS code. In this a simple example: 8 carbon atoms, and Tersoff potential.

EX05-3D_Si_atk: Example of crystal structure prediction of Si with 8 atoms/cell using the density-functional tight binding approximation and ATK code.

EX06-3D_C_castep: DFT-based prediction of the crystal structure of carbon with 8 atoms/cell at 10 GPa, using the CASTEP code.

EX07-2D_Si_vasp: prediction of the 2D-crystal of silicon using DFT and VASP. Simple and powerful.

EX08-0D_LJ_gulp: Nanoparticle structure prediction. Lennard-Jones nanoparticle with 30 atoms, relaxed using the GULP code.

EX09-3D-molecules_CH4_vasp: methane with 4 molecules/cell, at the pressure of 20 GPa. DFT, VASP. Molecule is described in the file MOL_1.

EX10-3D-molecules_CH4_dmacrys: methane with 8 molecules/cell, with forcefield and DMACRYS code, at normal pressure. Molecule is described in the file MOL_1, but note its slightly unusual format for DMACRYS calculations. Please put executable dmacrys.out(v-2.0.8), neighcrys.out in the folder Specific.

EX11-3D-molecules_urea_tinker: urea with 2 molecules/cell, with forcefield and TINKER code, at ambient pressure. Molecule is described in the file MOL_1. Note here we used a relative large toleranceFing (0.12) to intentionally remove the duplicated structures, since the force field is very soft. The trick of parallel calculation with whichcluster=0 is also used here (Qiang Zhu). 

EX12-3D_varcomp_LJ_gulp: Lennard-Jones binary system with fake "Mo" and "B" atoms, GULP, and variable-composition USPEX (Lyakhov and Oganov, 2010).

EX13-3D_special_quasirandom_structure_TiCoO: USPEX can easily find the most disordered alloy structure. Here, this is shown for the TixCo(1-x)O. You need to specify the initial structure in /Seeds/POSCARS and use only the permutation operator. In this case, you don't need to use any external codes. In this example, we optimize (minimize) the structural order (Oganov and Valle (2009); Lyakhov Oganov Valle (2010)) without relaxation (abinitioCode = 0). Seed structure (supercell of Ti-Cu-O-structure) is permutated in a search of the permutant with the minimum/maximum order. Minimizing order in this situation, one gets a generalized version of the "special quasirandom structure".

EX14-GeneralizedMetadynamics_Si_vasp: simple example of a powerful capability to find complex low-energy structures starting with a simple seed structure (Zhu et al, 2013). Silicon, up to 16 atoms/cell, DFT, VASP. Pay special attention to INCAR files – best of all, just keep the files that you see here, changing only ENCUT, perhaps SIGMA. Evolutionary metadynamics not only predicts low-energy structures, but also gives an idea of transition mechanisms between crystal structures.

EX15-VCNEB_Ar_gulp: example of a variable-cell nudged elastic band (VCNEB: Qian et al., 2013) calculation fcc-hcp transition in a model system, argon, at 0 GPa pressure. Lennard-Jones potential, GULP code.

EX16-USPEX-performance_SrTiO3_gulp: SrTiO3 (50 atoms/cell) at zero pressure. Variable-cell calculation using Buckingham potentials, GULP code. Running this example you can see that even for such a relatively large system USPEX code scores a >90% success rate and remarkable efficiency. This contrasts with a 7-12% success rate reported for the same system and using the same potential by Zurek & Lonie. Clearly, USPEX outperforms the poor reimplementation of our method by Zurek and Lonie. We have witnessed excellent performance of our code also for much larger systems.

EX17-3D_DebyeTemp_C_vasp: Optimization of the elastic properties (the Debye temperature). Example is provided by Haiyang Niu.

EX18-3D_varcomp_ZnOH_GULP: variable composition for ternary system Zn-O-H using ReaxFF. The example is just to demonstrate the capability of the code. Do not expect very precise results. The trick of parallel calculation with whichcluster=0 is also used here. Created by Qiang Zhu.

EX19-Surface-boron111: Prediction of (111) surface reconstruction of alpha-boron, with variable number of atoms (Zhou et al., Phys. Rev. Lett. 113, 176101 (2014))

EX20-0D_Cluster_C60_MOPAC: Cluster structure prediction (000) for C_60 using MOPAC. Example is provided by Zahed Allahyari.

EX21-META_MgO_gulp: Evolutionary metadynamics, with GULP code and Buckingham potentials, MgO with 8 atoms/cell. Starting structure is of rocksalt type, and evolutionary metadynamics finds a number of low-energy structures and structural relations.

EX22-GEM_MgO_gulp: Generalized evolutionary metadynamics, with GULP code and Buckingham potentials. Starting structure is of rocksalt type, with 8 atoms/cell, the calculation is allowed to increase system size up to 16 atoms/cell, and generalized evolutionary metadynamics (GEM) finds a number of low-energy structures and structural relations.
