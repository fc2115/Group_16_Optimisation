% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Parametric optimisation using fmincon  
% -------------------------------------------------------------------------
% Constrained optimisation of Drivetrain Efficiency for inputs C and rd
% -------------------------------------------------------------------------

clear
clc
tic

rng(1)

% Objective Function Call
FUN = @(X)trans_eff(X);

% Starting Point for Pattern Search
X0 = [0.35;0.05];

% Linear Constraints
A = [-1 1;];
B = [-0.254];

% Lower and Upper bounds for C and rd respectively
LB = [0.28; 0.0122];
UB = [0.367; 0.05];

% Patternsearch to determine good starting point for fmincon
[Xopt2, min_inveff, E, O] = patternsearch(FUN,X0,A,B,[],[],LB,UB);

% New Starting point
X0 = Xopt2

% Gradient optimisation using fmincon
options = optimset('MaxFunEvals',Inf,'MaxIter',5000,...
        'Algorithm','interior-point','Display','iter', ...
        'PlotFcn', {@optimplotfval});
[Xopt, min_inveff, E, O, ~, Grad, Hess] = fmincon(FUN,X0,A,B,[],[],LB,UB,[],options);

%Optimisation Results
Xopt
Grad

% Check eigenvalues of the Hessian are > 0, ensuring minimum point 
eigen = eig(Hess)
fprintf('Total time to optimise is ') 
toc