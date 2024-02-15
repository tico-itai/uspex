function fitness = CalcFitness_301()
global POP_STRUC
global ORG_STRUC
fitness = zeros(1,length(POP_STRUC.POPULATION));
if ORG_STRUC.optType == 1 
if size(ORG_STRUC.numIons,1)==1         
POP_STRUC.convex_hull = [];
for fit_loop = 1:length(POP_STRUC.POPULATION)
fitness(fit_loop) = POP_STRUC.POPULATION(fit_loop).Enthalpies(end)/sum(POP_STRUC.POPULATION(fit_loop).numBlocks);
end
else
[fitness,POP_STRUC.convex_hull] = update_convex_hull(ORG_STRUC.numIons);
end
else
for i = 1:length(POP_STRUC.POPULATION)
if POP_STRUC.POPULATION(i).Enthalpies(end) < 9999
if ORG_STRUC.optType == 2 
fitness(i) = det(POP_STRUC.POPULATION(i).LATTICE)/sum(POP_STRUC.POPULATION(i).numIons);
elseif ORG_STRUC.optType == 3 
fitness(i) = -1*POP_STRUC.POPULATION(i).hardness;
elseif ORG_STRUC.optType == 4 
fitness(i) = -1*POP_STRUC.POPULATION(i).S_order;
elseif ORG_STRUC.optType == 6 
fitness(i) = -1*sum(POP_STRUC.POPULATION(i).dielectric_tensor(1:3))/3;
elseif ORG_STRUC.optType == 7 
fitness(i) = -1*POP_STRUC.POPULATION(i).gap;
elseif ORG_STRUC.optType == 8 
Egc = 4; 
if POP_STRUC.POPULATION(i).gap >= Egc
fitness(i) = -1*(sum(POP_STRUC.POPULATION(i).dielectric_tensor(1:3))/3)*(POP_STRUC.POPULATION(i).gap/Egc)^2; 
else
fitness(i) = -1*(sum(POP_STRUC.POPULATION(i).dielectric_tensor(1:3))/3)*(POP_STRUC.POPULATION(i).gap/Egc)^6; 
end
elseif ORG_STRUC.optType == 9
fitness(i) = -1*POP_STRUC.POPULATION(i).mag_moment;
elseif ORG_STRUC.optType == 10 
fitness(i) = -1*POP_STRUC.POPULATION(i).struc_entr;
elseif (ORG_STRUC.optType > 1100) & (ORG_STRUC.optType < 1112)
whichPara= mod(ORG_STRUC.optType,110);
for i = 1 : length(POP_STRUC.POPULATION)
if isempty(POP_STRUC.POPULATION(i).elasticProperties) | (POP_STRUC.POPULATION(i).elasticProperties(end)==0)
fitness(i)=NaN;
else
fitness(i) = -1*POP_STRUC.POPULATION(i).elasticProperties(whichPara);
end
end
end            
end
end
end
if ORG_STRUC.optType == 5 
for i = 1 : length(POP_STRUC.POPULATION)-1
for j = i+1 : length(POP_STRUC.POPULATION)
dist_ij = cosineDistance(POP_STRUC.POPULATION(i).FINGERPRINT, POP_STRUC.POPULATION(j).FINGERPRINT, ORG_STRUC.weight);
fitness(i) = fitness(i) + dist_ij^2;
fitness(j) = fitness(j) + dist_ij^2;
end
end
fitness = -sqrt(fitness);
end
if ORG_STRUC.optType == 14 
for fit_loop = 1 : length(POP_STRUC.POPULATION)
fitness(fit_loop) = -1*POP_STRUC.POPULATION(fit_loop).powerfactor;
end
end
fitness = ORG_STRUC.opt_sign*fitness; 
for i = 1 : length(fitness)
if POP_STRUC.POPULATION(i).Enthalpies(end) > 99999    
fitness(i) = 100000;
end
end
