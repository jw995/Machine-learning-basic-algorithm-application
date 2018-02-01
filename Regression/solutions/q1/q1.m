clc;
clear;
close all hidden;

% ********* solution for (b) ****************
load data10.txt;
load data15.txt;
load data100.txt;
m=[1,2,6,9];

% change data set here 
data=data10;
% define lambda here
lambda=0;
% choose fitting model parameter m here
m_choose=m(4);

x=data(:,1);
y=data(:,2);
size_data=size(data,1);

A=zeros(size_data,m_choose+1);
x_test=zeros(100,m_choose+1);

for i=1:m_choose+1
    A(:,i)=x.^(m_choose+1-i);
end

Ainner = A'*A;
k = size(Ainner,1);

format bank;
c_conv = inv(Ainner+lambda*eye(k,k))*A'*y;
c_conv

X=linspace(0,1,100)';
for i=1:m_choose+1
    x_test(:,i)=X.^(m_choose+1-i);
end
y_conv=x_test*c_conv;
y_true=sin(2*pi*X);


plot(X,y_true,'g');
hold on;
plot(X,y_conv,'r');
hold on;
plot(x,y,'ob');
title(['lambda=',num2str(lambda), ...
    ', m=',num2str(m_choose)]);

% ********* solution for (d) ****************
format short;
err=y_conv-y_true;
err_fun=err'*err;
N=size(y_true,1);
truth_RMS=sqrt(2.0*err_fun/N)

x_pick=zeros(size_data,m_choose+1);
for i=1:m_choose+1
    x_pick(:,i)=x.^(m_choose+1-i);
end
y_pick=x_pick*c_conv;
err1=y_pick-y;
err1_fun=err1'*err1;
data_RMS=sqrt(2.0*err1_fun/size_data)

figure;
RMS_i=[0.6503 0.6662 0.3001 0.5038];
RMS_ii=[0.6832 0.6690 0.2576 0.0000];
plot(m,RMS_i,'o','MarkerFaceColor','g');
hold on;
plot(m,RMS_ii,'o','MarkerFaceColor','b');






