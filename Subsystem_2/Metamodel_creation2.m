% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Build a linear Meta-Model to Assess the Maximum Stress in the Sprocket.
% -------------------------------------------------------------------------
% Fit Linear regression model linking Number of Teeth, Number of Beams,
% Width of Beams, and Sprocket Face Thickness. 
% Check model on validation set, and check goodness of fit. 
% Unfortunately, it was found the relationship is clearly non linear.
% -------------------------------------------------------------------------

%% Data Prep
clc
close all
clear

% Random seed 
rng(9) 

% Read the Data
Data = xlsread('Stress_modelling_data.xlsx','A2:J41');

%Split the Data to variables and outputs
Data_x = Data(:,2:5);
Data_SF = Data(:,8);

%Randomize the datasets
newInd = randperm(length(Data_SF));

Data_x_rand = Data_x(newInd,:);
Data_SF_rand = Data_SF(newInd);

%Normalize Data 
[Data_x_rand_new,PS_Dx] = mapstd(Data_x_rand(:,:)');
[Data_SF_rand_new,PS_DyS] = mapstd(Data_SF_rand(:)');

%Split the Data into test and training sets
splitPt1 = ceil(0.75*length(Data_SF));

Data_x_rand_newTrain = Data_x_rand_new(:,1:splitPt1);
Data_SF_rand_newTrain = Data_SF_rand_new(1:splitPt1);

Data_x_rand_newTest = Data_x_rand_new(:,splitPt1+1:end);
Data_SF_rand_newTest = Data_SF_rand_new(splitPt1+1:end);

%Linear Regression Models
beta_SF_vals = mvregress(Data_x_rand_newTrain',Data_SF_rand_newTrain');

%R2 Values Training Data
Rsq_SF_train = 1 - norm(Data_x_rand_newTrain'*beta_SF_vals - Data_SF_rand_newTrain')^2/norm(Data_SF_rand_newTrain-mean(Data_SF_rand_newTrain))^2

%R2 Values Test Data
Rsq_SF_test = 1 - norm(Data_x_rand_newTest'*beta_SF_vals - Data_SF_rand_newTest')^2/norm(Data_SF_rand_newTest-mean(Data_SF_rand_newTest))^2

%% Visualising the Data Plotting
% Variable Separation for Plotting
Beams = Data_x_rand(:,1);
Teeth = Data_x_rand(:,2);
Beam_width = Data_x_rand(:,3);
Sprocket_width = Data_x_rand(:,4);

Min_SF = Data_SF;

figure()
subplot(2,2,1)
scatter(Beams, Min_SF)
title('beams')

subplot(2,2,2)
scatter(Teeth, Min_SF) 
title('teeth')

subplot(2,2,3)
scatter(Beam_width, Min_SF)
title('beam width')

subplot(2,2,4)
scatter(Sprocket_width, Min_SF)
title('face width')