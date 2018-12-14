% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Build Meta-Model of Mass of outer and inner sections of the Gear.
% -------------------------------------------------------------------------
% Fit linear regression model linking Number of Teeth and Face Width. 
% Validate model on validation set. 
% Assess model fit. 
% -------------------------------------------------------------------------

%% Data Prep
clc
close all

% Random Data Seed 1
rng(1)

% Read the Results from the Simulation
Data = xlsread('LHsam_mass.xlsx','A2:J41');

%Split the Data to variables and outputs. Teeth 1st, Width 2nd
Data_x = Data(:,1:2);
Data_Mass_g = Data(:,3);

%Randomize the datasets
newInd = randperm(length(Data_Mass_g));

Data_x_rand = Data_x(newInd,:);
Data_Mass_g_rand = Data_Mass_g(newInd);

%Split the Data into test and training sets
splitPt1 = ceil(0.75*length(Data_Mass_g_rand));

[Data_x_rand_newTrain,PS_DxTrain] = mapstd(Data_x_rand(1:splitPt1,:)');
[Data_Mass_g_rand_newTrain,PS_DyMTrain2] = mapstd(Data_Mass_g_rand(1:splitPt1)');

%Normalize Test Data Sets
Data_x_rand_newTest = mapstd('apply',Data_x_rand(splitPt1+1:end,:)',PS_DxTrain);
Data_Mass_g_rand_newTest = mapstd('apply',Data_Mass_g_rand(splitPt1+1:end)',PS_DyMTrain2);

%% Initial Scatter Visualisation
figure()
scatter3(Data_x_rand_newTrain(1,:), Data_x_rand_newTrain(2,:), Data_Mass_g_rand_newTrain)
xlabel('No. Teeth')
ylabel('Face Width')
zlabel('Mass (g)')

%% Model Creation
%Linear Regression Model
beta_Mass_vals = mvregress(Data_x_rand_newTrain',Data_Mass_g_rand_newTrain');

%% Model Validation
%R2 Values Training Data
Rsq_Mass_train = 1 - norm(Data_x_rand_newTrain'*beta_Mass_vals - Data_Mass_g_rand_newTrain')^2/norm(Data_Mass_g_rand_newTrain-mean(Data_Mass_g_rand_newTrain))^2

%R2 Values Test Data
Rsq_Mass_test = 1 - norm(Data_x_rand_newTest'*beta_Mass_vals - Data_Mass_g_rand_newTest')^2/norm(Data_Mass_g_rand_newTest-mean(Data_Mass_g_rand_newTest))^2

%% Normalised Model Visualisation
figure(2)
[X,Y] = meshgrid(Data_x_rand_newTrain(:,1),Data_x_rand_newTrain(:,2))
Mass_no_beams_norm = beta_Mass_vals(1)*X + beta_Mass_vals(2)*Y
surf(X,Y,Mass_no_beams_norm)
xlabel('No. Teeth')
ylabel('Face Width')
zlabel('Mass')
title('Normalized Mass of partial gear w.r.t No. Teeth and Face Width')
shading interp
colorbar

%% Unpacpking of normalized data
% Calculations of std and mean
std_Teeth = std(Data_x_rand(1:splitPt1,1));
std_B = std(Data_x_rand(1:splitPt1,2));
mean_Teeth = mean(Data_x_rand(1:splitPt1,1));
mean_B = mean(Data_x_rand(1:splitPt1,2));
std_mass = std(Data_Mass_g_rand(1:splitPt1));
mean_mass = mean(Data_Mass_g_rand(1:splitPt1));

% Obtaining data values to sanity check a single solution
Nt = Data_x(1,1);
B = Data_x(1,2);

% Unpacking normalised data
Nt_normalized = (Nt - mean_Teeth)/std_Teeth
B_normalized = (B - mean_B)/std_B
Mass_no_beams_norm = beta_Mass_vals(1)*Nt_normalized + beta_Mass_vals(2)*B_normalized

% Actual Mass Value
Data_Mass_g(1)

% Predicted Mass Value
Mass_no_beams = Mass_no_beams_norm*std_mass + mean_mass