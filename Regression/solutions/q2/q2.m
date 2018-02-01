clc;
clear;
close all hidden;

% *********** solution for (a) *****************
data=[0 0 0 10; 8 6 1 15; 5 2 8 20; 8 2 6 22; ...
           5 1 2 16; 3 3 3 23; 9 8 2 18; 3 6 5 19; ...
           4 6 9 25; 1 8 2 20; 1 1 2 28; 6 4 2 27];
lambda=exp(-5);

x=data(:,1);
y=data(:,2);
z=data(:,3);
T=data(:,4);
addon=ones(12,1);


A=[x y z addon];
Ainner = A'*A;
k = size(Ainner,1);

c=inv(Ainner)*A'*T;
c_L2= inv(Ainner+lambda*eye(k,k))*A'*T;

format bank;
x_test=[5 5 5 1];
T_test=x_test*c
T_test_L2=x_test*c_L2

% *********** solution for (b) *****************
neighbour=(4:0.1:6)';
size_nb=size(neighbour,1);
temp1=5*ones(size_nb,1);
addons=ones(size_nb,1);

data_x=[neighbour temp1 temp1 addons];
T_x=data_x*c;
data_y=[temp1 neighbour temp1 addons];
T_y=data_y*c;
data_z=[temp1 temp1 neighbour addons];
T_z=data_z*c;


plot(neighbour,T_x,'b');
hold on;
plot(neighbour,T_y,'r');
hold on;
plot(neighbour,T_z,'k');
legend('change x direction','change y direction',...
    'change z direction');










