function VCNEB()
global ORG_STRUC
global POP_STRUC
%disp('STATE THE ACTUAL VCNEB CALCULATION ...')
while (POP_STRUC.step < ORG_STRUC.numSteps + 0.5)
%disp('Start the algorith here!')
POP_STRUC.current_dir = [POP_STRUC.resFolder '/STEP/step' num2str(POP_STRUC.step)];
cd (ORG_STRUC.homePath)
if ~exist(POP_STRUC.current_dir) & ( 0==mod(POP_STRUC.step, ORG_STRUC.PrintStep) | (POP_STRUC.step==ORG_STRUC.numSteps))
mkdir(POP_STRUC.current_dir);
end
while 1 
ReadJobs_NEB();
SubmitJobs_NEB();
if (ORG_STRUC.platform > 0) | (ORG_STRUC.numParallelCalcs > 1)
if sum([POP_STRUC.POPULATION(:).Done])~= length(POP_STRUC.POPULATION)
[nothing, nothing] = unix('rm still_running');
quit
else
break;
end
else
if sum([POP_STRUC.POPULATION(:).Done]) == length(POP_STRUC.POPULATION)
break; 
end
end
end   
if POP_STRUC.step==0
disp(['VCNEB Calculation initial Step finished .......']);
else
disp(['VCNEB Calculation Step ' num2str(POP_STRUC.step) ' finished .......']);
end
POP_STRUC.genDone = 1;
if  0==mod(POP_STRUC.step, ORG_STRUC.PrintStep) | (POP_STRUC.step==ORG_STRUC.numSteps)
safesave ([POP_STRUC.current_dir '/POP_STRUC.mat'], POP_STRUC)
safesave ([POP_STRUC.current_dir '/ORG_STRUC.mat'], ORG_STRUC)
end
NEB_updateImage();
NEB_pathLength();
NEB_calcCartTuo();
NEB_calcSpringK();
NEB_vcnebForce();
NEB_calcError();
NEB_QMIN();
NEB_freezing();
NEB_writeFiles();
NEB_updateUSPEXFile();
if (sum([POP_STRUC.POPULATION(1:end).freezing])==ORG_STRUC.numImages) | stopVCNEBcode()
disp(' THE VCNEB JOB finished !');
[nothing, nothing] = unix(['echo done > DONE_VCNEB']);
[nothing, nothing] = unix(['rm  still_running']);
NEB_Done();
exit;
end
NEB_generateNewImage();
cd (ORG_STRUC.homePath)
NEB_update_STUFF( ORG_STRUC.inputFile );
safesave ('Current_ORG.mat', ORG_STRUC)
safesave ('Current_POP.mat', POP_STRUC)
end
function isStop = stopVCNEBcode()
global ORG_STRUC
global POP_STRUC
isStop   = 1;
thread   = ORG_STRUC.ConvThreshold;
numImages= ORG_STRUC.numImages;
for i = 1:numImages
if (POP_STRUC.POPULATION(i).errcFnebRms > thread) | (POP_STRUC.POPULATION(i).erraFnebRms > thread) 
isStop = 0;
return;
end
end 
