function [c,ceq] = Nonlin_con_fmincon_systemlevel(X,B,A,betas,YS,E)
% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Non-linear constraints for system level optimisation.
% -------------------------------------------------------------------------
% Inputs:
% X comprises of: 
% R                 Outer radius of beam (m) 
% r                 Inner radius of beam (m)
% a                 Angle of beam (radians)
% 
% B                 Height of beam (m)
% A                 Minimum length of base (m)
% betas             Parameters of fitted model between alpha and Force 
% YS                Yield stress (Pa)
% E                 Young's modulus (Pa)
% Output:
% c                 Inequality constraints 
% ceq               Equality constraints 
% -------------------------------------------------------------------------

% Parameters 
R = X(1);
r = X(2);
a = X(3);

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