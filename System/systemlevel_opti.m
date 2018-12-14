% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Group Multi Objective System optimisation using gamultiobj
% -------------------------------------------------------------------------
% Constrained multi objectve optimisaing for Inputs C, rd, R, r and alpha, 
% with rd and rho bounded from sub-system level optimisation. 
% -------------------------------------------------------------------------
clear
clc
tic
% Load parameter estimates obtained from polynomial fit of alpha and Force  
betas = load('modelpars.csv');

% Possible values for rho 
rhos = [2700;2810;7800;8027];

% Initialise matrices 
Xopt = zeros(3,4);
min_mass = zeros(4,1);

% Define objective function 
FUN = @(X)multifunction(X,2810,0.11);
YS = 505000000;
E = 7.2*1e10;

% Set lower and upper bounds for parameters.
% Used output of prev multiobj as a constraint. 
LB = [0;0;0; 0.01212; 0.28];
UB = [Inf;Inf;pi/2; 0.01389; 0.367]; 

% Set linear equality constraints 
Aeq = [-1 1 0 0 0];
Beq = -0.001;

% Define non-linear constraints 
NONLCON = @(X)Nonlin_con_fmincon_systemlevel(X,0.11,0.127,betas,YS,E);

% Use gamjultiobj to perform constrained system multi objective optimisation 
options = optimoptions(@gamultiobj,'PopulationSize',120,'PlotFcn',{@gaplotpareto});
[Xopt, Fvals, E, O] = gamultiobj(FUN,5,[],[],...
    Aeq,Beq,LB,UB,NONLCON,options);

% Results
Xopt
Fvals

fprintf('Total time to converge to Optimal Pareto Set is ') 
toc
