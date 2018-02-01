clear;
close all;
clc;

%X = load ('clean_lin.txt');
%X = load ('clean_nonlin.txt');
X = load ('dirty_nonlin.txt');
[ndata,wid] = size(X);
y = X(:,wid); %get the last column as the label vector
nf=wid-1; %number of features
X = X(:,1:nf); %get the data
labels=[1,-1];

% *********** here goes solution for (a) **************
for i=1:ndata
    if (y(i,1)==1)
        plot(X(i,1),X(i,2),'b*');
        hold on;
    else 
        plot(X(i,1),X(i,2),'r*');
        hold on;
    end
end

% *********** here goes solution for (b) **************

C=0.05; % <----DEFINE C HERE

H=zeros(ndata+3);
H(1,1)=1; H(2,2)=1;
x_new=[X ones(ndata,1)];
y_new=repmat(y,1,3);
A_ul=bsxfun(@times, y_new, x_new);
A_ur=-1*eye(ndata);
A_ll=zeros(ndata,3);
A_lr=-1*eye(ndata);
A=[A_ul A_ur; A_ll A_lr];
b_u=-1*ones(ndata,1);
b_l=zeros(ndata,1);
b=[b_u; b_l];
f=ones(ndata+3,1);
f(1,1)=0; f(2,1)=0; f(3,1)=0;
f=C*f;
[x,fval,exitflag,output,lambda] = quadprog(H,f,A,b);
weight=[x(1,1) x(2,1)]
bias=x(3,1)

% *********** here goes solution for (d) **************
d = min((max(X(:,1)) - min(X(:,1))), ((max(X(:,2)) - min(X(:,2)))))/100;
[x1Grid,x2Grid] = meshgrid(min(X(:,1)):d:max(X(:,1)),...
    min(X(:,2)):d:max(X(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
N = size(xGrid,1);

outcome=zeros(N,1);
for i=1:N
    my_test=[xGrid(i,1) xGrid(i,2)];
    outcome(i,1)=weight*my_test'+bias;
    if (outcome(i,1)>1)
        plot(xGrid(i,1),xGrid(i,2),'g.','Markersize',3);
        hold on;
    end
    if (outcome(i,1)<-1)
        plot(xGrid(i,1),xGrid(i,2),'r.','Markersize',3);
        hold on;
    end
    if (outcome(i,1)>=-1 && outcome(i,1)<=1)
        plot(xGrid(i,1),xGrid(i,2),'b.','Markersize',3);
        hold on;
    end
    title(['C=',num2str(C)]);
end



