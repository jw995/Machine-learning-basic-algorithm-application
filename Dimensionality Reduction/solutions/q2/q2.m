clc;
clear;
close all hidden;

% ************* solution for (a) ****************
load q2data.txt;
m=mean(q2data);
n=size(q2data,1);
data=q2data-repmat(m,[n,1]);
inner=data*data';
[vector, value]=eig(inner);
vector=fliplr(vector); 

% pick non-zero vectors
vec=vector(:,1:3)

% ************* solution for (b) ****************
u=data'*vec;
u1=normc(u);
omega=data*u1

% ************* solution for (c) ****************
trans_data=omega*u1'+repmat(m,[n,1]);
error=trans_data-q2data;
E=error.^2;
MSE=[mean(E(1,:)); mean(E(2,:)); 
    mean(E(3,:)); mean(E(4,:))];

% ************* solution for (d) ****************
% pick two vectors
vec2=vector(:,1:2);
u2=data'*vec2;
u2=normc(u2);
omega2=data*u2;
trans_data2=omega2*u2'+repmat(m,[n,1]);
error2=trans_data2-q2data;
E2=error2.^2;
MSE2=[mean(E2(1,:)); mean(E2(2,:)); 
    mean(E2(3,:)); mean(E2(4,:))];

% ************* solution for (e) ****************
Y=[1 3 0 3 -2 2 4 1 3 0 -2 0 1 1 -3 0 1 -2 -3];
dis1=sqrt(sum((trans_data(1,:)-Y).^2));
dis2=sqrt(sum((trans_data(2,:)-Y).^2));
dis3=sqrt(sum((trans_data(3,:)-Y).^2));
dis4=sqrt(sum((trans_data(4,:)-Y).^2));

% ************* solution for (f) ****************
Dis1=sqrt(sum((q2data(1,:)-Y).^2));
Dis2=sqrt(sum((q2data(2,:)-Y).^2));
Dis3=sqrt(sum((q2data(3,:)-Y).^2));
Dis4=sqrt(sum((q2data(4,:)-Y).^2));



