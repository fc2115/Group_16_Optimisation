% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% The multiobjective equation set for optimisation of the 2 systems:
% Efficiency of the Drivetrain and Mass of the Sprocket Gear
% -------------------------------------------------------------------------
% Inputs:
% X comprises of: 
% C                 Distance between gear centres (m) 
% rd                Radius of the driving gear (m)
% Nt                Number of Teeth
% Nb                Number of Beams
% W                 Width of the Beam (mm)
% B                 Gear Sprocket Face Width (mm)
% 
% Parameters:
% tau               Motor torque of the Maxon 200W Motor (Nm)
% Pi                Motor power of the Maxon 200W Motor (W)
% w0                Angular Velocity of driving gear (rev/s)
% wd                Angular Velocity of driven gear (rev/s)
% m                 Mass of roller chain per meter (kg/m)
% mp                Coefficient of friction between roller bush and pin
% rb                Radius of bush (m)
% p                 Density of Aluminium Alloy in kg/m^3
% pitch             Pitch of chain in mm
% Dr                Dedendum Radius in mm
% OD_ODi            Distance from sprocket OD to next internal surface in mm.
% IR_OR             Outer radius of inner sprocket ring in mm. 
% mean_B            Mean of Face Width Values in Training Set Data Values
%                   acquired from 'Metamodel_creation_mass.m'
% mean_Teeth        Mean of Number of Teeth in Training Set Data Values
%                   acquired from 'Metamodel_creation_mass.m'
% mean_mass         Mean of mass in Training Set Data Values acquired
%                   from 'Metamodel_creation_mass.m'
% std_B             Standard Deviation of Face Width Values in Training 
%                   Set Data Values acquired from 
%                   'Metamodel_creation_mass.m' 
% std_Teeth         Standard Deviation of Number of Teeth in Training 
%                   Set Data Values acquired from 
%                   'Metamodel_creation_mass.m' 
% std_mass          Standard Deviation of Mass in Training Set Data Values
%                   acquired from 'Metamodel_creation_mass.m' 
% 
% Output:
% weighted_multi_obj(1)       Total Mass of the Sprocket Gear 
% weighted_multi_obj(2)       1/Efficiency of the system
% -------------------------------------------------------------------------
function weighted_multi_obj = felix_multifunction(X);

% Inputs
Nb = X(1);
Nt = X(2);
W = X(3);
B = X(4);
C = X(5);
rd = 6.35*Nt*11/(2000*pi*32);

% Parameters for Gear
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

% Parameters for Chain
tau = 0.4285;
Pi = 200;
w0 = 6.097;
wd = 17.737;
m = 0.13;
mp = 0.11;
rb = 0.0012;

% Function for Gear
Nt_normalized = (Nt - mean_Teeth)/std_Teeth;
B_normalized = (B - mean_B)/std_B;
Mass_no_beams_norm = 1.0109*Nt_normalized + 0.3407*B_normalized;
mass_wo_beams = Mass_no_beams_norm*std_mass + mean_mass;
Sprocket_Outerrad = 0.625*pitch - 0.5*Dr + ((pitch/2)/sin(pi/Nt));
Beam_Longside_length = Sprocket_Outerrad - OD_ODi - IR_OR;
mass_beams_tot = (W/1000)*Nb*Beam_Longside_length*(B/1000)*p; % in grams

% Total mass is the sum of these two. 
Mass_tot = mass_wo_beams + mass_beams_tot;

% Function for Chain
w = (((tau/rd) + m*9.81*sqrt(C^2 + (21*rd/11)^2) + m*rd^2*wd^2)/sqrt(1 + mp^2))*mp*rb*360/Nt;
efficiency = Pi/(Pi - Nt*w0*w);

% Weighted Objective Function
weighted_multi_obj(1) = Mass_tot; 
weighted_multi_obj(2) = efficiency;

end