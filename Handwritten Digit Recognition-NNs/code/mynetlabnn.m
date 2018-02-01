%your solution goes into this file.
clc; clear;
hidden_node=500;
[training,testing] = setupMNIST();
NET = mlp(784, hidden_node, 10, 'logistic');
options = zeros(1,18);
options(1) = 0; %display iteration values
options(14) = 500; %maximum number of training cycles (epochs)

% train on all test data
train_data_num=60000;
test_data_num=1000;
%^^^^^^^^^^^change training and testing data number here 
train_output=zeros(train_data_num,10);
train_x=training.data(:,1:train_data_num);
train_y=training.labels(1:train_data_num,1);
test_x=testing.data(:,1:test_data_num);
test_y=testing.labels(1:test_data_num,1);
for i=1:train_data_num
classify_idx=train_y(i,1);
train_output(i,classify_idx+1)=1;
end
[NET, options] = netopt(NET, options, train_x', train_output, 'scg');

% ************* cross validation - k fold - k=4 ************************
% *********************************************************************
while(true)
split_num=rand(1,3)*train_data_num;
split_num=int32(split_num);
split_num=sort(split_num,'ascend');
length1=abs(split_num(1,1)-split_num(1,2));
length2=abs(split_num(1,2)-split_num(1,3));
length3=train_data_num-max(split_num);
length4=min(split_num);
    if (length1>100&&length2>100&&length3>100&&length4>100)
        break;
    end
end

NET1 = mlp(784, hidden_node, 10, 'logistic');
NET2 = mlp(784, hidden_node, 10, 'logistic');
NET3 = mlp(784, hidden_node, 10, 'logistic');
NET4 = mlp(784, hidden_node, 10, 'logistic');

group1_tr=train_x(:,split_num(1,1):train_data_num);
group1_tr_y=train_y(split_num(1,1):train_data_num,1);
group2_tr=train_x(:,[1:split_num(1,1) split_num(1,2):train_data_num]);
group2_tr_y=train_y([1:split_num(1,1) split_num(1,2):train_data_num],1);
group3_tr=train_x(:,[1:split_num(1,2) split_num(1,3):train_data_num]);
group3_tr_y=train_y([1:split_num(1,2) split_num(1,3):train_data_num],1);
group4_tr=train_x(:,1:split_num(1,3));
group4_tr_y=train_y(1:split_num(1,3),1);

data_num1=size(group1_tr);
data_num2=size(group2_tr);
data_num3=size(group3_tr);
data_num4=size(group4_tr);

g1_output=zeros(data_num1(1,2),10);
g2_output=zeros(data_num2(1,2),10);
g3_output=zeros(data_num3(1,2),10);
g4_output=zeros(data_num4(1,2),10);

for i=1:data_num1(1,2)
g1_idx=group1_tr_y(i,1);
g1_output(i,g1_idx+1)=1;
end

for i=1:data_num2(1,2)
g2_idx=group2_tr_y(i,1);
g2_output(i,g2_idx+1)=1;
end

for i=1:data_num3(1,2)
g3_idx=group3_tr_y(i,1);
g3_output(i,g3_idx+1)=1;
end

for i=1:data_num4(1,2)
g4_idx=group4_tr_y(i,1);
g4_output(i,g4_idx+1)=1;
end

%train on the four groups separately 
[NET1, options] = netopt(NET1, options, group1_tr', g1_output, 'scg');
[NET2, options] = netopt(NET2, options, group2_tr', g2_output, 'scg');
[NET3, options] = netopt(NET3, options, group3_tr', g3_output, 'scg');
[NET4, options] = netopt(NET4, options, group4_tr', g4_output, 'scg');
%*************************************************************************
%*************************************************************************

% testing...
test_output1=zeros(test_data_num,1);
train_output1=zeros(train_data_num,1);
g1_output1=zeros(data_num1(1,2),1);
g2_output1=zeros(data_num2(1,2),1);
g3_output1=zeros(data_num3(1,2),1);
g4_output1=zeros(data_num4(1,2),1);
test_err_n=0;
train_err_n=0;
g1_err_n=0;
g2_err_n=0;
g3_err_n=0;
g4_err_n=0;

% test on taining data
for i=1:train_data_num
Y2 = mlpfwd(NET, training.data(:,i)');
[~, idx_train]=max(Y2);
train_output1(i,1)=idx_train-1;
    if (train_output1(i,1)~=training.labels(i,1))
    train_err_n=train_err_n+1;
    end
end

% test on testing data and record the missclassified ones
j=1;
missclassify=zeros(784,test_data_num);
miss_idx=zeros(1,test_data_num);
for i=1:test_data_num
Y1 = mlpfwd(NET, testing.data(:,i)');
[~, idx_test]=max(Y1);
test_output1(i,1)=idx_test-1;
    if (test_output1(i,1)~=testing.labels(i,1))
    test_err_n=test_err_n+1;
    missclassify(:,j)=testing.data(:,i);
    miss_idx(1,j)=i;
    j=j+1;
    end
end

% test on validation data
for i=1:test_data_num
    G1 = mlpfwd(NET1, testing.data(:,i)');
    [~, idx_g1]=max(G1);
    g1_output1(i,1)=idx_g1-1;
    if (g1_output1(i,1)~=testing.labels(i,1))
    g1_err_n=g1_err_n+1;
    end
end

for i=1:test_data_num
    G2 = mlpfwd(NET2, testing.data(:,i)');
    [~, idx_g2]=max(G2);
    g2_output1(i,1)=idx_g2-1;
    if (g2_output1(i,1)~=testing.labels(i,1))
    g2_err_n=g2_err_n+1;
    end
end

for i=1:test_data_num
    G3 = mlpfwd(NET3, testing.data(:,i)');
    [~, idx_g3]=max(G3);
    g3_output1(i,1)=idx_g3-1;
    if (g3_output1(i,1)~=testing.labels(i,1))
    g3_err_n=g3_err_n+1;
    end
end

for i=1:test_data_num
    G4 = mlpfwd(NET4, testing.data(:,i)');
    [~, idx_g4]=max(G4);
    g4_output1(i,1)=idx_g4-1;
    if (g4_output1(i,1)~=testing.labels(i,1))
    g4_err_n=g4_err_n+1;
    end
end

% calculate error
test_error=test_err_n/test_data_num
train_error=train_err_n/train_data_num
avg_vld_err=0.25*(g1_err_n+g2_err_n+g3_err_n+g4_err_n);
validation_error=avg_vld_err/test_data_num

% draw image of missclassifications
j=5;
%^^ change missclassify case here
mis_cl=reshape(missclassify(:,j),28,28);
imagesc(mis_cl);
colormap(gray);
title('Missclassify example','fontsize',12);
a= testing.labels(miss_idx(1,j),1);
b=test_output1(miss_idx(1,j),1);
X=['Missclassify example: The label of this number should be ' ,...
    num2str(a) , ' but it is classified as ', num2str(b), '.' ];
disp(X); 

% draw image of correct case
figure;
k=15;
% ^^ change correctly classifies case here
while(true)
    if (test_output1(k,1)==testing.labels(k,1))
        correct_cl=reshape(testing.data(:,k),28,28);
        imagesc(correct_cl);
        colormap(gray);
        title('Correct example','fontsize',12);
        a1= testing.labels(k,1);
        X1=['Correct example: Correctly classified as ',num2str(a1) , '.' ];
        disp(X1);
       break;
    end
       k=k+1;
end


