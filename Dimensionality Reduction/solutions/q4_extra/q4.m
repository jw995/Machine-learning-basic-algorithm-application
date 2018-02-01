clc;
clear;
close all hidden;

load data.mat;
X_train=X(:,trainimages);
dim=size(X_train,1);
n=size(X_train,2);
Y_train=Y(trainimages,1);

% every 9 samples are a class
mean1=zeros(dim,15);
%scatter matrix
sw=0;
for i=1:15
    class_new=X_train(:,i*9-8:i*9);
    cov1=cov(class_new);
    mean1(:,i)=mean(class_new,2);
    trans(:,i*9-8:i*9)=class_new-repmat(mean1(:,i),[1,9]);
    sw=sw+cov1;
end

%mean of all the classes
mean_all=1/15*sum(mean1,2);

diff_avg=zeros(dim,15);
sb=0;
for i=1:15
    diff_avg(:,i)=mean1(:,i)-mean_all;
    diff=9*diff_avg(:,i)'*diff_avg(:,i);
    sb=sb+diff;
end

A=inv(sw)*sb;
[vector,value]=eig(A);
rank_val=sum(value,1);
[rank_val, index]=sort(rank_val, 'descend');
vector=fliplr(vector);

for i=1:15
    omega(:,i*9-8:i*9)=trans(:,i*9-8:i*9)*vector;
    transdata(:,i*9-8:i*9)=omega(:,i*9-8:i*9)*vector'+repmat(mean1(:,i),[1,9]);
end


% test
X_test=X(:,testimages);
Y_test=Y(testimages,1);
k=size(X_test,2);
distance=zeros(k,n);
lb=zeros(k,1);
nn=size(X_test,2);

 for i=1:k
    sample_k=X_test(:,i);
    error=transdata-repmat(sample_k,[1,n]);
    Err=error.^2;
    distance(i,:)=sqrt(sum(Err));
    [val,lb(i,:)]=min(distance(i,:));
 end
 label=Y_train(lb(:,1));

 err_sample=Y_test-label;
 err=length(find(err_sample(:,1)~=0));
 err_rate=err/nn*100











