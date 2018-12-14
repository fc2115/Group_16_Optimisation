function M = beam_mass_surf(X,rho,B)
% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Mass of beam for a given rho
% -------------------------------------------------------------------------
% Inputs:
% X comprises of: 
% R^2 - r^2         Difference of squares of radii (m^2) 
% a                 Angle of beam (radians)
% 
% rho               Density of material (kg/m^3)
% B                 Height of beam (m)
% Output:
% M                 Mass of beam (kg)
% -------------------------------------------------------------------------

% Parameters 
Rr = X(1);
a = X(2);

% Beam mass 
M = (rho*pi*(Rr)*B)/sin(a);

end 