% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% The multiobjective equation set for optimisation of the 2 systems:
% Efficiency of the Drivetrain and Mass of the Sprocket Gear
% -------------------------------------------------------------------------
% Inputs:
% X comprises of: 
% C                 Distance between gear centres (m) 
% rd                Radius of the driving gear (m)
% R                 Outer radius of beam (m) 
% r                 Inner radius of beam (m)
% a                 Angle of beam (radians)
% 
% Parameters:
% tau               Motor torque of the Maxon 200W Motor (Nm)
% Pi                Motor power of the Maxon 200W Motor (W)
% w0                Angular Velocity of driving gear (rev/s)
% wd                Angular Velocity of driven gear (rev/s)
% m                 Mass of roller chain per meter (kg/m)
% mp                Coefficient of friction between roller bush and pin
% rb                Radius of bush (m)
% rho               Density of material (kg/m^3)
% B                 Height of beam (m)
% 
% Output:
% weighted_multiobj_kesh(1)   1/Efficiency of the system
% weighted_multiobj_kesh(2)   Mass of beam (kg)    
% -------------------------------------------------------------------------

function weighted_multiobj_kesh = multifunction(X,rho,B);

% Variables 
R = X(1);
r = X(2);
a = X(3);
rd = X(4);
C = X(5);

% Parameters for Chain
tau = 0.4285;
Pi = 200;
w0 = 6.097;
wd = 17.737;
m = 0.13;
mp = 0.11;
rb = 0.0012;

% Function for Chain Efficiency
w = (((tau/rd) + m*9.81*sqrt(C^2 + (21*rd/11)^2) + m*rd^2*wd^2)/sqrt(1 + mp^2))*mp*rb*360;
efficiency = Pi/(Pi - w0*w);

% Weighted Objective Function for 1/efficiency
weighted_multiobj_kesh(1) = efficiency;

% Beam mass 
weighted_multiobj_kesh(2) = (rho*pi*(R^2 - r^2)*B)/sin(a);


end