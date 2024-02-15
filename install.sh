#!/bin/bash

# $Rev: 1185 $
# $Author: mrakitin $
# $Date: 2015-09-10 01:11:34 -0400 (Thu, 10 Sep 2015) $

ECHO="echo -e"
alnum='[[:alnum:]]'
alpha='[[:alpha:]]'

if [ -z $(echo $PWD | grep 'branches') ]; then
    inrepo=0
else
    inrepo=1
fi

if [ $inrepo == 0 ]; then
    version=$(cat src/FunctionFolder/VERSION)
    version="|                          $version                          |"
else
    svn_info=$(svn info)  # SVN info of the branch (9.4.4)
    svn_rev=$(echo "$svn_info" | grep 'Last Changed Rev:' | cut -d: -f2 | awk '{print $1}')
    svn_date=$(echo "$svn_info" | grep 'Last Changed Date:' | cut -d: -f2- | sed 's/^ *//g' | awk -F' ' '{print $1, $2}')

    version="$(cat src/FunctionFolder/VERSION | sed 's/(DD\/MM\/YYYY)/('"r${svn_rev}"', '"${svn_date}"')/g')"
    version="|                  $version                  |"
fi

$ECHO "
*------------------------------------------------------------------------------*
|                                                                              |
|             _|    _|     _|_|_|   _|_|_|     _|_|_|_|   _|      _|           |
|             _|    _|   _|         _|    _|   _|           _|  _|             |
|             _|    _|     _|_|     _|_|_|     _|_|_|         _|               |
|             _|    _|         _|   _|         _|           _|  _|             |
|               _|_|     _|_|_|     _|         _|_|_|_|   _|      _|           |
|                                                                              |
$version
|                                                                              |
|             Evolutionary Algorithm Code for Structure Prediction             |
|                   more info at http://uspex.stonybrook.edu                   |
|                                                                              |
*------------------------------------------------------------------------------*
"

#================================#
$ECHO "=========================="
echo  " Installing USPEX code ..."
$ECHO "=========================="
echo  ""
#================================#

whichMatlab=`which matlab | grep -v "no matlab" | grep matlab | wc -l`
whichOctave=`which octave | grep -v "no octave" | grep octave | wc -l`

#============================================================================================================#
#============================================================================================================#
#============================================================================================================#
echo -e
echo -e
$ECHO  "===================================================="
if [ $whichMatlab -eq 1 ] && [ $whichOctave -eq 0 ]; then
   $ECHO  "...."
   $ECHO  "  MATLAB found at : " `which matlab`
   $ECHO  "...."
   runcode=1
   codepath=`which matlab`
fi
$ECHO  ""

if [ $whichOctave -eq 1 ] && [ $whichMatlab -eq 0 ]; then
   $ECHO  "...."
   $ECHO  "  Octave found at : " `which octave`
   $ECHO  "...."
   runcode=2
   codepath=`which octave`
fi

$ECHO  "===================================================="
echo
echo

if [ $whichMatlab -eq 1 ] && [ $whichOctave -eq 1 ]
then
   echo -e
   $ECHO  "We found MATLAB and Octave installed, "
   $ECHO  "   1) MATLAB :" `which matlab`
   $ECHO  "   2) Octave :" `which octave`
   read -p " which code do you want to use for run USPEX? (1/2) :" RESP
   #===========================================================
   hasChar=`echo $RESP | grep $alnum | wc -l`
   isChar=`echo $RESP  | grep $alpha | wc -l`
    while  [ $RESP -ne 1 ] && [ $RESP -ne 2 ] || [ $isChar -eq 1 ] || [ $hasChar -eq 0  ]
    do
        printf "\033c"
        $ECHO  "We found MATLAB and Octave installed, "
        $ECHO  "   1) MATLAB :" `which matlab`
        $ECHO  "   2) Octave :" `which octave`
        $ECHO  " which code do you want to use for run USPEX? (1/2) :"
        read -p "Please enter 1 or 2 : " RESP
        hasChar=`echo $RESP | grep  $alnum | wc -l`
    done
    echo
    $ECHO     "========================================="
    if [ $RESP -eq 1 ]; then
       runcode=1
       codepath=`which matlab`
       $ECHO  " MATLAB will be used for running USPEX."
    else
       runcode=2
       codepath=`which octave`
       $ECHO  " Octave will be used for running USPEX."
    fi
    $ECHO     "========================================="
   #==========================================================
