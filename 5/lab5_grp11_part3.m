P = [1.6:0.2:5]*101.325; %initializing pressure range
Vspan = [0 4]; %initailzing reactor volume
FA0 = [10 20 30 35 38.3]; %initialzing acetone flow rates
FN2 = 38.3-FA0; nP = length(P); nF = length(FA0);
xc = zeros(nF,nP); T = zeros(nF,nP); %initialzing concentartion and temperature matrix
for i = 1:nF
    for j = 1:nP
        X0 = [FA0(i) 0 0 1035]; pF = [P(j) FN2(i)]; %initialzing parameters X and pf
        [V X] = ode45(@ode_solver, Vspan, X0, [], pF);%solving using ode45 method
        xc(i,j) = (X0(1)-X(end,1))/X0(1);
        T(i,j) = X(end,4);
    end
end
P = P/101.325;
%plotting T vs P
figure(3)
plot(P,T(1,:),'o',P,T(2,:),'*',P,T(3,:),'x',P,T(4,:),'d',P,T(5,:),'v')
xlabel('P(atm)'), ylabel('T(K)'),grid
legend('F_A0 = 10','F_A0 = 20','F_A0 = 30','F_A0 = 35','F_A0 = 38.3');
%plotting XA vs P.
figure(4)
plot(P,xc(1,:),'o',P,xc(2,:),'*',P,xc(3,:),'x',P,xc(4,:),'d',P,xc(5,:),'v')
xlabel('P(atm)'), ylabel('x_A'),grid
legend('F_A0 = 10','F_A0 = 20','F_A0 = 30','F_A0 = 35','F_A0 = 38.3');