function  NEB_caclCartTuo
global ORG_STRUC
global POP_STRUC
numImages = ORG_STRUC.numImages;
sumIons  = sum(ORG_STRUC.numIons);
dimension  = ORG_STRUC.dimension;
numDimension = 3*(sumIons+dimension);
dE_1 = 0;    
dE_2 = 0;    
if 1==ORG_STRUC.CalcType
for i = 2:numImages-1
tuo_plus = POP_STRUC.POPULATION(i+1).caCoordVector - POP_STRUC.POPULATION(i).caCoordVector;
tuo_minu =   POP_STRUC.POPULATION(i).caCoordVector - POP_STRUC.POPULATION(i-1).caCoordVector;
dE_1 = abs( POP_STRUC.POPULATION(i+1).Enthalpy - POP_STRUC.POPULATION(i).Enthalpy );
dE_2 = abs( POP_STRUC.POPULATION(i).Enthalpy - POP_STRUC.POPULATION(i-1).Enthalpy );
dE_max = max( dE_1, dE_2 );
dE_min = min( dE_1, dE_2 );
if  (POP_STRUC.POPULATION(i+1).Enthalpy > POP_STRUC.POPULATION(i).Enthalpy)  & (POP_STRUC.POPULATION(i).Enthalpy > POP_STRUC.POPULATION(i-1).Enthalpy)
tuo_N = tuo_plus;
elseif  (POP_STRUC.POPULATION(i+1).Enthalpy < POP_STRUC.POPULATION(i).Enthalpy)  & (POP_STRUC.POPULATION(i).Enthalpy < POP_STRUC.POPULATION(i-1).Enthalpy)
tuo_N = tuo_minu;
else
if  (POP_STRUC.POPULATION(i+1).Enthalpy >= POP_STRUC.POPULATION(i-1).Enthalpy)
tuo_N = tuo_plus*dE_max + tuo_minu*dE_min;
elseif  (POP_STRUC.POPULATION(i+1).Enthalpy < POP_STRUC.POPULATION(i-1).Enthalpy)
tuo_N = tuo_plus*dE_min + tuo_minu*dE_max;
end
end
POP_STRUC.POPULATION(i).tuo = tuo_N/norm(tuo_N);
%disp(['tuo :   ' num2str(i) ])
end
end
%    disp(['X_image :   ' num2str(i) ])
