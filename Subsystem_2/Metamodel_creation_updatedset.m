% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Build a Non linear Meta-Model to Assess the Maximum Stress in the
% Sprocket.
% -------------------------------------------------------------------------
% Fit non-linear regression model linking Number of Teeth, Number of Beams,
% Width of Beams, and Sprocket Face Thickness. 
% Validate model on validation set, and check goodness of fit. 
% -------------------------------------------------------------------------
% The polyfitn and sympoly toolboxes are required to run this script
% -------------------------------------------------------------------------
%% Data Preparation
clc
close all
clear

% Random Number generation Seed
rng(2) 

% Import Simulation Results
Data = xlsread('Stress_modelling_data.xlsx','A2:J41');

%Split the Data to variables and outputs
Data_x = Data(:,2:5);
Data_SF = Data(:,8);

%Randomize the datasets
newInd = randperm(length(Data_SF));

Data_x_rand = Data_x(newInd,:);
Data_SF_rand = Data_SF(newInd);

% Inputs from the Latin Hypercube Sample, and extracting the parameter
% values. 
% Note, that normalisation of these data was not possible due to the nature
% of polyfitn.
Beams = Data_x_rand(:,1)';
Teeth = Data_x_rand(:,2)';
Beam_width = Data_x_rand(:,3)';
Sprocket_width = Data_x_rand(:,4)';
Min_SF = Data_SF_rand';

% Split into test and training using 75:25 split
split_pt = 30;

Beams_train = Beams(1:split_pt)';
Teeth_train = Teeth(1:split_pt)';
Beam_width_train = Beam_width(1:split_pt)';
Sprocket_width_train = Sprocket_width(1:split_pt)';
Min_SF_train = Min_SF(1:split_pt)';

% Test Data
% Note that the final point of the training data was left in the Test Data
% set for easier cross comparison.
Beams_test = Beams(split_pt:end);
Teeth_test = Teeth(split_pt:end);
Beam_width_test = Beam_width(split_pt:end);
Sprocket_width_test = Sprocket_width(split_pt:end);
Min_SF_test = Min_SF(split_pt:end);

%% Creating the Model

% Using the polyfitn function of order 2 to derive a polynomial function
% linking the 4 variables. 
fun = polyfitn([Beams_train, Teeth_train, Beam_width_train, Sprocket_width_train], Min_SF_train,2);
x = polyn2sympoly(fun)

%% Assessing the Model Fit

% Substituting in the test data values to the function, in order to compare
% predicted vs true results.
X1 = Beams_test; X2 = Teeth_test; X3 = Beam_width_test; X4 = Sprocket_width_test; 

% This is the function given by polyn2sympoly, but altered to work for dot
% multiplication.
Metamodel = -0.24622.*X1.^2 - 0.056349.*X1.*X2 + 0.84053.*X1.*X3 + 6.3967.*X1.*X4 - 5.9137.*X1 + 0.0050198.*X2.^2 - 0.015467.*X2.*X3 + 0.17436.*X2.*X4 - 1.5335.*X2 - 0.06558.*X3.^2 + 1.3327.*X3.*X4 + 0.22759.*X3 + 52.5582.*X4.^2 - 331.7329.*X4 + 520.5558;

% Function properties compared with Training Data. Displays R2, Adjusted
% R2, and RMSE. 
fun

% Root Mean Squared Error Calculation against Test Data. 
rmse = sqrt(immse(Min_SF_test, Metamodel))