fi



if [ $whichMatlab -eq 0 ] && [ $whichOctave -eq 0 ]
then
   echo
   $ECHO  "No MATLAB or Octave is not found! We need MATLAB or Octave to run USPEX."
   echo
   read -p "Do you still want to install USPEX? (y/n) " RESP
   hasChar=`echo $RESP | grep $alnum | wc -l`
   while [ "$RESP" != "y" ] && [ "$RESP" != "n" ] && [ "$RESP" != "Y" ] &&  [ "$RESP" != "N" ] ||  [ $hasChar -eq 0  ];
   do
        printf "\033c"
        $ECHO  "Please enter just \"y\" or \"n\" "
        $ECHO  "No MATLAB or Octave is found. We need MATLAB or Octave to run USPEX."
        echo
        read -p "Do you still want to install USPEX? (y/n) " RESP
        hasChar=`echo $RESP | grep $alnum | wc -l`
   done
fi
#============================================================================================================#
#============================================================================================================#
#============================================================================================================#
#============================================================================================================#
#============================================================================================================#
echo
echo

tryTime=1
RESP=n
hasChar=0
while [ $RESP = "n" ] || [ $RESP = "N" ] || [ $hasChar -eq 0  ]
do
    read -p "Please enter the USPEX install path :  " USPEXPATH
    hasChar=`echo $USPEXPATH | grep $alnum | grep '/' | wc -l`
    while [ $hasChar -eq 0 ]
    do
        $ECHO  "Please enter a valid USPEX Install path."
        read -p "Please enter USPEX install path :  " USPEXPATH
        hasChar=`echo $USPEXPATH | grep $alnum | grep '/' | wc -l`
    done

    echo
    read -p "Do you want to install USPEX at $USPEXPATH ? (y/n) " RESP
    hasChar=`echo $RESP | grep $alnum | wc -l`
    #========================================================================#
    while [ "$RESP" != "y" ] && [ "$RESP" != "n" ] && [ "$RESP" != "Y" ] &&  [ "$RESP" != "N" ] || [ $hasChar -eq 0  ];
    do
       printf "\033c"
       $ECHO  "Please enter just \"y\" or \"n\" "
       read -p "   Do you want to install USPEX at $USPEXPATH ? (y/n) " RESP
       hasChar=`echo $RESP | grep $alnum | wc -l`
       continue
    done
    #========================================================================#
    if [ "$RESP" = "y" ] || [ "$RESP" = "Y" ] ; then
        echo " "
        if [ -d $USPEXPATH ]
        then
           $ECHO  "======================================================"
           $ECHO  "The USPEX install directory:"
           $ECHO  "     $USPEXPATH "
           read -p "is found. Do you want to install USPEX there? (y/n) " RESP0
           hasChar=`echo $RESP0 | grep $alnum | wc -l`
           #========================================================================#
           while [ "$RESP0" != "y" ] && [ "$RESP0" != "n" ] && [ "$RESP0" != "Y" ] &&  [ "$RESP0" != "N" ] || [ $hasChar -eq 0 ];
           do
              printf "\033c"
              $ECHO  "Please enter just \"y\" or \"n\" "
              $ECHO  "The USPEX install directory:"
              $ECHO  "     $USPEXPATH "
              read -p "is found. Do you want to install USPEX there? (y/n) " RESP0
              hasChar=`echo $RESP0 | grep $alnum | wc -l`
              continue
           done
           #========================================================================#
           if [ "$RESP0" = "y" ] || [ "$RESP0" = "Y" ]; then
              echo
              touch $USPEXPATH/CODEPATH
              if [ $? -gt 0 ]; then
                 printf "\033c"
                 $ECHO  "Failed to copy files to $USPEXPATH folder. "
                 $ECHO  "Please check the install path and try again."
                 echo
                 RESP=n
                 continue
              fi
              installDIROK=1
           else
              RESP=n
              continue
           fi
        else
           $ECHO  "======================================================"
           $ECHO  "The USPEX install directory:"
           $ECHO  "     $USPEXPATH "
           read -p "is not found. Do you want to create the folder? (y/n) " RESP0
           hasChar=`echo $RESP0 | grep $alnum | wc -l`
           #========================================================================#
           while [ "$RESP0" != "y" ] && [ "$RESP0" != "n" ] && [ "$RESP0" != "Y" ] &&  [ "$RESP0" != "N" ] || [ $hasChar -eq 0 ];
           do
              printf "\033c"
              $ECHO  "Please enter just \"y\" or \"n\" "
              $ECHO  "The USPEX install directory:"
              $ECHO  "     $USPEXPATH "
              read -p "is not found. Do you want to create the folder? (y/n) " RESP0
              hasChar=`echo $RESP0 | grep $alnum | wc -l`
              continue
           done
           #========================================================================#
           if [ "$RESP0" = "y" ] || [ "$RESP0" = "Y" ]; then
              echo
              mkdir -p $USPEXPATH
              if [ ! -d $USPEXPATH ]; then
                 printf "\033c"
                 RESP=N
                 echo
                 continue
              else
                 installDIROK=1
                 $ECHO  "==========================================================================="
                 $ECHO "    USPEX install directory created ..."
              fi
           fi
        fi
    else
        echo " "
    fi
    #========================================================================#
    tryTime=`expr $tryTime + 1`
    if [ $tryTime -gt 5 ]
    then
       $ECHO  "==========================================================================="
       $ECHO  "    Failed to install USPEX, please check your installl path and try again!"
       $ECHO  "==========================================================================="
       exit
    fi
