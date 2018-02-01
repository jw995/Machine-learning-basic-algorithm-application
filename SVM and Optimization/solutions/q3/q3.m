clc;
clear;
% ********** solution for (a) and (b) ******************
H = [1 0; 0 9]; 
f = [3.2; -6];
A = [-1 -3; 2 5; 3 4];
b = [-15; 100; 80];
lb = zeros(2,1);
options = optimoptions('quadprog',...
    'Algorithm','interior-point-convex','Display','off');
[x,fval,exitflag,output,lambda] = ...
   quadprog(H,f,A,b,[],[],lb,[],[],options);
 x,fval
 
 % ********** solution for (c) **************************
 fun = @(x)0.5*x(1)^2+3.2*x(1)+4.5*x(2)^2-6*x(2)+7;
 x0=[-1,2];
 x1 = fmincon(fun,x0,A,b,[],[],lb,[])