% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Optimisation using Genetic algorithm  
% -------------------------------------------------------------------------
% Constrained optimisation of beam mass for parameters R, r and alpha and
% rho. Genetic algorithm allows for integer constraints  
% -------------------------------------------------------------------------

% Load parameter estimates obtained from polynomial fit of alpha and Force  
betas = load('modelpars.csv');

% Define objective function 
FUN = @(X)beam_mass_ga(X,0.11);

% Set lower and upper bounds for parameters  
LB = [0;0;0;1];
UB = [0.05;0.05;pi/2;4];

% Set inequality constraint for R - r 
A = [-1 1 0 0];
B = -0.001;

% Non-linear constraints 
NONLCON = @(X)Nonlin_con_ga(X,0.11,0.127,betas);

% Optimise using Genetic algorithm 
Xopt = ga(FUN,4,A,B,[],[],LB,UB,NONLCON,4);

Xopt
FUN(Xopt)