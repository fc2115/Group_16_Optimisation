% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Build meta-model
% -------------------------------------------------------------------------
% Fit linear regression model linking alpha and Force on training data.
% Validate model on validation set. 
% Assess model fit. 
% -------------------------------------------------------------------------

%% Data prep 
% Set seed for random number generator 
rng(5)

% Import data from simulation 
Tab = readtable('inputs_outputs_regression.xlsx');
Data = table2array(Tab(2:end,:));
% Size of the data 
N = size(Data,1);

% Approximately 75% of data in training set. Generate random indices. 
Ind = ceil(N*rand(0.75*N,1));

% Training data and size of training data 
Dat = Data(Ind,:);
n = size(Dat,1);

% Validation data 
Val = Data;
Val(Ind,:) = [];

% Extracting parameter values from training set 
R = Dat(:,1);
r = Dat(:,2);
alpha = Dat(:,3)*pi/180;
den = Dat(:,4);
stress = Dat(:,5);

% Evaluate force from stress equation
Force = stress.*pi.*(R.^2 - r.^2);

%% Plot to see relationship between force and alpha 
figure 
plot(alpha,Force,'.')
xlabel('\alpha (rad)')
ylabel('Force (N)')
title('\alpha vs Force')


%% Fit polynomial of degree 2
% Number of parameters
p = 3;

% design matrix for a polynomial of degree 2
C1 = [alpha alpha.^2];

% Plot shows that there are some outliers, hence robustfit used 
ahat = robustfit(C1,Force);

% Visualise fit 
aa = linspace(0.2,pi/2,100)';
Ca = [ones(100,1) aa aa.^2];
figure 
plot(alpha,Force,'.')
hold on 
plot(aa,Ca*ahat)
hold off 
xlabel('\alpha (rad)')
ylabel('Force (N)')
legend('data','fit')
title('\alpha vs Force model fit')

%% Assessing model fit using R squared 
% residuals 
C0 = [ones(n,1) alpha alpha.^2];
res = Force - C0*ahat;
% R squared 
ssres = sum(res.^2);
sstot = sum((Force - mean(Force)).^2);
Rsquared = 1 - ssres/sstot;
% Adjusted R squared 
Rsquaredadj = 1 - (1-Rsquared)*((n-1)/(n-p-1)); 

Rsquaredadj

%% Validation 
% Alpha for validation set 
alpha2 = Val(:,3)*pi/180;
C2 = [ones(size(alpha2)) alpha2 alpha2.^2];

% Force for validation set 
Force2 = Val(:,5).*pi.*(Val(:,1).^2 - Val(:,2).^2);

% Error 
rval = Force2 - C2*ahat;
E = norm(rval);

% Plot of fit for validation set 
figure 
plot(alpha2,Force2,'.',alpha2,C2*ahat,'o')
xlabel('\alpha (rad)')
ylabel('Force (N)')
legend('data','fit')
title('\alpha vs Force model fit: validation set')

%% Write parameter estimates as csv file 
csvwrite('modelpars.csv',ahat)
