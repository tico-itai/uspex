#!/bin/bash

chmod +x neighcrys.out
chmod +x dmacrys.out

FILE=mol.dmain
cp neighcrys_answers fort.22
./neighcrys.out < neighcrys_answers > neigh_log

#If you want to edit the mol.dmain file
#sed -i '/^NBUR/c\NBUR 40 ' mol.dmain    
#sed -i '/^CONP/c\CONV ' mol.dmain    

if [ -f $FILE ];
then
#   echo "File $FILE is generated"
   timeout -k 3 200 ./dmacrys.out <mol.dmain >dma_output
else
   echo "File $FILE does not exist"
fi

