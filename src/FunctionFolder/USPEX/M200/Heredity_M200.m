function Heredity_M200(Ind_No)
global POP_STRUC
global ORG_STRUC
global OFF_STRUC
info_parents = struct('parent', {},'fracFrac', {},'dimension', {},'offset', {},'enthalpy', {});
searching = 1;
count = 1;
while searching
count = count + 1;
if count > 50
%disp('failed to do mutation in 50 attempts, switch to Random');
USPEXmessage(508,'',0);
Random_M200(Ind_No);
break;
end
same = 1;
while same
par_one = find (ORG_STRUC.tournament>RandInt(1,1,[0,max(ORG_STRUC.tournament)-1]));
par_two = find (ORG_STRUC.tournament>RandInt(1,1,[0,max(ORG_STRUC.tournament)-1]));
ind1 = POP_STRUC.ranking(par_one(end));
ind2 = POP_STRUC.ranking(par_two(end));
if ind1 ~= ind2
same = 0;
end
end
goodHeritage = 0;
securityCheck = 0;
while goodHeritage ~=1
securityCheck = securityCheck+1;
offset=[];
[numIons, Offspring, Lattice,fracFrac,dimension,offset] = heredity_final(ind1,ind2);
[lat,candidate] = make2D(Lattice,Offspring,0);
goodHeritage = distanceCheck(Offspring, lat, numIons, ORG_STRUC.minDistMatrice);
if goodHeritage == 1
goodHeritage = checkConnectivity(Offspring, lat, numIons);
end
if goodHeritage == 1
OFF_STRUC.POPULATION(Ind_No).numIons = numIons;
OFF_STRUC.POPULATION(Ind_No).LATTICE = lat;
OFF_STRUC.POPULATION(Ind_No).COORDINATES = candidate;
OFF_STRUC.POPULATION(Ind_No).COORDINATES_2D = Offspring;
OFF_STRUC.POPULATION(Ind_No).LATTICE_2D = Lattice;
parents = [ind1 ind2];
fracFrac = [0 fracFrac 1];
enthalpy = 0;
ID = [];
for i = 2:length(fracFrac)
ID= [ID POP_STRUC.POPULATION(parents(i-1)).Number];
E = POP_STRUC.POPULATION(parents(i-1)).Enthalpies(end);
ratio=fracFrac(i)-fracFrac(i-1);
enthalpy = enthalpy+E*ratio;
end
info_parents(1).parent = num2str(ID);
info_parents.enthalpy  = enthalpy(end);
info_parents.enthalpy  = info_parents.enthalpy/sum(numIons);
info_parents.fracFrac  = fracFrac;
info_parents.dimension = dimension;
info_parents.offset    = offset;
OFF_STRUC.POPULATION(Ind_No).Parents = info_parents;
OFF_STRUC.POPULATION(Ind_No).howCome = 'Heredity';
disp(['Structure ' num2str(Ind_No) '  generated by heredity']);
searching=0;
end
if securityCheck>20
break
end
end
end
