% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Latin Hypercube sampling 
% -------------------------------------------------------------------------
% Generate samples of R, r, alpha and rho. 
% We generate extra samples to begin with and discard combinations for
% which R < r. 
% -------------------------------------------------------------------------

% Generate random sample indices by latin hypercube sampling
X = lhsdesign(85,4,'iteration',20,'criterion','maximin');
% Mesh of 1000 points for continuous variables, hence index goes from 1 to
% 1000
X123 = ceil(X(:,1:3)*1000);
% 4 values for rho, hence index goes from 1 to 4
X4 = ceil(X(:,4)*4);

% Equally spaced mesh of continuous variables. Length = 1000
R = linspace(0,20,1000)';
r = linspace(0,20,1000)';
alpha = linspace(0,pi/2,1000)';
% Density values of materials 
den = [2700;2810;7800;8027];

% Random sample of parameters based on indices determined above 
sam = [R(X123(:,1)) r(X123(:,2)) alpha(X123(:,3)) den(X4)];

% Index of points for which R > r
IndRr = sam(:,1) > sam(:,2);

% Sample that satisfies R > r
Feas_sam = sam(IndRr,:);

% Sample sorted in increasing order of rho (to simplify running
% simulations)
[dd,idd] = sort(Feas_sam(:,end));
out_sam = [Feas_sam(idd,1),Feas_sam(idd,2),Feas_sam(idd,3),dd];

% Write CSV file 
csvwrite('LHsam.csv',out_sam)
