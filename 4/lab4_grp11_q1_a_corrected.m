%initial conditions
v0 = 5; %inlet flow rate
V = 10; %Volume of each reactor
Ca0 = 10; %initial Ca (concentration of A species)
Cb0 = 0; %initial Cb (concentration of B species)
k = 0.9; %rate constant
kd = 0.01;%decay constant
tspan = 0:0.01:60; %time interval
y0 = [Ca0 0 0 1 1 1]; %initial concentrations of each reactor of A & initial values of catalyst activity 
%differential equations
dydt=@(t,y)[(v0*Ca0-v0*y(1)-k*V*y(4)*y(1))/V;(v0*y(1)-v0*y(2)-k*V*y(5)*y(2))/V;(v0*y(2)-v0*y(3)-k*V*y(6)*y(3))/V;-kd*y(4);-kd*y(5);-kd*y(6)];
[t,y] = ode45(dydt,tspan,y0); %ode45 inbuilt method using to solve the differential equations
figure(1);
plot(t,y(:,1),'-',t,y(:,2),':',t,y(:,3),'--'); %plotting graph between Ca1 & t,  Ca2 & t, Ca3 wrt t
xlabel('Time(min)'), ylabel('Concentration(gmol/dm^3)')  
legend('C_{A1}','C_{A2}','C_{A3}');