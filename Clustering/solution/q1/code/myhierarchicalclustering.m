clear; clc; close all hidden

%% Compute 4 full dendrograms
%   Dendrogram#     Similarity      Linkage
%-------------------------------------------
%       1           Euclidean       Max Distance--complete linkage
%       2           Euclidean       Mean Distance--average linkage
%       3           Euclidean       Min Distance--single linkage
%       4           Cosine            Max Distance
%       5           Cosine            Mean Distance
%       6           Cosine            Min Distance

load data.txt
N = size(data,1); %number of data points
Num=N-1;         % layers of cluster-->N-1
Z1 = zeros(Num,3); %matrix to represent cluster tree (similar to output from LINKAGE)
m1 = cell(N,1);
for i=1:N %initialize clusters
    m1{i}=i; 
end
%set temporary clusters
temp1 = m1; md1 = m1;

for k=1:Num
    D1 = zeros(N-k+1,N-k+1); %preallocate similarity matrix
    for A=1:size(D1,1)
        for B=1:size(D1,2)
            S1 = zeros(length(temp1{A})*length(temp1{B}),1); %preallocate the individual similarities
            ind = 1;
            %"YCH" Populate S1 vector as the Euclidian distance
            %between the entries in temp1's. Don't forget to increment ind 
                A_new=temp1{A,1};
                B_new=temp1{B,1};
                for i=1:size(A_new,2)
                    for j=1:size(B_new,2)
                        A_idx=A_new(1,i);
                        B_idx=B_new(1,j);
                        ind=(j-1)*size(A_new,2)+i;
                        % ********** change distance matrix here >>>>>>>>>>
                        % >>Euclidean Method
                        S1(ind,1)=sqrt((data(A_idx,1)-data(B_idx,1))^2+...
                            (data(A_idx,2)-data(B_idx,2))^2);
                        % >>Cosine Method
%                         S1(ind,1)=-((data(A_idx,1)*data(B_idx,1)+data(A_idx,2)*data(B_idx,2))/...
%                             (sqrt(data(A_idx,1)^2+data(A_idx,2)^2)*...
%                             sqrt(data(B_idx,1)^2+data(B_idx,2)^2)))+1;
                        % *************************************************
                    end
                end
 % **************change hierarchical linkage method here ******************
            D1(A,B) = max(S1)*(A~=B); %maximum linkage distance--complete linkage
            %D1(A,B) = mean(S1)*(A~=B); %mean linkage distance--average linkage
            %D1(A,B) = min(S1)*(A~=B); %minimium linkage distance--single linkage
% ***********************************************************************************
        end
    end
    %test = find(D2~=D2');
    V1 = squareform(D1,'tovector'); %vector version of similarity matrix D
   
    [j1,i1] = ind2sub([N-k+1,N-k+1],find(D1==min(V1),1)); %find the closest pair of clusters
    Z1(k,3) = min(V1); %set the level of the cluster tree
    removecluster1 = [i1,j1]; %don't use these clusters anymore, they have been merged
    
    %Update the next level of clusters
    M1 = temp1; temp1 = cell(N-k,1);
    index1 = 0;
    for i=1:N-k+1 %remove the merged clusters
        if ~any(i==removecluster1)
            index1 = index1+1;
            temp1{index1} = M1{i};
        end
    end
    %Add the new cluster to the end of the group (this actually adds original data points)
    temp1{end} = [M1{i1} M1{j1}]; 
 
    %Add the new cluster to the end of the group m# (this adds the cluster
    %index, not the original data points contained in a cluster)
    %"YCH"
    for i=1:size(md1,1)
        p=isequal(md1{i},M1{i1});
        q=isequal(md1{i},M1{j1});
        if (p==1)
            I1=i;
        end
        if (q==1)
            J1=i;
        end
    end
    
    %update m1, Z1, md1
    m1{end+1} = [I1,J1]; 
    Z1(k,1:2) = [I1,J1]; 
    md1{end+1} = [M1{i1} M1{j1}];
end

%Sort the clusters (not necessary)
for i=1:length(m1)
    m1{i} = sort(m1{i});
end

%Plot the dendrograms
% 1-Euclidean-Max Distance-complete linkage
close all
figure(1); 
[H,T] = dendrogram(Z1,'colorthreshold',0.9*(max(Z1(:,3))));
set(H,'LineWidth',2); set(1,'Name','1 - My Dendrogram','NumberTitle','off');
%title('1-Euclidean-Max Distance-complete linkage');

% 2-Euclidean-Mean Distance-average linkage
%title('2-Euclidean-Mean Distance-average linkage');

% 3-Euclidean-Min Distance-single linkage
%title('3-Euclidean-Min Distance-single linkage');

% 4-Cosine-Max Distance-complete linkage
%title('4-Cosine-Max Distance-complete linkage');

% 5-Cosine-Mean Distance-average linkage
%title('5-Cosine-Mean Distance-average linkage');

% 6-Cosine-Min Distance-single linkage
title('6-Cosine-Min Distance-single linkage');

% ********************* solution for (b) ***********************
% T = cluster(Z1,'maxclust',2);
final_1=M1{1};
final_2=M1{2};
figure();
plot(data(final_1, 1),data(final_1,2),'*r');
hold on;
plot(data(final_2, 1),data(final_2,2),'xb');



%% PART 1.2: Compute accuracy of clustering using...
%       similarity measure - Euclidean distance
%       linkage measure - maximum linkage distance
%       stopping criterion - number (2)

load labels.txt
predicted = zeros(N,1); %initialize the predicted labels

%Find the point at which the data is separated into two clusters
for i=2:length(md1)
    if length(md1{i})+length(md1{i-1})==N %ideal case
        label1 = i;
        label2 = i-1;
    elseif length(md1{i})+length(md1{i-1})>N %the dendrogram could have inconsistencies
        for j=1:i-1
            if length(md1{i})+length(md1{i-j})==N
                label1 = i;
                label2 = i-j;
                break
            end
        end
    end
end
%Arbitrarily set labels
predicted(md1{label1}) = 1;
predicted(md1{label2}) = 2;

%Compute accuracy
accuracy = max([sum(predicted==labels)/N*100,sum(predicted~=labels)/N*100])

