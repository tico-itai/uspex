function loops_seed = pick_Seeds_surface()
global POP_STRUC
global ORG_STRUC
warning off
cd Seeds
disp(' ');
disp('Read Seeds ... ')
disp(' ');
loops_seed = 0;
if exist([ 'POSCARS_', num2str(POP_STRUC.generation) ])
if exist('POSCARS')
[nothing, nothing] = unix([ 'cat POSCARS >> POSCARS_' num2str(POP_STRUC.generation) ]);
end
[nothing, nothing] = unix([ 'cp POSCARS_' num2str(POP_STRUC.generation) ' POSCARS' ]);
end
if exist('POSCARS')
[fid,message] = fopen('POSCARS');
while 1
try
tmp = fgetl(fid);      
if tmp==-1             
break;
else
domatch = 0;
if ~isempty(findstr(tmp,'SuperCell'))  
domatch = 1;
marker = findstr(tmp,':')+1;
cellsize = str2num(tmp(marker:end)); 
end
end
scale_factor = fgetl(fid); 
optlattice   = fscanf(fid,'%g',[3,3]); % lattice vectors
candidate_lat= optlattice'*str2num(scale_factor);
tmp = fgetl(fid);  
atomType = fgetl(fid); 
if str2num(atomType)
USPEXmessage(551, '', 0);
break;
end
ntyp = fgetl(fid); 
ntyp = str2num(ntyp);
N_type = length(ntyp);
atomType1 = GetElement(N_type, atomType);
isAtomTypeOK=1;
if N_type > length(ORG_STRUC.atomType) 
USPEXmessage(552, '', 0);
isAtomTypeOK = 0;
elseif sum(ismember(atomType1, ORG_STRUC.atomType))<N_type
USPEXmessage(553, '', 0);
isAtomTypeOK = 0;
end
if  isAtomTypeOK == 0
warningStr = ['Seeds : Elemental types are inconsistent when reading Seeds-' num2str(loops_seed+1) ];
USPEXmessage(0, warningStr, 0);
break;
end
numIons = zeros(1,length(ORG_STRUC.atomType));
atomType_Seeds = atomType1;
for i=1:length(ORG_STRUC.atomType)
for j=1:length(ntyp)
if atomType1(j)==ORG_STRUC.atomType(i)
numIons(i) = ntyp(j);
end
end
end
natom = sum(ntyp); 
tmp   = fgetl(fid);
candidate_pop_tmp = fscanf(fid,'%g',[3,natom]);
candidate_pop = candidate_pop_tmp';
tmp  =fgetl(fid); 
Add = length(POP_STRUC.POPULATION) + 1;
if POP_STRUC.generation == 1
ORG_STRUC.initialPopSize = ORG_STRUC.initialPopSize + 1;
Add = ORG_STRUC.initialPopSize;
end
info_parents = struct('parent',{}, 'enthalpy', {});
info_parents(1).parent = [];
POP_STRUC.POPULATION(Add).Parents = info_parents;
POP_STRUC.POPULATION(Add).howCome = '  Seeds';
bulk_lat    =ORG_STRUC.bulk_lat;
bulk_pos    =ORG_STRUC.bulk_pos;
bulk_atyp   =ORG_STRUC.bulk_atyp;
bulk_numIons=ORG_STRUC.bulk_ntyp;
if domatch==1
basic_lat = candidate_lat;
basic_lat(1,:) = basic_lat(1,:)/cellsize(1);
basic_lat(2,:) = basic_lat(2,:)/cellsize(2);
cell_bulk(1) = round(bulk_lat(1,1)/basic_lat(1,1));
cell_bulk(2) = round(bulk_lat(2,2)/basic_lat(2,2));
CellList = findcell(ORG_STRUC.reconstruct);
ID = ceil(rand()*size(CellList,1));
cell = CellList(ID,:);
else
cell(1) = round(candidate_lat(1,1)/bulk_lat(1,1));
cell(2) = round(candidate_lat(2,2)/bulk_lat(2,2));
end
POP_STRUC.POPULATION(Add).cell = cell(1:2);
cell(3)=1;
[bulk_lat, bulk_pos, bulk_atyp, bulk_numIons]=supercell(bulk_lat, bulk_pos, bulk_atyp, bulk_numIons, cell);
POP_STRUC.POPULATION(Add).Bulk_LATTICE=bulk_lat;
POP_STRUC.POPULATION(Add).Bulk_COORDINATES=bulk_pos;
POP_STRUC.POPULATION(Add).Bulk_typesAList=bulk_atyp;
POP_STRUC.POPULATION(Add).Bulk_numIons=bulk_numIons;
if domatch == 1
count = 0;
for i = 1:length(numIons)
for j = 1:numIons(i)
count = count + 1;
typesAList(count) = ORG_STRUC.atomType(i);
order(count) = 0;
end
end 
bigcell(1)=cell(1)*cell_bulk(1);
bigcell(2)=cell(2)*cell_bulk(2);
[candidate_lat, candidate_pop, atype1, order, numIons]=...
cresupercell(candidate_lat, candidate_pop, typesAList, order, cellsize, bigcell);
disp(['Composition changes: from ' num2str(ntyp) ' to ' num2str(numIons)])
end
sur_numIons = numIons - bulk_numIons;
chanAList_tmp = [];
typesAList = [];
for i = 1: length(ORG_STRUC.atomType)
tmp = [];
tmp = zeros(numIons(i),1);
tmp(1:sur_numIons(i)) = 1;
chanAList_tmp = [chanAList_tmp; tmp];
typesAList = [typesAList; ORG_STRUC.atomType(i)*ones(numIons(i),1)];
end
POP_STRUC.POPULATION(Add).Surface_numIons=sur_numIons;
POP_STRUC.POPULATION(Add).chanAList = chanAList_tmp';
POP_STRUC.POPULATION(Add).typesAList = typesAList';
POP_STRUC.POPULATION(Add).LATTICE = candidate_lat;
POP_STRUC.POPULATION(Add).COORDINATES = candidate_pop;
POP_STRUC.POPULATION(Add).numIons = numIons;
loops_seed = loops_seed + 1;
disp(['seed number ' num2str(loops_seed) ' has been successfully added']);
catch
warningStr = (['Seeds : Meet a problem when reading Seeds-' num2str(loops_seed+1),...
', so we stop the rest seeds reading...']);
USPEXmessage(0, warningStr, 0);
break
end
end  
status = fclose(fid);
disp(' ')
disp('End of pickup Seeds')
[nothing, nothing] = unix([ 'echo Generation:' num2str(POP_STRUC.generation) '>> ../' ORG_STRUC.resFolder '/Seeds_history' ]);
[nothing, nothing] = unix([ 'cat POSCARS >> ../' ORG_STRUC.resFolder '/Seeds_history' ]);
[nothing, nothing] = unix([ 'mv POSCARS POSCARS_' num2str(POP_STRUC.generation) ]);
end
cd ..
