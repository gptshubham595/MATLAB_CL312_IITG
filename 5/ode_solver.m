function dX = ode_solver(V,X,pf) 
  %differential equations for cracking of acetone
  P = pf(1);
  FN2 = pf(2);
  T = X(4);
  CA = 1000*(X(1)./(X(1)+X(2)+X(3)+FN2))*P/(8.31*T);
  k = exp(34.34-34222/T);
  dH = 80770+6.8*(T-298)-(5.75e-3)*(T^2 - 298^2)-(1.27e-6)*(T^3 - 298^3);
  CpA = 26.2 + 0.183*T - (45.86e-6)*T^2;
  CpB = 20.04 + 0.0945*T - (30.95e-6)*T^2;
  CpC = 13.39 + 0.077*T - (18.91e-6)*T^2;
  CpN2 = 6.25 + 0.00878*T - (2.1e-8)*T^2;
  rA = -k.*CA;
  %using dFA/dV,dFB/dV,dFC/dV and dT/dV.
  dX = [rA; -rA; -rA; -rA*(-dH./(X(1)*CpA + X(2)*CpB + X(3)*CpC + FN2*CpN2))];
end