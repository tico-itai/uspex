function fitness = FitnessRankingCorrection(fitness)
global POP_STRUC
global ORG_STRUC
[nothing, ranking] = sort(fitness);
POP_STRUC.ranking = ranking;
bad_rank = 0;
Step = length(ORG_STRUC.abinitioCode);
[ranking, bad_rank, fitness] = degradeSimilar(ORG_STRUC.toleranceFing, ranking, fitness, Step);
if (ORG_STRUC.softMutOnly(POP_STRUC.generation+1) == 1) && (POP_STRUC.generation > 0)
tolerance = 1/ORG_STRUC.populationSize;
deltaTol = tolerance/2;
decentRank = round(length(POP_STRUC.ranking)*ORG_STRUC.bestFrac);
decentRanking = POP_STRUC.ranking(1:decentRank);
doneOr = 0;
while doneOr == 0
[ranking, bad_rank, fitness] = degradeSimilar(tolerance, decentRanking, fitness, Step);
if (length(ranking) - bad_rank > 0.9*ORG_STRUC.populationSize) && (length(ranking) - bad_rank < 1.1*ORG_STRUC.populationSize)
doneOr = 1;
elseif length(ranking) - bad_rank < 0.9*ORG_STRUC.populationSize
tolerance = tolerance - deltaTol;
else
tolerance = tolerance + deltaTol;
end
deltaTol = deltaTol/2;
if deltaTol < 0.00001
doneOr = 1;
end
end
disp([num2str(length(ranking)-bad_rank) ' structures were chosen with tolerance ' num2str(tolerance) ' to produce the next generation'])
end
POP_STRUC.fitness = fitness;
POP_STRUC.ranking = ranking;
POP_STRUC.bad_rank = bad_rank;
safesave ('Current_POP.mat', POP_STRUC)
