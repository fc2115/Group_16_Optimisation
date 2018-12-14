There are 2 extra matlab toolboxes required to run Metamodel_creation_Stress.m  
They can be found here:  
https://uk.mathworks.com/matlabcentral/fileexchange/30391-symbolic-polynomials?focused=5194768&tab=function  
https://uk.mathworks.com/matlabcentral/fileexchange/34765-polyfitn  
## Folder Structure
#### CHAIN SPROKET modified.SLDPRT
The Solidworks file used for FEA modelling of Gear Sprocket mass.
#### Effiency_optimisation.m
Script to run optimisation of drivetrain efficiency. Calls trans_eff.m.
#### felix_multifunction.m
Function file containing objective functions for multi objective optimisation of subsystem 2. Parameters are C, Rd, Nt, Nd, W, B. 
#### Initial_Mass_Model_Scatter.fig
Initial scatter plot of mass values in gear outer sections to assess model type. 
#### Latin_sample_mass.m
Generates latin hypercube random sample of Nt and B values. Saves file to LHsam_mass.csv. The results were then found from CHAIN SPROKET modified.SLDPRT and saved to LHsam_mass.xlsx
#### Latin_sample_Stress.m
Generates latin hypercube random sample of Nt, Nd, W, and B values. Saves file to LHsam2.csv. The results were then found from CHAIN SPROKET modified.SLDPRT and saved to Stress_modelling_data.xlsx
#### LHsam_mass.xlsx
The data file containing mass results from the Latin_sample_mass.m inputs to CHAIN SPROKET modified.SLDPRT.
#### mass_model.m
Function file containing objective functions the mass of the gear sprocket. Parameters are Nt, Nd, W, B. 
#### Mass_model_visual.fig
Visualisation of Metamodel_creation_mass.m
#### Mass_optimisation.m
Script to run optimisation of Rear Gear Sprocket Mass. Calls mass_model.m and Nonlin_con.m
#### Metamodel_creation_mass.m
Reads data file LHsam_mass.xlsx. Fits linear regression model to Nt and B.
#### Metamodel_creation_Stress.m
Reads data file Stress_modelling_data.xlsx. Fits nonlinear regression model to Nt, Nd, W, B.  
#### Metamodel_creation_Stress_Linear_trial.m
Reads data file Stress_modelling_data.xlsx. Fits linear regression model to Nt, Nd, W, B, although this was not a good fit. 
#### Multi_obj_sub2.m
Script to run multi-objective optimisation of Rear Gear Sprocket Mass and drivetrain efficiency. Calls Nonlin_con.m and felix_multifunction.m
#### Nonlin_con.m
Nonlinear constraints for fmincon and gamultiobj. Parameters are Nt, Nd, W, B,
#### pareto front for felix multi obj more points.fig
Visualisation of the pareto front of the multiobjective optimisation file Multi_obj_sub2.m
#### Scatter of Rd and C to show convex nature.fig
Visualisation of convex optimisation of Effiency_optimisation.m.
#### Stress_modelling_data.xlsx
The data file containing FEA simulation results from the LHsam_mass.xlsx inputs to CHAIN SPROKET modified.SLDPRT. 
#### trans_eff.m
Function file containing objective functions of the drivetrain efficiency. Parameters are C, Rd. 

## Main Scripts

#### For Optimisation
##### Multi_obj_sub2.m
For the multi objective Optimisation
##### Effiency_optimisation.m
For the Drivetrain Efficiency Optimisation
##### Mass_optimisation.m
For the Gear Sprocket Mass Optimisation

#### For Meta Modelling:
##### Metamodel_creation_Stress.m
Meta modelling the Stress contraint on the Gear
##### Metamodel_creation_mass.m
Meta modelling the Mass of part of the Gear

