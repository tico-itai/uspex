****************************************************
*   This folder contains standard tests of USPEX   *
****************************************************
Before testing, put executables of VASP, SIESTA, GULP,... (whichever codes you are using) in folders Specific as ./Specific/vasp,
./Specific/siesta, ./Specific/gulp.

To run USPEX, simply type:

    nohup matlab < USPEX.m > log &
or
    nohup USPEX -r > log &

(or analogous command line with Octave). Well, this is described in the Manual - and before doing anything, you should read the Manual!

These are oversimplifies tests, meant for checking that main operations of the USPEX code run correctly. These are NOT examples of realistic calculations.

For examples of realistic, accurate and reliable calculations, please see folder "examples".

Keep in mind that to get reliable results for physical systems you really need to do ab initio calculations, as most forcefields are not sufficiently accurate.
