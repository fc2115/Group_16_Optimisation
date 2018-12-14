## Folder Structure 
#### multifunction.m
The multi-objective functions considering the Beam mass in subsystem_1 and drive train efficiency in subsystem_2. 
#### Nonlin_con_fmincon_systemlevel.m
Nonlinear constraints for multi objective optimisation. 
#### systemlevel_opti.m:
Script to run the multi-objective optimisastion. Calls: multifunction.m, Nonlin_con_fmincon_systemlevel.m.
#### pareto front system level.fig
The pareto front for the system level optimisation.

## Main Script
systemlevel_opti.m

## Execution Time
Optimisation Script 15 - 20 seconds. 
Intel Core i7-4600U CPU @Dual-core 2.1-3.3GHzz, 16GB RAM
