function [numIons, offspring,potentialLattice,fracFrac,dimension,offset] = heredity_final_surface_200(par_one,par_two,cell)
global POP_STRUC
global ORG_STRUC
ordering_on = ORG_STRUC.ordering;
lat1 = POP_STRUC.POPULATION(par_one).Surface_LATTICE;
coor1= POP_STRUC.POPULATION(par_one).Surface_COORDINATES;
typesAList1 = POP_STRUC.POPULATION(par_one).Surface_typesAList;
order1 = POP_STRUC.POPULATION(par_one).Surface_order;
cell1 = POP_STRUC.POPULATION(par_one).cell;
lat2 = POP_STRUC.POPULATION(par_two).Surface_LATTICE;
coor2= POP_STRUC.POPULATION(par_two).Surface_COORDINATES;
typesAList2 = POP_STRUC.POPULATION(par_two).Surface_typesAList;
order2 = POP_STRUC.POPULATION(par_two).Surface_order;
cell2 = POP_STRUC.POPULATION(par_two).cell;
[lat1, parent1, atype1, par_order1, par_numIons1]=cresupercell(lat1, coor1, typesAList1, order1, cell1, cell);
[lat2, parent2, atype2, par_order2, par_numIons2]=cresupercell(lat2, coor2, typesAList2, order2, cell2, cell);
fracFrac = 0.25 +rand(1)/2;
if size(parent1,1)<2 & size(parent2,1)<2
fracFrac=1;
offset=0.0;
dimension=3;
offspring=zeros(0,3);
offspring=cat(1,parent1,parent2); 
numIons=par_numIons1+par_numIons2;
else
dimension = RandInt(1,1,[1,2]);
end
correlation_coefficient = ORG_STRUC.correlation_coefficient;
cor_dir = ORG_STRUC.cor_dir;
if dimension == 1
L1 = abs(det(lat1)/norm(cross(lat1(2,:),lat1(3,:))));
L2 = abs(det(lat2)/norm(cross(lat2(2,:),lat2(3,:))));
else
L1 = abs(det(lat1)/norm(cross(lat1(1,:),lat1(3,:))));
L2 = abs(det(lat2)/norm(cross(lat2(1,:),lat2(3,:))));
end
Lchar1 = 0.5*power(abs(det(lat1))/sum(par_numIons1), 1/3); 
Lchar2 = 0.5*power(abs(det(lat2))/sum(par_numIons2), 1/3);
Nslabs1 = round(L1/(Lchar1+(L1-Lchar1)*(cos(correlation_coefficient*pi/2))^2));
Nslabs2 = round(L2/(Lchar2+(L2-Lchar2)*(cos(correlation_coefficient*pi/2))^2));
if rand(1)>ORG_STRUC.percSliceShift
offset = rand(2,1);
parent1(:,dimension)= parent1(:,dimension)+offset(1,1);
parent2(:,dimension)= parent2(:,dimension)+offset(2,1);
parent1(:,dimension) = parent1(:,dimension) - floor(parent1(:,dimension));
parent2(:,dimension) = parent2(:,dimension) - floor(parent2(:,dimension));
else
offset = rand(6,1);
parent1(:,1)= parent1(:,1)+offset(1,1);
parent1(:,2)= parent1(:,2)+offset(2,1);
parent1(:,3)= parent1(:,3)+offset(3,1);
parent2(:,1)= parent2(:,1)+offset(4,1);
parent2(:,2)= parent2(:,2)+offset(5,1);
parent2(:,3)= parent2(:,3)+offset(6,1);
parent1 = parent1 - floor(parent1);
parent2 = parent2 - floor(parent2);
end
whichIons1 = find(parent1(:,dimension)<fracFrac);
whichIons2 = find(parent2(:,dimension)>fracFrac);
if ordering_on
if length(whichIons1) > 0
ord1 = sum(par_order1(whichIons1))/length(whichIons1);
elseif cor_dir <= 0
ord1 = 0;
else
ord1 = 1;
end
if length(whichIons2) > 0
ord2 = sum(par_order2(whichIons2))/length(whichIons2);
elseif cor_dir <= 0
ord2 = 0;
else
ord2 = 1;
end
for i = 1 : Nslabs1
offset_extra = rand;
parent1(:,dimension) = parent1(:,dimension) + offset_extra;
parent1(:,dimension) = parent1(:,dimension) - floor(parent1(:,dimension));
whichIons1_extra = find(parent1(:,dimension)<fracFrac);
if length(whichIons1_extra) > 0
ord1_extra = sum(par_order1(whichIons1_extra))/length(whichIons1_extra);
elseif cor_dir <= 0
ord1_extra = 0;
else
ord1_extra = 1;
end
if ((ord1 > ord1_extra) & (cor_dir <= 0)) | ((ord1 < ord1_extra) & (cor_dir == 1))
parent1(:,dimension) = parent1(:,dimension) - offset_extra;
parent1(:,dimension) = parent1(:,dimension) - floor(parent1(:,dimension));
else
whichIons1 = whichIons1_extra;
ord1 = ord1_extra;
end
end
for i = 1 : Nslabs2
offset_extra = rand;
parent2(:,dimension) = parent2(:,dimension) + offset_extra;
parent2(:,dimension) = parent2(:,dimension) - floor(parent2(:,dimension));
whichIons2_extra = find(parent2(:,dimension)>fracFrac);
if length(whichIons2_extra) > 0
ord2_extra = sum(par_order2(whichIons2_extra))/length(whichIons2_extra);
elseif cor_dir <= 0
ord2_extra = 0;
else
ord2_extra = 1;
end
if ((ord2 > ord2_extra) & (cor_dir <= 0)) | ((ord2 < ord2_extra) & (cor_dir == 1))
parent2(:,dimension) = parent2(:,dimension) - offset_extra;
parent2(:,dimension) = parent2(:,dimension) - floor(parent2(:,dimension));
else
whichIons2 = whichIons2_extra;
ord2 = ord2_extra;
end
end
end
offspring = zeros(0,3);
ionCount = zeros(length(ORG_STRUC.atomType),1);
for ind=1:length(par_numIons1)
ionChange1(ind)=sum(par_numIons1(1:ind));
end
ionCh1= zeros (1,length(ionChange1)+1);
ionCh1(2:end) = ionChange1;
for ind = 1:length(par_numIons2)
ionChange2(ind) = sum(par_numIons2(1:ind));
end
ionCh2 = zeros (1,length(ionChange2)+1);
ionCh2(2:end) = ionChange2;
for ind = 1:length(ORG_STRUC.atomType)
if ORG_STRUC.numIons(ind)~=0
candidates = [];
smaller1 = find(whichIons1<=ionCh1(ind+1));
smaller2 = find(whichIons2<=ionCh2(ind+1));
ions1  = find(whichIons1(smaller1)>ionCh1(ind));
ions2  = find(whichIons2(smaller2)>ionCh2(ind));
ionCount(ind,1) = length(ions1) + length(ions2);
numatom = ORG_STRUC.numIons(ind)*cell(1)*cell(2);
if ionCount(ind,1) > numatom
howmany = ionCount(ind,1) - numatom;
deleteIons_1 = length(find(rand(howmany,1)<fracFrac));
deleteIons_2 = howmany - deleteIons_1;
if length(ions1) < deleteIons_1
oops = length(ions1) - deleteIons_1;
deleteIons_1 = length(ions1);
deleteIons_2 = deleteIons_2-oops;
elseif length(ions2) < deleteIons_2
oops = length(ions2) - deleteIons_2;
deleteIons_2 = length(ions2);
deleteIons_1 = deleteIons_1-oops;
end
if ordering_on
if isempty(ions1)
ions1 = [];
else
atoms = sort_order_surface(par_order1, ions1, 'ascend');
ions1(atoms(1:deleteIons_1)) = [];
end
if isempty(ions2)
ions2 = [];
else
atoms = sort_order_surface(par_order2, ions2, 'ascend');
ions2(atoms(1:deleteIons_2)) = [];
end
else 
for xy = 1:deleteIons_1
ions1(RandInt(1,1,[1,length(ions1)])) = [];
end
for xy = 1:deleteIons_2
ions2(RandInt(1,1,[1,length(ions2)])) = [];
end
end
ionCount(ind,1)=numatom;
%            disp(['too many atoms: delete']);
elseif ionCount(ind,1) < numatom
%       disp(['not enough atoms: add']);
howmany = numatom - ionCount(ind,1);
suppleIons_1 = length(find(rand(howmany,1)<fracFrac));
suppleIons_2 = howmany-suppleIons_1;
tempInd = find(parent2(ionCh2(ind)+1:ionCh2(ind+1),dimension)<fracFrac);
if length(tempInd)==0
suppleIons_1 = 0;
suppleIons_2 = howmany;
end
if suppleIons_1 > 0
tempInd = find(parent2(ionCh2(ind)+1:ionCh2(ind+1),dimension)<fracFrac);
if isempty(tempInd)
disp('');
parent2
end
if ordering_on
atoms = sort_order_surface(par_order2, tempInd, 'descend');
candidates = parent2(ionCh2(ind) + tempInd(atoms(1:suppleIons_1)) , :);
else
crutch = rand(length(tempInd),1);
[junk, newOrder] = sort(crutch);
candidates = parent2(ionCh2(ind) + tempInd(newOrder(1:suppleIons_1)) , :);
end
end
if suppleIons_2 > 0
tempInd = find(parent1(ionCh1(ind)+1:ionCh1(ind+1),dimension)>fracFrac);
if isempty(tempInd)
disp('');
parent1
end
if ordering_on
atoms = sort_order_surface(par_order1, tempInd, 'descend');
candidates = cat(1,candidates,parent1(ionCh1(ind) + tempInd(atoms(1:suppleIons_2)) , :));
else
crutch = rand(length(tempInd),1);
[junk, newOrder] = sort(crutch);
candidates = cat(1,candidates,parent1(ionCh1(ind)+ tempInd(newOrder(1:suppleIons_2)) , :));
end
end
end
addOn = cat(1,parent1(whichIons1(smaller1(ions1(:))) , :), parent2(whichIons2(smaller2(ions2(:))) , :));
addOn = cat(1,addOn,candidates);
offspring = cat(1,offspring,addOn);
end
end
numIons = ORG_STRUC.numIons*cell(1)*cell(2); 
[Lattice,coor,atyp,ntyp]=supercell(ORG_STRUC.bulk_lat,ORG_STRUC.bulk_pos, ORG_STRUC.bulk_atyp, ORG_STRUC.bulk_ntyp ,cell);
Lat = latConverter(Lattice);
Lat(3) = ORG_STRUC.thicknessS;
potentialLattice=latConverter(Lat);
