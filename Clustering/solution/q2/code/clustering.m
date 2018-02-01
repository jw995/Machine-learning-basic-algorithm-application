function clustering()
%==========================================================================
%
%
% Name: Jiayi Wang
%
% No inputs are required to run this function, and no other scripts or 
% functions are needed to complete this problem.
%
% Three datasets have been provided as text files with this assignment:
%   data_a.txt
%   data_b.txt
%   data_c.txt
%
% For each dataset, implement unsupervised clustering using the
% following methods (see helper functions below, which you must complete):
%   cluster_kmeans
%   cluster_hierarchical('single',...)
%   cluster_spectral
%
% Plot the clustering results for each dataset, using a separate color for
% each cluster.
%
% In addition, save the cluster labels for each dataset in text files:
%   clusters_a.txt
%   clusters_b.txt
%   clusters_c.txt
%
% You may assume that the number of cluster is known (it is 5).
%
%
%==========================================================================
clc;
clear;
close all hidden;
% (a) >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% ***************** kmeans *******************
load data_a.txt;
idx_a= cluster_kmeans(data_a,5);
fid=fopen('clusters_a.txt','wt');
fprintf(fid,'%d\n',idx_a);
fclose(fid);

cluster_a1=find(idx_a==1);
cluster_a2=find(idx_a==2);
cluster_a3=find(idx_a==3);
cluster_a4=find(idx_a==4);
cluster_a5=find(idx_a==5);

figure;
plot(data_a(cluster_a1,1),data_a(cluster_a1,2),'.r');
hold on; 
plot(data_a(cluster_a2,1),data_a(cluster_a2,2),'.b');
hold on;
plot(data_a(cluster_a3,1),data_a(cluster_a3,2),'.g');
hold on;
plot(data_a(cluster_a4,1),data_a(cluster_a4,2),'.m');
hold on;
plot(data_a(cluster_a5,1),data_a(cluster_a5,2),'.k');
title('data-a: kmeans');

% *************** single linkage ****************
idx_a1= cluster_hierarchical('single',data_a,5);
cluster_a10=find(idx_a1==1);
cluster_a20=find(idx_a1==2);
cluster_a30=find(idx_a1==3);
cluster_a40=find(idx_a1==4);
cluster_a50=find(idx_a1==5);

figure;
plot(data_a(cluster_a10,1),data_a(cluster_a10,2),'.r');
hold on; 
plot(data_a(cluster_a20,1),data_a(cluster_a20,2),'.b');
hold on;
plot(data_a(cluster_a30,1),data_a(cluster_a30,2),'.g');
hold on;
plot(data_a(cluster_a40,1),data_a(cluster_a40,2),'.m');
hold on;
plot(data_a(cluster_a50,1),data_a(cluster_a50,2),'.k');
title('data-a: single linkage');

% *************** spectral clustering ****************
load data_a.txt;
N=size(data_a,1);
A_a=zeros(N,N);
D_a=zeros(N,N);
k=5;  %<<--define the number of eigen vectors here

% calculate similarity matrix
for i=1:N
    for j=1:N
        A_a(i,j)=gaussiandist(data_a(i,:),data_a(j,:),5);
    end
end
% calculate degree matrix
for i=1:N
    D_a(i,i)=sum(A_a(i,:));
end
% calculate normalized Laplacian matrix
L_a=eye(N)-D_a^(-0.5)*A_a*D_a^(-0.5);
[evectors, ~] = eig(L_a);

new_data=evectors(:,2:k+1);
idx_a2=kmeans(new_data, 5);

cluster_a11=find(idx_a2==1);
cluster_a21=find(idx_a2==2);
cluster_a31=find(idx_a2==3);
cluster_a41=find(idx_a2==4);
cluster_a51=find(idx_a2==5);

figure;
plot(data_a(cluster_a11,1),data_a(cluster_a11,2),'.r');
hold on; 
plot(data_a(cluster_a21,1),data_a(cluster_a21,2),'.b');
hold on;
plot(data_a(cluster_a31,1),data_a(cluster_a31,2),'.g');
hold on;
plot(data_a(cluster_a41,1),data_a(cluster_a41,2),'.m');
hold on;
plot(data_a(cluster_a51,1),data_a(cluster_a51,2),'.k');
title({['data-a: spectral cluster']; ['number of eigen vectors=', num2str(k)]});

% (b)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>.>>>>>>>>>>
% ***************** kmeans *******************
load data_b.txt;
idx_b=cluster_kmeans(data_b,5);

cluster_b1=find(idx_b==1);
cluster_b2=find(idx_b==2);
cluster_b3=find(idx_b==3);
cluster_b4=find(idx_b==4);
cluster_b5=find(idx_b==5);
figure;
plot(data_b(cluster_b1,1),data_b(cluster_b1,2),'.r');
hold on; 
plot(data_b(cluster_b2,1),data_b(cluster_b2,2),'.b');
hold on;
plot(data_b(cluster_b3,1),data_b(cluster_b3,2),'.g');
hold on;
plot(data_b(cluster_b4,1),data_b(cluster_b4,2),'.m');
hold on;
plot(data_b(cluster_b5,1),data_b(cluster_b5,2),'.k');
title('data-b: kmeans');


% *************** single linkage ****************
idx_b1= cluster_hierarchical('single',data_b,5);
fid=fopen('clusters_b.txt','wt');
fprintf(fid,'%d\n',idx_b1);
fclose(fid);

