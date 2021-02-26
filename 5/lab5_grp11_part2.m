clc
clear all
P = 162; %Pressure in kPa and feed nitrogen in gmole/sec 
Vspan = [0 4]; %volume of reactor covered at inlet and outlet
FN2 = [28.3 18.3 8.3 3.3 0.0]; nF = length(FN2);  %flow rates of Nitogen
for i = 1:nF
    X0 = [38.3-FN2(i) 0 0 1150];%initial X with varying N2 flow rates.
    pf = [P FN2(i)]; %initialzing pf
    [V X] = ode45(@ode_solver, Vspan, X0, [], pf); %solving using ode45 method
    figure(1) %plotting T vs V.
    plot(V,X(:,4)), xlabel('Reactor volume(m^3)'), ylabel('Temperature(K)'), 
    legend('FN2 = 28.3','FN2 = 18.3','FN2 = 8.3','FN2 = 3.3','FN2 = 0.0');
    hold on;
end
for i = 1:nF
    X0 = [38.3-FN2(i) 0 0 1150]; 
    pf = [P FN2(i)];
    [V X] = ode45(@ode_solver, Vspan, X0, [], pf);
    xc = (X0(1) - X(:,1))/X0(1); Tr(i) = X(end,4); %finding x and T
    xfc(i) = (X0(1) - X(end,1))/X0(1);
    figure(2) %plotting conversion vs Volume
    plot(V,xc), xlabel('Reactor volume(m^3)'), ylabel('Conversion');
    legend('FN2 = 28.3','FN2 = 18.3','FN2 = 8.3','FN2 = 3.3','FN2 = 0.0');
    hold on;
end
fprintf('final conversion array'); xfc
fprintf('\nTemperature array'); Tr