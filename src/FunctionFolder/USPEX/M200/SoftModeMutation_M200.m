function SoftModeMutation_M200(Ind_No)
global POP_STRUC
global ORG_STRUC
global OFF_STRUC
goodAtomMutant = 0;
toMutate = find(ORG_STRUC.tournament>RandInt(1,1,[0,max(ORG_STRUC.tournament)-1]));
ind = POP_STRUC.ranking(toMutate(end));
numIons = POP_STRUC.POPULATION(ind).numIons;
lat_2D = POP_STRUC.POPULATION(ind).LATTICE_2D;
coor_2D = POP_STRUC.POPULATION(ind).COORDINATES_2D;
N = sum(numIons);
FINGERPRINT = POP_STRUC.POPULATION(ind).FINGERPRINT;
flag=0;
for j = 1 : length(POP_STRUC.SOFTMODEParents)
dist_ij = cosineDistance(FINGERPRINT, POP_STRUC.SOFTMODEParents(j).fingerprint, ORG_STRUC.weight);
if dist_ij < ORG_STRUC.toleranceFing
flag = 1;
ID =j;
break;
end
end
[freq, eigvector] = calcSoftModes(ORG_STRUC.NvalElectrons, ORG_STRUC.valences, numIons, lat_2D, coor_2D);
freq = diag(freq);
[freq, IX] = sort(freq);
non_zero = 0;
if flag == 1
M2 = sum(eigvector(:,IX(POP_STRUC.SOFTMODEParents(j).Softmode_num)).^2);
M4 = sum(eigvector(:,IX(POP_STRUC.SOFTMODEParents(j).Softmode_num)).^4);
participation_ratio = M2/M4; 
last_good = POP_STRUC.SOFTMODEParents(j).Softmode_Fre;
for i = 1:length(freq)
M2 = sum(eigvector(:,IX(i)).^2);
M4 = sum(eigvector(:,IX(i)).^4);
pr1 = M2/M4;
if (freq(i) > (1.05)*last_good) | ((freq(i) >= last_good) & (abs(1-participation_ratio/pr1) > 0.05))
non_zero = i;
break
end
end
else
for i = 1:length(freq)        
if freq(i) > 0.0000001
non_zero = i;
break;
end
end
end         
if non_zero >0
loop = 0;
current_freq = non_zero;
good_freq = non_zero;
for f = good_freq : non_zero + round((3*N-non_zero)/2)  
if loop==1
break
else
for i = 0 : 20
if rand > 0.5
[MUT_LAT, MUT_COORD, deviation] = move_along_SoftMode_Mutation(coor_2D, numIons, lat_2D, eigvector(:,IX(f)), 1-i/21);
else
[MUT_LAT, MUT_COORD, deviation] = move_along_SoftMode_Mutation(coor_2D, numIons, lat_2D, -1*eigvector(:,IX(f)), 1-i/21);
end
[lat_new,candidate] = make2D(MUT_LAT,MUT_COORD,ORG_STRUC.vacuumSize(1));
goodAtomMutant = distanceCheck(candidate, lat_new, numIons, ORG_STRUC.minDistMatrice);
if goodAtomMutant == 1
goodAtomMutant = checkConnectivity(candidate, lat_new, numIons);
end
if goodAtomMutant == 1
loop=1;
break;
elseif (i == 21) & (f == non_zero + round((3*N-non_zero)/2))
break;         
end
end
end
good_freq=good_freq+1;
end        
if goodAtomMutant == 1
OFF_STRUC.POPULATION(Ind_No).COORDINATES_2D = MUT_COORD;
OFF_STRUC.POPULATION(Ind_No).LATTICE_2D = MUT_LAT;
OFF_STRUC.POPULATION(Ind_No).LATTICE = lat_new;
OFF_STRUC.POPULATION(Ind_No).COORDINATES = candidate;
OFF_STRUC.POPULATION(Ind_No).numIons = numIons;
info_parents = struct('parent', {},'mut_degree', {},'mut_mode',{},'mut_fre',{}, 'enthalpy', {});
info_parents(1).parent = num2str(POP_STRUC.POPULATION(ind).Number);
info_parents.mut_degree = deviation;
info_parents.mut_mode=f;
info_parents.mut_fre=freq(f);
info_parents.enthalpy = POP_STRUC.POPULATION(ind).Enthalpies(end)/sum(numIons);                 
OFF_STRUC.POPULATION(Ind_No).Parents = info_parents;
OFF_STRUC.POPULATION(Ind_No).howCome = 'softmutate';
disp(['Structure ' num2str(Ind_No) '  generated by softmutation']);
if flag == 1
POP_STRUC.SOFTMODEParents(ID).Softmode_Fre=freq(f);
POP_STRUC.SOFTMODEParents(ID).Softmode_num=f;
else
POP_STRUC.SOFTMODEParents(end+1).lattice=lat_2D;
POP_STRUC.SOFTMODEParents(end).coordinates=coor_2D;
POP_STRUC.SOFTMODEParents(end).fingerprint=FINGERPRINT;
POP_STRUC.SOFTMODEParents(end).Softmode_Fre=freq(f);
POP_STRUC.SOFTMODEParents(end).Softmode_num=f;
POP_STRUC.SOFTMODEParents(end).numIons=numIons;
end 
else
Mutation_M200(Ind_No);
end   
else
Mutation_M200(Ind_No);
end
