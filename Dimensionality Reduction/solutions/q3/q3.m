clc;
clear;
close all hidden;

% ************** question (a) *****************
load data.mat;
X_train=X(:,trainimages);
n=size(X_train,2);
x_mean=mean(X_train,2);
data=X_train-repmat(x_mean, [1,n]);
C=data'*data/n;
[vector,value]=eig(C);

rank_val=sum(value,1);
[rank_val, index]=sort(rank_val, 'descend');
vector=fliplr(vector);

cur_sum=0;
sum_val=0.9*sum(rank_val);
for i=1:n
    cur_sum=cur_sum+rank_val(1,i);
    if (cur_sum>sum_val)
        E=i;
        break;
    end
end

pctg=rank_val(1:5)/sum(rank_val)*100;
bar(pctg); 
xlabel('PCs');
ylabel('Variance(%)');

vector_pick=vector(:,1:5);
u=data*vector_pick;
u_norm=normc(u);
omega=data'*u_norm;
for i=1:5
    figure;
    imshow(reshape(u(:,i),231,195));
    title(['top ', num2str(i)]);
end

% ************** question (b) *****************
%draw original face
figure;
imshow(reshape(X_train(:,1),231,195));
title('original face');

sample=X_train(:,1);
% reconstruct with 10 eigen faces
vector1=vector(:,1:10);
u1=data*vector1;
u1=normc(u1);
omega1=data'*u1;
trans1=(omega1*u1')'+repmat(x_mean,[1,n]);
figure; 
imshow(reshape(trans1(:,1),231,195));
title({['reconstructed version'];['using 10 eigen faces']});

% reconstruct with 20 eigen faces
vector2=vector(:,1:20);
u2=data*vector2;
u2=normc(u2);
omega2=data'*u2;
trans2=(omega2*u2')'+repmat(x_mean,[1,n]);
figure; 
imshow(reshape(trans2(:,1),231,195));
title({['reconstructed version'];['using 20 eigen faces']});

% reconstruct with 30 eigen faces
vector3=vector(:,1:30);
u3=data*vector3;
u3=normc(u3);
omega3=data'*u3;
trans3=(omega3*u3')'+repmat(x_mean,[1,n]);
figure; 
imshow(reshape(trans3(:,1),231,195));
title({['reconstructed version'];['using 30 eigen faces']});

% reconstruct with 40 eigen faces
vector4=vector(:,1:40);
u4=data*vector4;
u4=normc(u4);
omega4=data'*u4;
trans4=(omega4*u4')'+repmat(x_mean,[1,n]);
figure; 
imshow(reshape(trans4(:,1),231,195));
title({['reconstructed version'];['using 40 eigen faces']});

% reconstruct with 50 eigen faces
vector5=vector(:,1:50);
u5=data*vector5;
u5=normc(u5);
omega5=data'*u5;
trans5=(omega5*u5')'+repmat(x_mean,[1,n]);
figure; 
imshow(reshape(trans5(:,1),231,195));
title({['reconstructed version'];['using 50 eigen faces']});

% ************** question (c) *****************
% reconstruct with 50 eigen faces
X_test=X(:,testimages);
k=size(X_test,2);
distance=zeros(k,n);
lb=zeros(k,1);
nn=size(X_test,2);
for i=1:k
    sample_k=X_test(:,i);
    % using reduced dimension of 50
    error=trans5-repmat(sample_k,[1,n]);
    Err=error.^2;
    distance(i,:)=sqrt(sum(Err));
    [val,lb(i,:)]=min(distance(i,:));
end
Y_train=Y(trainimages,1);
Y_test=Y(testimages,1);
 label=Y_train(lb(:,1));

 err_sample=Y_test-label;
 err=length(find(err_sample(:,1)~=0));
 err_rate_reduced=err/nn*100
 
 % ************** question (d) *****************
vector6=vector(:,1:135);
u6=data*vector6;
u6=normc(u6);
omega6=data'*u6;
trans6=(omega6*u6')'+repmat(x_mean,[1,n]);

 for i=1:k
    sample_k=X_test(:,i);
    % using reduced dimension of 40
    error=X_train-repmat(sample_k,[1,n]);
    Err=error.^2;
    distance(i,:)=sqrt(sum(Err));
    [val,lb(i,:)]=min(distance(i,:));
 end
 label=Y_train(lb(:,1));

 err_sample=Y_test-label;
 err=length(find(err_sample(:,1)~=0));
 err_rate_origin=err/nn*100





