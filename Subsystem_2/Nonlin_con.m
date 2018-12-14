% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Non-linear constraints for fmincon 
% -------------------------------------------------------------------------
% Inputs:
% X comprises of: 
% Nt                Number of Teeth
% Nb                Number of Beams
% W                 Width of the Beam (mm)
% B                 Gear Sprocket Face Width (mm)
% 
% ceq               Equality constraints 
% -------------------------------------------------------------------------
function [c,ceq] = Nonlin_con(X);

X1 = X(1); % = Nb
X2 = X(2); % = Nt
X3 = X(3); % = W
X4 = X(4); % = B

% Safety Factor Constraint; SF must be greater than 3
c(1) = -3 + (-0.24622*X1^2 - 0.056349*X1*X2 + 0.84053*X1*X3 + 6.3967*X1*X4 - 5.9137*X1 + 0.0050198*X2^2 - 0.015467*X2*X3 + 0.17436*X2*X4 - 1.5335*X2 - 0.06558*X3^2 + 1.3327*X3*X4 + 0.22759*X3 + 52.5582*X4^2 - 331.7329*X4 + 520.5558);

% The Number and Width of Beams should not result in beam merging
c(2) = X3*X1 - 58.3*pi;

% The maximum width of a beam should not interfere with the gear teeth
c(3) = X3 - 2*(8.93*(6.35*X2/(2*pi)) - 69.3)^0.5;

ceq = [];

end