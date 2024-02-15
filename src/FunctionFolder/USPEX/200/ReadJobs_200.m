function ReadJobs_200()
global ORG_STRUC
global POP_STRUC
for indic = 1:ORG_STRUC.numParallelCalcs
whichInd = find([POP_STRUC.POPULATION(:).Folder]==indic);
if ~isempty (whichInd)
Step = POP_STRUC.POPULATION(whichInd).Step;
disp(['Structure' num2str(whichInd) ' step' num2str(Step) ' at CalcFold' num2str(indic) ]);
if POP_STRUC.POPULATION(whichInd).JobID
if (ORG_STRUC.platform > 0) | (ORG_STRUC.numParallelCalcs > 1)
disp(['JobID=' num2str(POP_STRUC.POPULATION(whichInd).JobID) ]);
end
doneOr = checkStatusC(whichInd);
if doneOr
if POP_STRUC.POPULATION(whichInd).JobID == 0.01   
POP_STRUC.POPULATION(whichInd).Step = length([ORG_STRUC.abinitioCode]) + 1;
elseif POP_STRUC.POPULATION(whichInd).JobID ~= 0.02   
Error = Reading(ORG_STRUC.abinitioCode(Step),whichInd, indic);
if Error == 0
lattice    = POP_STRUC.POPULATION(whichInd).LATTICE;
coordinate = POP_STRUC.POPULATION(whichInd).COORDINATES;
cell       = POP_STRUC.POPULATION(whichInd).cell;
[lat,candidate,vol,atyplist,numIons]=reduce_Surface(lattice,coordinate,whichInd);
if isequal(numIons, ORG_STRUC.numIons*prod(cell))
POP_STRUC.POPULATION(whichInd).Surface_LATTICE=lat;
POP_STRUC.POPULATION(whichInd).Surface_COORDINATES=candidate;
POP_STRUC.POPULATION(whichInd).Surface_typesAList=atyplist;
POP_STRUC.POPULATION(whichInd).Surface_numIons=numIons;
else
MakeupSurface(whichInd,lat,candidate,atyplist,numIons);
end
if Step < length ([ORG_STRUC.abinitioCode]) 
surcoor = POP_STRUC.POPULATION(whichInd).Surface_COORDINATES;
surnumIons = POP_STRUC.POPULATION(whichInd).Surface_numIons;
bulklat=POP_STRUC.POPULATION(whichInd).Bulk_LATTICE;
bulkcoor=POP_STRUC.POPULATION(whichInd).Bulk_COORDINATES;
atyp=POP_STRUC.POPULATION(whichInd).Bulk_typesAList;
ntyp=POP_STRUC.POPULATION(whichInd).Bulk_numIons;
[lat,candidate,numIons,typesAList,chanAList] = ...
makeSurface(lat,surcoor,surnumIons,bulklat,bulkcoor,atyp,ntyp,ORG_STRUC.vacuumSize(Step));
POP_STRUC.POPULATION(whichInd).numIons = numIons;
POP_STRUC.POPULATION(whichInd).LATTICE = lat;
POP_STRUC.POPULATION(whichInd).COORDINATES = candidate;
POP_STRUC.POPULATION(whichInd).typesAList = typesAList;
POP_STRUC.POPULATION(whichInd).chanAList=chanAList;
end
end
end
POP_STRUC.POPULATION(whichInd).JobID = 0;
if POP_STRUC.POPULATION(whichInd).Error > ORG_STRUC.maxErrors
POP_STRUC.POPULATION(whichInd).Done = 1;
POP_STRUC.POPULATION(whichInd).ToDo = 0;
POP_STRUC.POPULATION(whichInd).Folder=0;
elseif POP_STRUC.POPULATION(whichInd).Step > length ([ORG_STRUC.abinitioCode]) 
POP_STRUC.POPULATION(whichInd).Done = 1;
POP_STRUC.POPULATION(whichInd).ToDo = 0;
POP_STRUC.bodyCount = POP_STRUC.bodyCount + 1;
POP_STRUC.POPULATION(whichInd).Number = POP_STRUC.bodyCount;
LATTICE = POP_STRUC.POPULATION(whichInd).Surface_LATTICE;
COORDINATES = POP_STRUC.POPULATION(whichInd).Surface_COORDINATES;
numIons = POP_STRUC.POPULATION(whichInd).Surface_numIons;
[Ni, V, dist_matrix, typ_i, typ_j, ho, ht] = makeMatrices_2D...
(LATTICE, COORDINATES, numIons, ORG_STRUC.atomType);
[order, FINGERPRINT, atom_fing] = fingerprint_calc_2D...
(Ni, V, dist_matrix, typ_i, typ_j, numIons, ho, ht);
POP_STRUC.POPULATION(whichInd).Surface_order =  order;
POP_STRUC.POPULATION(whichInd).FINGERPRINT = FINGERPRINT;
POP_STRUC.POPULATION(whichInd).struc_entr = structureQuasiEntropy(whichInd, atom_fing);
POP_STRUC.POPULATION(whichInd).S_order    = StructureOrder...
(FINGERPRINT, V, numIons, ORG_STRUC.deltaFing, ORG_STRUC.weight);
disp('Relaxation is done.')
disp(' ')
POP_STRUC.DoneOrder(whichInd) = POP_STRUC.bodyCount;
WriteIndividualOutput_200(whichInd);
POP_STRUC.POPULATION(whichInd).Folder=0;
end
safesave ('Current_POP.mat', POP_STRUC)
end
end
end
end
