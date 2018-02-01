clear all;
close all;
clc;

X = load ('clean_lin.txt');
%X = load ('dirty_nonlin.txt');
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
H=[1 0 0; 0 1 0; 0 0 0];
f=[0; 0; 0];
x_new=[X ones(ndata,1)];
y_new=repmat(y,1,3);
A=bsxfun(@times, y_new, x_new);
b=ones(ndata,1)*(-1);
[x,fval,exitflag,output,lambda] = quadprog(H,f,A,b);
x,fval

% *********** here goes solution for (c) **************
lambda_vector=lambda.ineqlin
support_index=find(lambda_vector>0.1);
plot(X(support_index,1),X(support_index,2),'ok','Markersize',8);
hold on;

% *********** here goes solution for (d) **************
d = min((max(X(:,1)) - min(X(:,1))), ((max(X(:,2)) - min(X(:,2)))))/50;
[x1Grid,x2Grid] = meshgrid(min(X(:,1)):d:max(X(:,1)),...
    min(X(:,2)):d:max(X(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
N = size(xGrid,1);

weight=[x(1,1) x(2,1)];
bias=x(3,1);
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
end




%YOUR CODE HERE%

