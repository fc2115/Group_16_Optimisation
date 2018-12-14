% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Parametric optimisation using fmincon  
% -------------------------------------------------------------------------
% Constrained obtimisation of beam mass for parameters R, r and alpha for
% each rho. 
% -------------------------------------------------------------------------

% Load parameter estimates obtained from polynomial fit of alpha and Force  
betas = load('modelpars.csv');

% Possible values for rho 
rhos = [2700;2810;7800;8027];

% Initialise matrices 
Xopt = zeros(3,4);
min_mass = zeros(4,1);
Iposdef = zeros(4,1);

% For each rho.... 
for i = 1:4

rho = rhos(i);

% Determine the yield stress and Young's modulus for each rho 
if rho == 2700
    YS = 55148500;
    E = 6.9*1e10;
elseif rho == 2810
    YS = 505000000;
    E = 7.2*1e10;
elseif rho == 7800
    YS = 220594000;
    E = 2.1*1e11;
elseif rho == 8027
    YS = 170000000;
    E = 2*1e11;
else 
    fprintf('Rho not in solution set')
end 

% Define objective function 
FUN = @(X)beam_mass_fmincon(X,rho,0.11);

% Set starting point for optimisation 
X0 = [0.01;0.009;29*pi/180];

% Set lower and upper bounds for parameters 
LB = [0;0;0];
UB = [Inf;Inf;pi/2];

% Set linear equality constraints 
Aeq = [-1 1 0];
Beq = -0.001;

% Define non-linear constraints 
NONLCON = @(X)Nonlin_con_fmincon(X,0.11,0.127,betas,YS,E);

% Use fmincon to perform constrained optimisation 
opts = optimoptions('fmincon','MaxFunctionEvaluations',...
    50000,'MaxIterations',10000);
[Xopt(:,i), min_mass(i), E, O, ~, Grad, Hess] = fmincon(FUN,X0,[],[],...
    Aeq,Beq,LB,UB,NONLCON,opts);

% Is Hessian positive definite? 
Iposdef(i) = all(eig(Hess) > 0);


end 

Xopt(:,2)
min_mass(2)

%% Generate surface plot at rho = 2810
% Set density 
rho = 2810;

% Create a mesh of equally spaced R^2 - r^2 values 
Rr = linspace(0,0.02,100);

% Create a mesh of equally spaced alpha values 
Aa = linspace(0.2,pi/2,100);

% Evaluate mass for every combination of Rr and Aa
M = zeros(100,100);
for i = 1:100
    for j = 1:100
        M(i,j) = beam_mass_surf([Rr(i);Aa(j)],rho,0.11);
    end 
end 

% Create meshgrid of Rr and Aa values 
[RR,AA] = meshgrid(Rr,Aa);

% Generate contour plot 
figure 
contourf(RR,AA,M)
xlabel('R^2 - r^2 (m)')
ylabel('\alpha (rad)')
title('Surface plot of mass showing it is convex in the range')
c = colorbar;
ylabel(c,'Mass (kg)')
