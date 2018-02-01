%=====(d)
load data10.txt;
% X=linspace(0,1,100)';
% Y=sin(2*pi*X);

y=data10(:,2);
x0=ones(size(data10,1),1);
x1=data10(:,1);
x2=x1.*x1;
x3=x1.*x2;
x4=x1.*x3;
x5=x1.*x4;
x6=x1.*x5;
x7=x1.*x6;
x8=x1.*x7;
x9=x1.*x8;
lambda=0;

A4=[x9,x8,x7,x6,x5,x4,x3,x2,x1,x0];
A3=[x6,x5,x4,x3,x2,x1,x0];
A2=[x2,x1,x0];
A1=[x1,x0];
A={A1,A2,A3,A4};
m=[1;2;6;9];
Erms1=zeros(4,1);
Erms2=zeros(4,1);
N=size(y,1);
yt=sin(2*pi*data10(:,1));
for i=1:4
    c=(A{i}'*A{i}+lambda*eye(m(i)+1))^(-1)*A{i}'*y;
    ye=A{i}*c;
    Ec1=(yt-ye)'*(yt-ye);
    Erms1(i)=sqrt(2.0*Ec1/N);
    Ec2=(y-ye)'*(y-ye);
    Erms2(i)=sqrt(2.0*Ec2/N); 
end

figure;
plot(m,Erms1,'go');
hold on;
plot(m,Erms2,'bo');
hold off;

