T1 = 250;  %Hot fluid inlet temperature (deg.F)
T2 = 100;  %Hot fluid outlet temperature (deg.F)
t1 =  80;  %Cold fluid inlet temperature (deg.F)
t2 = 120;  %Cold fluid outlet temperature (deg.F)
N = 1; % Initializing N
Delt1 = T2 - t1; Delt2 = T1 - t2;    %calculating delta t1 and delta t2
% Computing P and R
P = (t2 - t1)/(T1 - t1); R = (T1 - T2)/(t2 - t1);
% Testing for F and R
A = -1; B = -1; F = 0.1; % Initializing F
while (F <= 0.75)
 if ( R > 1 || R < 1)
 while (A < 0)
 P_ = (1 - ((P*R-1)/(P-1))^(1/N)) / (R-((P*R-1)/(P-1))^(1/N));
A = (2/P_ - 1 - R + sqrt(R^2 +1)) / (2/P_ - 1 - R - sqrt(R^2 +1));   %calculating P' and A
if (A < 0)
 N = N + 1;      %Updating N
 end
 end
F = ( sqrt(R^2 +1) * log10((1-P_)/(1-P_*R)) / (R-1) ) / (log10(A));   %Updating F
 else % R = 1
 while (B < 0)
 Pd = P / (N-P*(N-1));
B = (2/Pd - 2 + sqrt(2)) / (2/Pd - 2 - sqrt(2));     %Calculating P'' and B
if (B < 0)
 N = N + 1;
 end
 end
F = ( sqrt(R^2 +1) * Pd / (log(10*(1-Pd))) ) / (log10(B));  %Updating F
 end
if (F <= 0.75)
 N = N + 1;          %Updating N
 end
end
% Compute LMTD
if (Delt1 == Delt2)
 LMTD = Delt1;        
else
 LMTD = (Delt1-Delt2)/(log(Delt1/Delt2));      %calculating LMTD
end
uLMTD = F*LMTD; %Updating LMTD
% Output
fprintf('\nNumber of shells required = %2d\n', N);
fprintf('Correction factor F = %9.6f\n', F);
fprintf('Updated LMTD = %9.6f\n', uLMTD);