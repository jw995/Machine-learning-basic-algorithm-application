clc;
clear;
close all hidden;

load data100.txt;
m=[1,2,6,9];
alpha = 0.01;
alpha = alpha /2;

% change data set here 
data=data100;
% define lambda here
lambda=exp(-10);
% choose fitting model parameter m here
m_choose=m(4);

x=data(:,1);
y=data(:,2);
size_data=size(data,1);

A=zeros(size_data,m_choose+1);

for i=1:m_choose+1
    A(:,i)=x.^(m_choose+1-i);
end

Ainner = A'*A;
k = size(Ainner,1);

format bank;
c_conv = inv(Ainner+lambda*eye(k,k))*A'*y;

% ************************************************
H=2*(A'*A+lambda*eye(k,k));
f=(-2*y'*A)';
c = quadprog(H,f)
c_diff=c-c_conv

