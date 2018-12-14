% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% The Efficiency of a Drivetrain based on Frictional Losses between the 
% roller chain pins pand bushes at the 4 articulation points. 
% -------------------------------------------------------------------------
% Inputs:
% X comprises of: 
% C                 Distance between gear centres (m) 
% rd                Radius of the driving gear (m)
% 
% Parameters:
% tau               Motor torque of the Maxon 200W Motor (Nm)
% Pi                Motor power of the Maxon 200W Motor (W)
% w0                Angular Velocity of driving gear (rev/s)
% wd                Angular Velocity of driven gear (rev/s)
% m                 Mass of roller chain per meter (kg/m)
% mp                Coefficient of friction between roller bush and pin
% rb                Radius of bush (m)
% Output:
% eta               1/Efficiency of the system
% -------------------------------------------------------------------------

function eta = trans_eff(X)

% Inputs
C = X(1)
rd = X(2)

% Parameters 
tau = 0.4285;
Pi = 200;
w0 = 6.097;
wd = 17.737;
m = 0.13;
mp = 0.11;
rb = 0.0012;

% Work done at the 4 articulation points
w = (((tau./rd) + m*9.81.*sqrt(C.^2 + (21.*rd./11).^2) + m.*rd.^2.*wd^2)/sqrt(1 + mp^2))*...
    mp*rb*2*360;

% Inverse Efficiency Equation 
eta = Pi./(Pi - w0.*w);

end 