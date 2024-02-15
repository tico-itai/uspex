function Permutation_300(Ind_No)
global POP_STRUC
global ORG_STRUC
global OFF_STRUC
goodMutant = 0;
goodMutLattice = 0;
count = 1;
while goodMutant + goodMutLattice  ~= 2
count = count + 1;
if count > 50
%disp('failed to do Permutation in 50 attempts, switch to Random');
USPEXmessage(511,'',0);
Random_300(Ind_No);
break;
end
toPerMutate = find(ORG_STRUC.tournament>RandInt(1,1,[0,max(ORG_STRUC.tournament)-1]));
ind = POP_STRUC.ranking(toPerMutate(end));
LATTICE = POP_STRUC.POPULATION(ind).LATTICE;
father  = POP_STRUC.POPULATION(ind).COORDINATES;
numIons = POP_STRUC.POPULATION(ind).numIons;
order = POP_STRUC.POPULATION(ind).order;
[PERMUT,noOfSwapsNow] = swapIons_mutation_final(father, numIons, order);
if noOfSwapsNow > 0
goodMutant = distanceCheck(PERMUT,LATTICE, numIons, ORG_STRUC.minDistMatrice);
end
goodMutant = ( goodMutant & (CompositionCheck(numIons/ORG_STRUC.numIons)) );
goodMutLattice = 1; 
if goodMutant + goodMutLattice == 2
OFF_STRUC.POPULATION(Ind_No).COORDINATES =  PERMUT;
OFF_STRUC.POPULATION(Ind_No).LATTICE = LATTICE;
OFF_STRUC.POPULATION(Ind_No).numIons = numIons;
OFF_STRUC.POPULATION(Ind_No).howCome = 'Permutate';
info_parents = struct('parent1', {},'noOfSwapsNow', {}, 'enthalpy', {});
info_parents(1).parent=num2str(POP_STRUC.POPULATION(ind).Number);
info_parents.noOfSwapsNow=noOfSwapsNow;
info_parents.enthalpy=POP_STRUC.POPULATION(ind).Enthalpies(end)/sum(numIons);
OFF_STRUC.POPULATION(Ind_No).Parents = info_parents;
disp(['Structure ' num2str(Ind_No) ' generated by permutation']);
end
end