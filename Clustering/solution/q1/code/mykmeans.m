clear; clc; close all hidden

% Kmeans method
load data.txt;
N = size(data,1); %number of data points
data_idx=(1:30)';
% split data into two groups A and B
idx=randperm(N);
idx=idx(1:0.5*N);
A=data(idx,:);
A_idx=idx';
B=data;
B(idx,:)=[];
B_idx=data_idx;
B_idx(idx,:)=[];

k=10; %set steps 
center=zeros(k,4);
for m=1:k
center(m,1)= mean(A(:,1));
center(m,2)= mean(A(:,2));
center(m,3)= mean(B(:,1));
center(m,4)= mean(B(:,2));

    for i=1:N
        
        S1=zeros(1,2);
     % >>>>>>>>>>>change distance matrix here >>>>>>>>>>>>>
     % >>Euclidean Method
%         S1(1,1)=sqrt((data(i,1)-center(m,1))^2+(data(i,2)-center(m,2))^2);
%         S1(1,2)=sqrt((data(i,1)-center(m,3))^2+(data(i,2)-center(m,4))^2);
%         [~,index]=min(S1);
     % >>Cosine Method
        S1(1,1)=(data(i,1)*center(m,1)+data(i,2)*center(m,2))/...
               (sqrt(data(i,1)^2+data(i,2)^2)*sqrt(center(m,1)^2+center(m,2)^2));
        S1(1,2)=(data(i,1)*center(m,3)+data(i,2)*center(m,4))/...
               (sqrt(data(i,1)^2+data(i,2)^2)*sqrt(center(m,3)^2+center(m,4)^2));
        [~,index]=max(S1);
     % >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
       
        if (index==1) % closer to center A
            if (any(B_idx==i)) % previously in B cluster 
                remove_B=find(B_idx==i);
                B_idx(remove_B)=[];
                A_idx(end+1)=i;
                % add and delete data
                A(end+1,:)=B(remove_B,:);
                B(remove_B,:)=[];
            end
        end
        if (index==2) % closer to center B
            if (any(A_idx==i)) % previously in A cluster 
                remove_A=find(A_idx==i);
                A_idx(remove_A)=[];
                B_idx(end+1)=i;
                % add and delete data
                B(end+1,:)=A(remove_A,:);
                A(remove_A,:)=[];
            end
        end
    end
    
end


% test accuracy
load labels.txt
predicted = zeros(N,1); %initialize the predicted labels
right=0;
for i=1:N
    if (any(A_idx==i))
        predicted(i,1)=1;
    else
        predicted(i,1)=2;
    end
    if (predicted(i,1)==labels(i,1))
        right=right+1;
    end
end
accuracy=right/N*100;
% in case the labels are assigned conversely
if (accuracy<50)
    right=0;
    for i=1:N
         if (any(A_idx==i))
             predicted(i,1)=2;
         else
             predicted(i,1)=1;
         end
         if (predicted(i,1)==labels(i,1))
             right=right+1;
         end
    end
end
accuracy=right/N*100

figure();
[final_1,~]=find(predicted==1);
[final_2,~]=find(predicted==2);
plot(data(final_1, 1),data(final_1,2),'*r');
hold on;
plot(data(final_2, 1),data(final_2,2),'xb');




