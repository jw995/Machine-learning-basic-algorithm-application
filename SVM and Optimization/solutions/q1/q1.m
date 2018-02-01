clear all;
close all;
clc;

%HAR DATA
X=importdata('UCI HAR Dataset/train/X_train.txt');
y=importdata('UCI HAR Dataset/train/y_train.txt');
X_test=importdata('UCI HAR Dataset/test/X_test.txt');
y_test=importdata('UCI HAR Dataset/test/y_test.txt');
[ndata,wid] = size(X);
nf = wid;

labels=[1,5,6];
%labels=[1,4,6];

%extract the training data
temp=ismember(y,labels);
index_0=find(temp);
X=X(index_0,:);
y=y(index_0,:);
[ndata,wid] = size(X);
%extract the test data
temp=ismember(y_test,labels);
index_0=find(temp);
X_test=X_test(index_0,:);
y_test=y_test(index_0,:);
ntestdata = size(X_test,1);


%Project and Visualize data in 2D
k=2;%dimensions

%Look how easy PCA projection is!
meanX=mean(X);
X=X-ones(ndata,1)*meanX;
S=cov(X);
size(S);
[V,D]=eig(S);

for i=1:k
    Vreduced(:,i)=V(:,nf+1-i);
end

Xreduced=X*Vreduced;
X = Xreduced; %lets refresh X with this projected data

%Plot the 2D projected data, together with the classes

figure();
index_A=find(ismember(y,labels(1))); %red-walking
index_B=find(ismember(y,labels(2))); %green-standing
index_C=find(ismember(y,labels(3))); %blue-laying
plot(X(index_A,1),X(index_A,2),'r.','Markersize',3);
hold on;
plot(X(index_B,1),X(index_B,2),'g.','Markersize',3);
hold on;
plot(X(index_C,1),X(index_C,2),'b.','Markersize',3);
title('{\bf Training data for HAR set}');
hold off;

%YOUR CODE HERE%
%hint: index_A=find(ismember(y_test,labels(1))); %RED

%For your convenience, we will process and prepare the test data for you!
%Project the test data to 2D using the above PCA mean and covar eigenvectors
X_test=X_test-ones(ntestdata,1)*meanX;
Xtestreduced=X_test*Vreduced;
X_test = Xtestreduced;

%plot the test data

figure();
index_test1=find(ismember(y_test,labels(1))); %red-walking
index_test2=find(ismember(y_test,labels(2))); %green-standing
index_test3=find(ismember(y_test,labels(3))); %blue-laying
plot(X_test(index_test1,1),X_test(index_test1,2),'r.','Markersize',3);
hold on;
plot(X_test(index_test2,1),X_test(index_test2,2),'g.','Markersize',3);
hold on;
plot(X_test(index_test3,1),X_test(index_test3,2),'b.','Markersize',3);
title('{\bf Test data for HAR set}');
hold off;

disp(['The 100th training data is (',num2str(X(100,1)), ',',num2str(X(100,2)),...
    '), and its label is ',num2str(y(100,1)), '.']);
disp(['The 100th testing data is (',num2str(X_test(100,1)), ',',...
    num2str(X_test(100,2)), '), and its label is ',num2str(y_test(100,1)), '.']);


%**************** solution for (c)***********************
% walking-standing to laying
Y_A=zeros(size(y(index_A,:)));
Y_B=zeros(size(y(index_B,:)));
Y_C=zeros(size(y(index_C,:)));

X1=[X(index_A,:);X(index_B,:);X(index_C,:)];
Y1=[Y_A;Y_B;y(index_C,:)];
SVMModel_AB = fitcsvm(X1,Y1);
sv_AB = SVMModel_AB.SupportVectors;
figure;
gscatter(X1(:,1),X1(:,2),Y1);
hold on;
plot(sv_AB(:,1),sv_AB(:,2),'ko','MarkerSize',10);
legend('versicolor','virginica','Support Vector');
% hold on;
% plot(4,-1,'^','MarkerSize',10,'MarkerFaceColor','g');
hold off;

% standing-laying to walking
Y2=[y(index_A,:);Y_B;Y_C];
SVMModel_BC = fitcsvm(X1,Y2);
sv_BC = SVMModel_BC.SupportVectors;
figure;
gscatter(X1(:,1),X1(:,2),Y2);
hold on;
plot(sv_BC(:,1),sv_BC(:,2),'ko','MarkerSize',10);
legend('versicolor','virginica','Support Vector');
% hold on;
% plot(4,-1,'^','MarkerSize',10,'MarkerFaceColor','g');
hold off;

% walking-laying to standing
Y3=[Y_A;y(index_B,:);Y_C];
SVMModel_AC = fitcsvm(X1,Y3);
sv_AC = SVMModel_AC.SupportVectors;
figure;
gscatter(X1(:,1),X1(:,2),Y3);
hold on;
plot(sv_AC(:,1),sv_AC(:,2),'ko','MarkerSize',10);
legend('versicolor','virginica','Support Vector');
% hold on;
% plot(4,-1,'^','MarkerSize',10,'MarkerFaceColor','g');
hold off;

% ************ solution for (e) ***********************

[label1,score1]=predict(SVMModel_AB,X_test); %6
[label2,score2]=predict(SVMModel_AC,X_test); %5
[label3,score3]=predict(SVMModel_BC,X_test); %1
score=[score1(:,2) score2(:,2) score3(:,2)];
[val, idx]=max(score,[],2);
idx_6=find(idx==1);
idx_5=find(idx==2);
idx_1=find(idx==3);
idx(idx_6,1)=labels(1,3);
idx(idx_5,1)=labels(1,2);
idx(idx_1,1)=labels(1,1);

group = y_test;
[C,order] = confusionmat(group,idx)

% ************ solution for (f) ************************
d1 = 25/99;
d2 = 9/99;
[x1Grid,x2Grid] = meshgrid(min(X(:,1)):d1:max(X(:,1)),...
min(X(:,2)):d2:max(X(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
N = size(xGrid,1);

[label1,score1]=predict(SVMModel_AB,xGrid); %6
[label2,score2]=predict(SVMModel_AC,xGrid); %5
[label3,score3]=predict(SVMModel_BC,xGrid); %1
score=[score1(:,2) score2(:,2) score3(:,2)];
[val, idx]=max(score,[],2);
idx_6=find(idx==1);
idx_5=find(idx==2);
idx_1=find(idx==3);

figure;
plot(xGrid(idx_6,1),xGrid(idx_6,2),'.b','MarkerSize',3);
hold on;
plot(xGrid(idx_5,1),xGrid(idx_5,2),'.g','MarkerSize',3);
hold on;
plot(xGrid(idx_1,1),xGrid(idx_1,2),'.r','MarkerSize',3);















