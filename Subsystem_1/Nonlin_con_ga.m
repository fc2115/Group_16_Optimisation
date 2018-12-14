function [c,ceq] = Nonlin_con_ga(X,B,A,betas)
% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Non-linear constraints for ga 
% -------------------------------------------------------------------------
% Inputs:
% X comprises of: 
% R                 Outer radius of beam (m) 
% r                 Inner radius of beam (m)
% a                 Angle of beam (radians)
% rhoI              Index of density {1,2,3,4}
% 
% B                 Height of beam (m)
% A                 Minimum length of base (m)
% betas             Parameters of fitted model between alpha and Force 
% Output:
% c                 Inequality constraints 
% ceq               Equality constraints 
% -------------------------------------------------------------------------
% Parameters 
R = X(1);
r = X(2);
a = X(3);
rhoI = X(4);

% Yield stress and Young's modulus for various density values 
if rhoI == 1
    YS = 55148500;
    E = 6.9*1e10;
elseif rhoI == 2
    YS = 505000000;
    E = 7.2*1e10;
elseif rhoI == 3
    YS = 220594000;
    E = 2.1*1e11;
elseif rhoI == 4
    YS = 170000000;
    E = 2*1e11;
end 

% Parameters of fitted model between alpha and Force 
b0 = betas(1);
b1 = betas(2);
b2 = betas(3);

% Triangle inequality 
c(1) = 1 - cos(a) - sin(a);
% Lateral movement constraint 
c(2) = A*tan(a) - B;
% Yield stress constraint 
c(3) = (b0 + b1*a + b2*a^2)/(pi*(R^2 - r^2)) - YS/10;
% Buckling constraint 
c(4) = (b0 + b1*a + b2*a^2)/(pi*(R^2 - r^2)) - ...
    pi^2*E*(sin(a))^2*(R^2 - r^2)/(10*B^2);

% Equality constraint
ceq = [];

end 