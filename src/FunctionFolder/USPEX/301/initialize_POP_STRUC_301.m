function initialize_POP_STRUC_301()
global ORG_STRUC
global POP_STRUC
global POOL_STRUC
ORG_STRUC.wrong_spacegroups = 0;
POOL_STRUC = struct('POPULATION',{}, 'Composition_ratio',{}, 'Composition_ranking',{}, 'Composition_surviving',{}, 'Composition_Bestenthalpy',{}, 'Composition_fitness',{});
POOL_STRUC(1).POPULATION  = struct('COORDINATES', {}, 'LATTICE', {}, 'numIons', {}, 'numBlocks',{}, 'order', {}, 'enthalpy', {}, 'Number', {});
for i=1:size(ORG_STRUC.numIons,1)
POOL_STRUC.Composition_ratio(i,:) = ORG_STRUC.numIons(i,:)/sum(ORG_STRUC.numIons(i,:));
POOL_STRUC.Composition_ranking(i) = 0;
POOL_STRUC.Composition_surviving(i) = 1;
POOL_STRUC.Composition_Bestenthalpy(i) = 1000;
POOL_STRUC.Composition_fitness(i) = 1000;
end
POOL_STRUC.POPULATION(1) = QuickStart(POOL_STRUC.POPULATION);
POP_STRUC = struct('POPULATION',{}, 'SOFTMODEParents',{}, 'SOFTMUTATED',{}, 'resFolder', {},'generation',{}, ...
'DoneOrder',{}, 'bodyCount', {}, 'ranking',{},'bad_rank',{}, 'convex_hull',{}, 'fitness', {});
POP_STRUC(1).POPULATION = struct('COORDINATES',{},'INIT_COORD',{},'LATTICE',{},'INIT_LAT',{},'numIons',{},'INIT_numIons',{}, ...
'struc_entr',{},'order',{},'S_order',{},'dielectric_tensor',{}, 'gap',{}, 'hardness',{}, 'symg',{}, ...
'mag_moment',{}, 'magmom_ions',{}, 'magmom_ini',{}, 'ldaU', {}, ...
'powerfactor',{}, 'FINGERPRINT',{}, 'K_POINTS',{}, 'Step', {}, 'Enthalpies', {}, 'Error',{},'Done',{},...
'ToDo',{},'Parents',{},'howCome',{},'JobID',{},'Folder',{}, 'numBlocks', {},'Number',{});
POP_STRUC.POPULATION(1) = QuickStart(POP_STRUC.POPULATION);
POP_STRUC(1).SOFTMUTATED = struct('FINGERPRINT',{}, 'mutatedAt', {}, 'fallBack', {});
POP_STRUC(1).SOFTMODEParents=struct('lattice',{},'coordinates',{},'fingerprint',{},'eignFre',{},'eignVec',{},...
'Softmode_Fre',{},'Softmode_num',{},'numIons',{},'numBlocks',{});
POP_STRUC.generation = 1;
POP_STRUC.bodyCount = 0;
POP_STRUC.bad_rank = 0;
N_T = size(ORG_STRUC.numIons,1);
IPS = ORG_STRUC.initialPopSize;
fp = fopen('Seeds/compositions', 'w');
if exist('Seeds/Anti-compositions')
[nothing, nothing] = unix('mv Seeds/Anti-compositions Seeds/Anti-compositions-back');
end
for i=1:size(ORG_STRUC.firstGeneSplit,1)
for j=1:size(ORG_STRUC.firstGeneSplit,2)
fprintf(fp, '%4d', ORG_STRUC.firstGeneSplit(i,j));
end
fprintf(fp, '\n');
end
fclose(fp);
if (ORG_STRUC.firstGeneMax == 0) || (ORG_STRUC.firstGeneMax > IPS)
ORG_STRUC.firstGeneMax = IPS;
end
if (ORG_STRUC.firstGeneMax > ORG_STRUC.splitN)
ORG_STRUC.firstGeneMax = ORG_STRUC.splitN;
end
split_rank_temp = randperm(ORG_STRUC.splitN);
split_rank = split_rank_temp;
for it = 1 : N_T
for jt = 1 : ORG_STRUC.splitN
if sum(ORG_STRUC.firstGeneSplit(split_rank_temp(jt),:)) == ORG_STRUC.firstGeneSplit(split_rank_temp(jt),it)
split_rank(it) = split_rank_temp(jt);
split_rank(jt) = split_rank_temp(it);
split_rank_temp = split_rank;
break;
end
end
end
cnt = N_T;
split_rank_temp = split_rank;
for it = 1 : ORG_STRUC.splitN
good_comp = 1;
for jt = 1 : cnt
same = sameComposition(ORG_STRUC.firstGeneSplit(split_rank(jt),:), ORG_STRUC.firstGeneSplit(split_rank_temp(it),:));
if same == 1
good_comp = 0;
end
end
if (good_comp == 1) && (size(ORG_STRUC.firstGeneSplit,1) - it) <= (ORG_STRUC.firstGeneMax - cnt)
good_comp = 1;
end
if good_comp == 1
cnt = cnt + 1;
split_rank(cnt) = split_rank_temp(it);
split_rank(it) = split_rank_temp(cnt);
end
if cnt >= ORG_STRUC.firstGeneMax
break;
end
end
if ORG_STRUC.firstGeneMax < N_T    
ORG_STRUC.firstGeneMax = N_T;
end
spl = 1;
for it = 1 : IPS
while spl > ORG_STRUC.firstGeneMax
spl = spl - ORG_STRUC.firstGeneMax;
end
POP_STRUC.POPULATION(it).numBlocks = ORG_STRUC.firstGeneSplit(split_rank(spl),:);
if N_T > 1
if spl <= N_T
POP_STRUC.POPULATION(it).numBlocks = zeros(1, N_T); 
POP_STRUC.POPULATION(it).numBlocks(spl) = round(ORG_STRUC.minAt/sum(ORG_STRUC.numIons(spl,:))) + round(rand*((ORG_STRUC.maxAt-ORG_STRUC.minAt)/sum(ORG_STRUC.numIons(spl,:))));
while sum(POP_STRUC.POPULATION(it).numBlocks(spl)*ORG_STRUC.numIons(spl,1:end)) > ORG_STRUC.maxAt
POP_STRUC.POPULATION(it).numBlocks(spl) = POP_STRUC.POPULATION(it).numBlocks(spl) - 1;
if POP_STRUC.POPULATION(it).numBlocks(spl) < 0
break;
end
end
if POP_STRUC.POPULATION(it).numBlocks(spl) < 1
POP_STRUC.POPULATION(it).numBlocks(spl) = 1;
end
else 
tmp = POP_STRUC.POPULATION(it).numBlocks;
for i = 1 : ORG_STRUC.splitN
same = sameComposition(POP_STRUC.POPULATION(it).numBlocks, ORG_STRUC.firstGeneSplit(i,:));
if same == 1
tmp = vertcat(tmp,ORG_STRUC.firstGeneSplit(i,:));
end
end
k = 1 + floor(rand*size(tmp,1));
POP_STRUC.POPULATION(it).numBlocks = tmp(k,:);
end
end
spl = spl + 1;
end
for it = 1 : IPS
POP_STRUC.POPULATION(it).numIons = POP_STRUC.POPULATION(it).numBlocks*ORG_STRUC.numIons;
end
goodPop = 1;
newSym = 1;
badSymmetry = 0;
nsym = 0;
sym_coef = 1;
failedDist = 0;
minDistMatrice = ORG_STRUC.minDistMatrice;
tic
while goodPop < ORG_STRUC.initialPopSize + 0.5
failedTime = toc;
if (failedDist > 10000) || (failedTime > 300)
if minDistMatrice(1,1) > 0.8*ORG_STRUC.minDistMatrice(1,1)
if failedTime > 300
%disp('WARNING! Can not generate a structure after 5 minutes. The minimum distance threshold will be lowered by 0.1.');
USPEXmessage(505,'',0);
else
%disp('WARNING! Can not generate a structure after 10000 tries. The minimum distance threshold will be lowered by 0.1.');
USPEXmessage(506,'',0);
end
%disp('Please check your IonDistances parameter.');
%disp(' ');
minDistMatrice = 0.9*minDistMatrice;
failedDist = 0;
tic
else
disp('Could not generate a structure after 30000 tries or 15 minutes.');
disp('Please check the input files. The calculation has to stop.');
disp('Possible reasons:  unreasonably big IonDistances.');
quit;
end
end
errorS = 0;
Stokes = 0;
candidate = rand(sum(POP_STRUC.POPULATION(goodPop).numIons),3);
numIons = POP_STRUC.POPULATION(goodPop).numIons;
if ORG_STRUC.nsymN(1,1) == 0  
sym_coef = ORG_STRUC.sym_coef;
Stokes = 1;
if (badSymmetry > 15) || ((badSymmetry > 5) && (sum(ORG_STRUC.splitInto)>3))
badSymmetry = 0;
newSym = 1;      
end
badSymmetry = badSymmetry + 1;
if newSym
tmp = find(ORG_STRUC.nsym > 0);
nsym = tmp(ceil(rand*length(tmp))); 
newSym = 0;
end
if ORG_STRUC.constLattice    
lat1 = ORG_STRUC.lattice;
else                         
lat1 = 0;
for it = 1 : length(ORG_STRUC.latVolume)
lat1 = lat1 + POP_STRUC.POPULATION(goodPop).numBlocks(it)*ORG_STRUC.latVolume(it);
end
end
if sum(ORG_STRUC.splitInto)<4
cd([ORG_STRUC.homePath '/CalcFoldTemp']);
[candidate, lat, errorS] = symope_crystal(nsym, numIons, lat1, minDistMatrice, ORG_STRUC.sym_coef);
Ind_No = goodPop;
if errorS == 0
[resulted_sg_no, nothing] = determine_spacegroup(lat, candidate, ORG_STRUC.atomType, ...
numIons, nsym, POP_STRUC.bodyCount + Ind_No, ...
ORG_STRUC.SGtolerance, ORG_STRUC.homePath);
end
cd(ORG_STRUC.homePath)
else
startLat = rand(6,1);
startLat(4:6) = (pi/2);
check_startLat = latConverter(startLat);
volLat = det(check_startLat);
ratio = lat1/volLat;
startLat(1:3) = startLat(1:3)*(ratio)^(1/3);
[lat, errorS, candidate] = splitBigCell(startLat, ORG_STRUC.splitInto(ceil(length(ORG_STRUC.splitInto)*rand)),numIons, nsym);
end
end
if errorS == 1
goodBad = 0;
else
goodBad = distanceCheck(candidate, lat, numIons, minDistMatrice*sym_coef);
end
if goodBad
if nsym ~= resulted_sg_no
ORG_STRUC.wrong_spacegroups = ORG_STRUC.wrong_spacegroups + 1;
end
POP_STRUC.POPULATION(goodPop).LATTICE = lat;
POP_STRUC.POPULATION(goodPop).COORDINATES = candidate;
POP_STRUC.POPULATION(goodPop).howCome = '  Random  ';
tic
failedDist = 0;
newSym = 1;
if Stokes == 1
disp(['Crystal ' num2str(goodPop) ' built with the symmetry group ' num2str(nsym) ' (' spaceGroups(nsym) ') composition ' num2str(numIons)]);
POP_STRUC.POPULATION(goodPop).symg = nsym;
else
disp(['Crystal ' num2str(goodPop) ' generated successfully, volume ' num2str(abs(det(lat))) ', composition ' num2str(numIons)]);
end
goodPop = goodPop + 1;
else
failedDist = failedDist + 1;
end
end
if ORG_STRUC.wrong_spacegroups > 0
disp([' ']);
disp(['ATTENTION! In ' num2str(ORG_STRUC.wrong_spacegroups) ' / ' ...
num2str(ORG_STRUC.initialPopSize) ' cases actually generated symmetry was different.']);
disp([' ']);
end
disp(' ');
pick_Seeds();
if ORG_STRUC.doFing
pickAntiSeeds();
end
Start_POP_301();
