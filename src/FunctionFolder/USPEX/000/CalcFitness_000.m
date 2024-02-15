function fitness = CalcFitness_000()
global POP_STRUC
global ORG_STRUC
fitness = zeros(1,length(POP_STRUC.POPULATION));
for fit_loop = 1:length(POP_STRUC.POPULATION)
fitness(fit_loop) = POP_STRUC.POPULATION(fit_loop).Enthalpies(end);
end
fitness = ORG_STRUC.opt_sign*fitness; 
for i = 1 : length(fitness)
if POP_STRUC.POPULATION(i).Enthalpies(end) > 99999    
fitness(i) = 100000;
end
end
