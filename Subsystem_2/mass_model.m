% -------------------------------------------------------------------------
% Optimisation project - 13th December 2018
% -------------------------------------------------------------------------
% Mass of the Rear Sprocket Gear
% -------------------------------------------------------------------------
% Inputs:
% X comprises of: 
% Nt                Number of Teeth
% Nb                Number of Beams
% W                 Width of the Beam (mm)
% B                 Gear Sprocket Face Width (mm)
%
% Parameters:
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
% Output:
% Mass_tot          Total Mass of the Sprocket Gear
% -------------------------------------------------------------------------


function Mass_tot = mass_model(X)

% Variables
Nb = X(1);
Nt = X(2);
W = X(3);
B = X(4);

% Parameters
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

% Mass Calculation without beams section metamodel, by normalizing inputs, 
% then unnormalizing output.
Nt_normalized = (Nt - mean_Teeth)/std_Teeth;
B_normalized = (B - mean_B)/std_B;
Mass_no_beams_norm = 1.0109*Nt_normalized + 0.3407*B_normalized;
mass_wo_beams = Mass_no_beams_norm*std_mass + mean_mass;

% Mathematical Formula for Beam Mass
Sprocket_Outerrad = 0.625*pitch - 0.5*Dr + ((pitch/2)/sin(pi/Nt));
Beam_Longside_length = Sprocket_Outerrad - OD_ODi - IR_OR;
mass_beams_tot = (W/1000)*Nb*Beam_Longside_length*(B/1000)*p; % in grams

% Total mass is the sum of these two. 
Mass_tot = mass_wo_beams + mass_beams_tot;

end