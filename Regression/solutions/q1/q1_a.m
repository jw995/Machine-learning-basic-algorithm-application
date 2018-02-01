clc;
clear;

load data10.txt;
load data15.txt;
load data100.txt;

subplot(1,3,1);
x=linspace(0,1,100)';
y=sin(2*pi*x);
plot(x,y,'g');
hold on;
plot(data10(:,1),data10(:,2),'ob');
axis square;

subplot(1,3,2);
x=linspace(0,1,100)';
y=sin(2*pi*x);
plot(x,y,'g');
hold on;
plot(data15(:,1),data15(:,2),'ob');
axis square;

subplot(1,3,3);
x=linspace(0,1,100)';
y=sin(2*pi*x);
plot(x,y,'g');
hold on;
plot(data100(:,1),data100(:,2),'ob');
axis square;

