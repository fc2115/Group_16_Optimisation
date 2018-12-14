function M = beam_mass_fmincon(X,rho,B)
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
% 
% rho               Density of material (kg/m^3)
% B                 Height of beam (m)
% Output:
% M                 Mass of beam (kg)
% -------------------------------------------------------------------------

% Parameters 
R = X(1);
r = X(2);
a = X(3);

% Beam mass 
M = (rho*pi*(R^2 - r^2)*B)/sin(a);

end 