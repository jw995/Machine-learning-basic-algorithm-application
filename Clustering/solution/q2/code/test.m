clc;
clear;
% *************** spectral clustering ****************
load data_c.txt;
N=size(data_c,1);
A_c=zeros(N,N);
D_c=zeros(N,N);
k=8;  %<<--define the number of eigen value here

% calculate similarity matrix
for i=1:N
    for j=1:N
        A_c(i,j)=gaussiandist(data_c,i,j,0.5);
    end
end
% calculate degree matrix
for i=1:N
    D_c(i,i)=sum(A_c(i,:));
end
% calculate normalized Laplacian matrix
L_c=eye(N)-D_c^(-0.5)*A_c*D_c^(-0.5);
[evectors, evalue] = eig(L_c);

new_data=evectors(:,2:k+1);
idx_c2=kmeans(new_data, 5);

cluster_c11=find(idx_c2==1);
cluster_c21=find(idx_c2==2);
cluster_c31=find(idx_c2==3);
cluster_c41=find(idx_c2==4);
cluster_c51=find(idx_c2==5);

figure;
plot(data_c(cluster_c11,1),data_c(cluster_c11,2),'.r');
hold on; 
plot(data_c(cluster_c21,1),data_c(cluster_c21,2),'.b');
hold on;
plot(data_c(cluster_c31,1),data_c(cluster_c31,2),'.g');
hold on;
plot(data_c(cluster_c41,1),data_c(cluster_c41,2),'.m');
hold on;
plot(data_c(cluster_c51,1),data_c(cluster_c51,2),'.k');
