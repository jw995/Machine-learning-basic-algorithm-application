% - data100
% - lambda = exp(-10)
% - m=9
% - c initially set to the zero vector
% - alpha = 0.01 (damping factor).
% - Number of iterations = 10,000

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
c=zeros(k,1);
for i=1:10000
    err_fun=2*((Ainner+lambda*eye(k,k))*c-A'*y);
    c = c-alpha*err_fun;
end

c
c_diff=c_conv-c











