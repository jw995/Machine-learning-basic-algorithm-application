function [training,testing] = setupMNIST()
% Load images and labels
training.data = loadMNISTImages('train-images.idx3-ubyte');
training.labels = loadMNISTLabels('train-labels.idx1-ubyte');

testing.data = loadMNISTImages('t10k-images.idx3-ubyte');
testing.labels = loadMNISTLabels('t10k-labels.idx1-ubyte');

% Randomly show some example images (each data column is a 28x28 image)
%--------------------------------------------------------------------------
%     ***UNCOMMENT THE FOLLOWING LINES TO DISPLAY EXAMPLE IMAGES***
%--------------------------------------------------------------------------
% figure(1);
% set(gcf,'Position',[100 100 400 400],'MenuBar','none','Toolbar','none','NumberTitle','off','Name','MNIST Dataset');
% set(gca,'Position',[-0.001 -0.001 1.002 1.002],'XLim',[1 28],'YLim',[1 28]);
% 
% for ii=randsample(size(train.data,2),10)'
%     imshow(reshape(train.data(:,ii),28,28));
%     text(1,1,num2str(train.labels(ii)),'FontSize',24,'Color','r','VerticalAlignment','cap');
%     pause(0.5)
% end
end

% Helper functions
% ----------------
function images = loadMNISTImages(filename)
%loadMNISTImages returns a 28x28x[number of MNIST images] matrix containing
%the raw MNIST images

fp = fopen(filename, 'rb');
assert(fp ~= -1, ['Could not open ', filename, '']);

magic = fread(fp, 1, 'int32', 0, 'ieee-be');
assert(magic == 2051, ['Bad magic number in ', filename, '']);

numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
numCols = fread(fp, 1, 'int32', 0, 'ieee-be');

images = fread(fp, inf, 'unsigned char');
images = reshape(images, numCols, numRows, numImages);
images = permute(images,[2 1 3]);

fclose(fp);

% Reshape to #pixels x #examples
images = reshape(images, size(images, 1) * size(images, 2), size(images, 3));
% Convert to double and rescale to [0,1]
images = double(images) / 255;
end
function labels = loadMNISTLabels(filename)
%loadMNISTLabels returns a [number of MNIST images]x1 matrix containing
%the labels for the MNIST images
fp = fopen(filename, 'rb');
assert(fp ~= -1, ['Could not open ', filename, '']);

magic = fread(fp, 1, 'int32', 0, 'ieee-be');
assert(magic == 2049, ['Bad magic number in ', filename, '']);

numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');

labels = fread(fp, inf, 'unsigned char');

assert(size(labels,1) == numLabels, 'Mismatch in label count');

fclose(fp);
end
