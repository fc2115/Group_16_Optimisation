% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Latin Hypercube sampling for mass model creation
% -------------------------------------------------------------------------
% Generate samples of Number of Teeth and Gear Face width.
% -------------------------------------------------------------------------
clc 
clear all

% Random seed
rng(1)

% Generate random sample indices by latin hypercube sampling
X = lhsdesign(20,2,'iteration',20,'criterion','maximin');

% Range for which each variable lies
X_range = [0, 1];
Face_width = [2.25, 3];
No_teeth = [37, 140]; 

% All Variables scaled to their ranges above. 
% Discrete variables are made integers. 
Face_scaled_width = scaling(X(:,1), Face_width);
No_scaled_teeth = ceil(scaling(X(:,2), No_teeth));

% Sample sorted in increasing order of Face Width.
sam = [No_scaled_teeth Face_scaled_width];
[dd,idd] = sort(sam(:,2));
outsam = [sam(idd,1),sam(idd,2)]

% Write data out to file for simulations.
csvwrite('LHsam_mass.csv',outsam)

% Function used to scale data from 0-1 to new range. 
function scaled_range = scaling(VAL, Var_set);
scaled_range = (VAL*(Var_set(2) - Var_set(1))) + Var_set(1);
end