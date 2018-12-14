% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Multi Objective optimisation using gamultiobj
% -------------------------------------------------------------------------
% Constrained multi objectve optimisaing for Inputs Nb, Nt, W, B and C.
% -------------------------------------------------------------------------
clear
clc
tic
% Multi Objective function call
FUN = @(X)felix_multifunction(X);

% Linear Constrraints
A = [0 6.35*11/(2000*pi*32) 0 0 -1;];
B = [-0.254];

% Non Linear contraints call
NONLCON = @(X)Nonlin_con(X);

% Lower and Upper Bounds
LB = [2; 37; 2; 2.25; 0.28];
UB = [35; 140; 58.3; 3.27; 0.367];

% Multi Objective optimisation with gamultiobj. 
% Objective 1 is Mass,
% Objective 2 is 1/Efficiency. 
% Sometimes the Genetic Algorithm does not find the global minimum mass 
% around 17, thus Population Size was increased. However, it can still 
% fail to do so on rare occasions, so continue to re run the script until 
% solutions around 17 grams around are obtained.
options = optimoptions(@gamultiobj,'PopulationSize',120,'PlotFcn',{@gaplotpareto});
[Xopt, FVAL, Exitflat, Output] = gamultiobj(FUN,5,A,B,[],[],LB,UB,NONLCON,options);

% Results
Xopt(:,1) = floor(Xopt(:,1));
Xopt(:,2) = floor(Xopt(:,2))
FVAL
fprintf('Total time to converge to Optimal Pareto Set is ') 
toc