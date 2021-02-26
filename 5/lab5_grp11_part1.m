clc
pf = [162 0]; %Pressure in kPa and feed nitrogen in gmole/sec 
Vspan = [0 4]; %volume of reactor covered at inlet and outlet
X0 = [38.3 0 0 1150]; %initial values of molar flow rate of A,B,C and temperature respectively
[V X] = ode45(@ode_solver, Vspan, X0, [], pf); %solving using ode45 method
FA = X(end,1),FB = X(end,2),FC = X(end,3),T = X(end,4)