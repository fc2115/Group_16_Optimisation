% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Parametric optimisation using fmincon  
% -------------------------------------------------------------------------
% Constrained optimisation of the mass of the gear based on Number of
% Teeth, Number of Beams, Width of Gear Beams, Face Width of Sprocket.
% -------------------------------------------------------------------------
clear
clc
tic
% Objective Function Call
FUN = @(X)mass_model(X);

% Parameters = The same parameter as 'mass_model.m'
p = 2700; 
pitch = 6.35; 
Dr = 3.975;
OD_ODi = 10; 
IR_OR = 29.15; 
mean_B = 2.6005;
mean_Teeth = 92.8667;
mean_mass = 40.1514;
std_B = 0.2254;
std_Teeth = 31.6112;
std_mass = 10.0264;

% Nonlinear Constraints Call
NONLCON = @(X)Nonlin_con(X);

% Starting point decided upon intuitively for patternsearch global search. 
% Other points were tested, but this was optimal. 
X0 = [2, 37, 2, 2.25];

% Lower and Upper Bounds
LB = [2; 37; 2; 2.25];
UB = [35; 140; 58.3; 3.27];

% Patternsearch to determine good starting point for fmincon
[Xopt2, min_inveff, E, O] = patternsearch(FUN,X0,[],[],[],[],LB,UB,NONLCON);

% New Starting point
X0 = Xopt2

% Gradient optimisation using fmincon
options = optimset('MaxFunEvals',Inf,'MaxIter',5000,...
        'Algorithm','interior-point','Display','iter', ...
        'PlotFcn', {@optimplotfval});
[Xopt, min_inveff, E, O, ~, Grad, Hess] = fmincon(FUN,X0,[],[],[],[],LB,UB,NONLCON,options);

% Results
Hess
e = eig(Hess)

Xopt(1) = floor(Xopt(1));
Xopt(2) = floor(Xopt(2))

% Grad

%% Calculate Optimized Mass
Nb = Xopt(1);
Nt = Xopt(2);
W = Xopt(3);
B = Xopt(4);

Nt_normalized = (Nt - mean_Teeth)/std_Teeth;
B_normalized = (B - mean_B)/std_B;
Mass_no_beams_norm = 1.0109*Nt_normalized + 0.3407*B_normalized;

mass_wo_beams = Mass_no_beams_norm*std_mass + mean_mass;
Sprocket_Outerrad = 0.625*pitch - 0.5*Dr + ((pitch/2)/sin(pi/Nt));
Beam_Longside_length = Sprocket_Outerrad - OD_ODi - IR_OR;

mass_beams_tot = (W/1000)*Nb*Beam_Longside_length*(B/1000)*p; % in grams

Mass_tot = mass_wo_beams + mass_beams_tot

fprintf('Total time to optimise is ') 
toc
