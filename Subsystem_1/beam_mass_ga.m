function M = beam_mass_ga(X,B)
% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Mass of beam for a given rho
% -------------------------------------------------------------------------
% Inputs:
% X comprises of: 
% R                 Outer radius of beam (m) 
% r                 Inner radius of beam (m)
% a                 Angle of beam (radians)
% rho               Density of material (kg/m^3)
% 
% B                 Height of beam (m)
% Output:
% M                 Mass of beam (kg)
% -------------------------------------------------------------------------

% Parameters 
R = X(1);
r = X(2);
a = X(3);
rhoI = X(4);

% Rho for associated index 
if rhoI == 1
    rho = 2700;
elseif rhoI == 2
    rho = 2810;
elseif rhoI == 3
    rho = 7800;
elseif rhoI == 4
    rho = 8027;
end 

% Beam mass 
M = (rho*pi*(R^2 - r^2)*B)/sin(a);


end 