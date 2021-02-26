tspan = 0:0.001:5; %time_range
F = 100;%flow_rate
V = 100;%Volume of CSTR
CAf = 1;%Feed_concentration
alpha = 7.2e10;%pre_exponential_factor
E_R = 8750; %activation_energy/gas_constant
Tf = 350;%feed_temperature 
delH = 5e4;%-1*heat_of_rxn
rho = 1000;%density of mixture
Cp = 0.239;% heat capacity of mixture
U_A = 50000;%overall_heat_transfer_coefficient
Tc = 300;%coolant_temperature
y0 = [0.877 324.48];%inital_concentration_and_initail_temperature
%differential_equations
dydt = @(t,y)[F/V*(CAf-y(1))-alpha*exp(-E_R/y(2))*y(1); 
   F/V*(Tf-y(2))+(delH/(rho*Cp))*alpha*exp(-E_R/y(2))*y(1)-(U_A/(V*Cp*rho))*(y(2)-Tc)];
[t,y] = ode45(dydt,tspan,y0);%solving_using_ode45
figure(3);
plot(t,y(:,1),'-')
xlabel('Time(sec)'), ylabel('Concentration(mol/m^3)')
figure(4);
plot(t,y(:,2),'-')
xlabel('Time(sec)'), ylabel('Temperature(K)') 
