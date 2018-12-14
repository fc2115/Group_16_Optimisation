% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Latin Hypercube sampling 
% -------------------------------------------------------------------------
% Generate samples of Number of Beams, Number of Teeth, Width of Beams, and
% Gear Face width.
% Extra samples are initially generated, and combinations for which 
% W_beams*No_beams > 58.3*pi are discarded.
% -------------------------------------------------------------------------

clc 
clear all

% Random seed
rng(1)

% Generate random sample indices by latin hypercube sampling
X = lhsdesign(120,4,'iteration',20,'criterion','maximin');

% Range for which each variable lies
X_range = [0, 1];
No_beams = [1.5, 35];
W_beams = [2, 38.143];
Face_width = [2.25, 3];
No_teeth = [37, 140]; 

% All Variables scaled to their ranges above. 
% Discrete variables are made integers. 
No_scaled_beams = ceil(scaling(X(:,1),No_beams));
No_scaled_teeth = ceil(scaling(X(:,4), No_teeth));
W_scaled_beams = scaling(X(:,2), W_beams);
Face_scaled_width = scaling(X(:,3), Face_width);

% Random sample of parameters based on indices determined above 
sam = [No_scaled_beams No_scaled_teeth W_scaled_beams Face_scaled_width];

% Condition to discard samples based on described criteria above.
Prevent_central_rad_expand = sam(:,1).*sam(:,3) < 58.3*pi;
Goodsam = sam(Prevent_central_rad_expand,:);

% Check number of samples ~= 40.
sum_yes = sum(Prevent_central_rad_expand)

% Sample sorted in increasing order of Gear teeth
[dd,idd] = sort(Goodsam(:,2));
outsam = [Goodsam(idd,1),Goodsam(idd,2),Goodsam(idd,3),Goodsam(idd,4)]

% Write data out to file for simulations.
csvwrite('LHsam_new.csv',outsam)

% Function used to scale data from 0-1 to new range. 
function scaled_range = scaling(VAL, Var_set);
scaled_range = (VAL*(Var_set(2) - Var_set(1))) + Var_set(1);
end

%Maybe look at lhs_empir...