cluster_b10=find(idx_b1==1);
cluster_b20=find(idx_b1==2);
cluster_b30=find(idx_b1==3);
cluster_b40=find(idx_b1==4);
cluster_b50=find(idx_b1==5);

figure;
plot(data_b(cluster_b10,1),data_b(cluster_b10,2),'.r');
hold on; 
plot(data_b(cluster_b20,1),data_b(cluster_b20,2),'.b');
hold on;
plot(data_b(cluster_b30,1),data_b(cluster_b30,2),'.g');
hold on;
plot(data_b(cluster_b40,1),data_b(cluster_b40,2),'.m');
hold on;
plot(data_b(cluster_b50,1),data_b(cluster_b50,2),'.k');
title('data-b: single linkage');

% *************** spectral clustering ****************
idx_b2=cluster_spectral(data_b,5);

cluster_b11=find(idx_b2==1);
cluster_b21=find(idx_b2==2);
cluster_b31=find(idx_b2==3);
cluster_b41=find(idx_b2==4);
cluster_b51=find(idx_b2==5);

figure;
plot(data_b(cluster_b11,1),data_b(cluster_b11,2),'.r');
hold on; 
plot(data_b(cluster_b21,1),data_b(cluster_b21,2),'.b');
hold on;
plot(data_b(cluster_b31,1),data_b(cluster_b31,2),'.g');
hold on;
plot(data_b(cluster_b41,1),data_b(cluster_b41,2),'.m');
hold on;
plot(data_b(cluster_b51,1),data_b(cluster_b51,2),'.k');
title({['data-b: spectral cluster']; ['number of eigen vectors=', num2str(k)]});


% (c)>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% ***************** kmeans *******************
load data_c.txt;
idx_c=cluster_kmeans(data_c,5);

cluster_c1=find(idx_c==1);
cluster_c2=find(idx_c==2);
cluster_c3=find(idx_c==3);
cluster_c4=find(idx_c==4);
cluster_c5=find(idx_c==5);

figure;
plot(data_c(cluster_c1,1),data_c(cluster_c1,2),'.r');
hold on; 
plot(data_c(cluster_c2,1),data_c(cluster_c2,2),'.b');
hold on;
plot(data_c(cluster_c3,1),data_c(cluster_c3,2),'.g');
hold on;
plot(data_c(cluster_c4,1),data_c(cluster_c4,2),'.m');
hold on;
plot(data_c(cluster_c5,1),data_c(cluster_c5,2),'.k');
title('data-c: kmeans');

% *************** single linkage ****************
idx_c1= cluster_hierarchical('single',data_c,5);
cluster_c10=find(idx_c1==1);
cluster_c20=find(idx_c1==2);
cluster_c30=find(idx_c1==3);
cluster_c40=find(idx_c1==4);
cluster_c50=find(idx_c1==5);

figure;
plot(data_c(cluster_c10,1),data_c(cluster_c10,2),'.r');
hold on; 
plot(data_c(cluster_c20,1),data_c(cluster_c20,2),'.b');
hold on;
plot(data_c(cluster_c30,1),data_c(cluster_c30,2),'.g');
hold on;
plot(data_c(cluster_c40,1),data_c(cluster_c40,2),'.m');
hold on;
plot(data_c(cluster_c50,1),data_c(cluster_c50,2),'.k');
title('data-b: single linkage');

% *************** spectral clustering ****************

idx_c2=cluster_spectral(data_c,5);
fid=fopen('clusters_c.txt','wt');
fprintf(fid,'%d\n',idx_c2);
fclose(fid);

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
title({['data-c: spectral cluster']; ['number of eigen vectors=', num2str(k)]});

end

%% Helper functions
function y = cluster_kmeans(x,k)
%--------------------------------------------------------------------------
%
% Insert code for k-means clustering here. The inputs include the data (x)
% and the desired number of clusters (k). The output (y) is a vector
% containing a class label (an integer from 1:k) for each data point in x.
    y=kmeans(x,k,'Replicates',10);
%
%--------------------------------------------------------------------------
end

function y = cluster_hierarchical(link,x,k)
%--------------------------------------------------------------------------
%
% Insert code for hierarchical clustering here. The inputs include the 
% linkage function (link) which can either be 'single' or 'complete', the
% data (x), and the desired number of clusters (k). The output (y) is a 
% vector containing a class label (an integer from 1:k) for each data point
% in x.
%
%--------------------------------------------------------------------------
    switch link
        case 'single'
            Z= linkage(x,'single');
            y= cluster(Z,'maxclust',k);
        case 'complete'
            % Ignore this part for this assignment, no code needs to go here. 
    end
end

function y = cluster_spectral(x,k)
%--------------------------------------------------------------------------
%
% Insert code for spectral clustering here. The inputs include the data (x)
% and the desired number of clusters (k). The output (y) is a vector
% containing a class label (an integer from 1:k) for each data point in x.
%
N=size(x,1);
A=zeros(N,N);
D=zeros(N,N);
num=5;  %<<--define the number of eigen value here

% calculate similarity matrix
for i=1:N
    for j=1:N
        A(i,j)=gaussiandist(x(i,:),x(j,:),0.5);
        % the best performed sigma for (a) is 5;
        % the best performed sigma for (b) and (c) is 0.5;
    end
end
% calculate degree matrix
for i=1:N
    D(i,i)=sum(A(i,:));
end
% calculate normalized Laplacian matrix
L=eye(N)-D^(-0.5)*A*D^(-0.5);
[evectors, ~] = eig(L);

new_data=evectors(:,2:num+1);
y=kmeans(new_data, k);
%--------------------------------------------------------------------------
end