done

#============================================================================#
$ECHO 
$ECHO  "==========================================================================="
$ECHO  "    Copying files, please  wait ...............                       "
$ECHO  "==========================================================================="
$ECHO 

cp -rf doc/      $USPEXPATH/
cp -rf examples/ $USPEXPATH/
cp -rf lib/      $USPEXPATH/
cp -rf src/      $USPEXPATH/
cp -rf tests/    $USPEXPATH/
cp -f  USPEX     $USPEXPATH/

if [ $inrepo == 1 ]; then
    rm -rf `find $USPEXPATH/ -name .svn`
    sed -i 's/(DD\/MM\/YYYY)/('"r${svn_rev}"', '"${svn_date}"') /g' $USPEXPATH/src/FunctionFolder/VERSION
fi

chmod +x $USPEXPATH/src/FunctionFolder/Tool/*


$ECHO  $codepath > $USPEXPATH/CODEPATH

currentPWD=`pwd`
cd $USPEXPATH
installPWD=`pwd`
cd $USPEXPATH
#============================================================================#
echo
$ECHO  "=========================="
$ECHO  "    Install finished."
$ECHO  "=========================="
echo
echo
$ECHO  "1) You can edit the file to change the install path of MATLAB or Octave:"
echo
$ECHO  "   $installPWD/CODEPATH"
echo
$ECHO  "2) Please Set the Shell Environment Variables to enable USPEX code!"
echo
$ECHO  "   For Bash shell system, add these lines to ~/.bashrc or ~/.profile or /etc/profile:"
$ECHO  "     export PATH=$installPWD:\$PATH"
$ECHO  "     export USPEXPATH=$installPWD/src"
echo
$ECHO  "   For C shell system, add these lines to ~/.cshrc or ~/.profile or /etc/profile:"
$ECHO  "     setenv PATH \"$installPWD:\$PATH\""
$ECHO  "     setenv USPEXPATH \"$installPWD/src\""
echo
$ECHO  "3) For tests running, please go to the tests folder and run the following command for more details:"
echo
$ECHO  "   python $installPWD/tests/USPEX_test.py -h"
echo
echo
$ECHO  "=========================="
$ECHO  "    Have fun with USPEX!   "
$ECHO  "=========================="
