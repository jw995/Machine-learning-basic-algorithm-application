clc;
clear;
close all hidden;

% ************* question (a) ******************
load q1data.txt;
plot(q1data(:,1),q1data(:,2),'*');
title('original data');

x1_mean=mean(q1data(:,1));
x2_mean=mean(q1data(:,2));

data(:,1)=q1data(:,1)-x1_mean;
data(:,2)=q1data(:,2)-x2_mean;

C=cov(data);
[vector, value]=eig(C);
vector = fliplr(vector); 

figure;
plot(data(:,1),data(:,2),'*');
hold on;
x=-3:0.1:3;
y1=vector(1,1)/vector(2,1)*x;
y2=vector(1,2)/vector(2,2)*x;
plot(x,y1,'r-');
hold on;
plot(x,y2,'r-.');
legend('mean adjusted data','e1','e2');
axis([-1.5 1.5 -1.5 1.5]);
axis equal;

% *********** question (b) ********************
[n,~] = size(q1data);
m = repmat(mean(q1data),[n,1]);

A=data*vector;
final_data=m+A*vector';

figure;
x1=final_data(:,2);
x2=final_data(:,1);
plot(x1,x2,'*');
hold on;
x1=0:0.1:4;
y1=vector(1,1)/vector(2,1)*x1;
plot(x1,y1,'r-');
axis equal;
legend('final processed data');

% *********** question (c) ********************
vector_pick=vector(:,1);
opt_data=data*vector_pick;
dis=max(opt_data)-min(opt_data);











