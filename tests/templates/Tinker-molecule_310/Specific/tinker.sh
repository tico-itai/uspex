#!/bin/bash


date    > JOB_LOG
# remove the old files
rm -f *.xyz*
# convert the original structure into cartesian
crystal input.fra 1   > output

# relax the original *.xyz structure
echo Step_______1 >> JOB_LOG
cp toptions.key_1 input.key
optimize  input.xyz  -k input.key 0.01>> output

FILE=input.xyz_2
if [ -f $FILE ];
then
  echo Step_______2 >> JOB_LOG
  cp toptions.key_2 input.key
  mv input.xyz_2 input.xyz
  xtalmin  input.xyz  -k input.key 0.01>> output
else
  echo "TINKER STOPS without OUTPUT" > output
fi

if [ -f $FILE ];
then
  echo Step_______3 >> JOB_LOG
  cp toptions.key_3 input.key
  mv input.xyz_2 input.xyz
  xtalmin  input.xyz  -k input.key 0.002>> output
else
  echo "TINKER STOPS without OUTPUT" > output
fi
# convert the relaxed *.xyz_2 structure into *.frac
rm -f *.frac

if [ -f $FILE ];
then
   mv input.xyz_2 output.xyz
   crystal output.xyz 2   >> output
fi

date >> JOB_LOG
echo JOB_IS_FINISHED >> JOB_LOG

