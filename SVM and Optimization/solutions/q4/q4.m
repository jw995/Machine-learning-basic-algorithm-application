clc;
clear;
% ********** solution for (a) ******************
% suppose that d is x1 and t is x2
% calculated from real diameter, not average one
% since averge one gives an outcome of [1.1575 1]
% which is not that reasonable comparing to this one
 fun = @(x)0.6875*pi*x(2)^2+1.375*pi*x(1)*x(2)+2*x(1);
 x0=[1000 1000];
 A=[];
 b=[];
 lb = [1, 0.1];
 ub = [10, 1];
 Aeq = [];
 beq = [];
 nonlcon = @restrain1;
 options = optimoptions('fmincon','Display','iter','Algorithm','active-set');
 x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
 
 % ********* solution for (b) *******************
 options1 = optimoptions('fmincon','Display','iter','Algorithm','sqp');
 x1 = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options1)