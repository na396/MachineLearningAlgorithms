clear;
load 'matlab_datasets';
[x,y]=selectingtestandtrain(iris,0.1);
dimention= size(iris,2)-1;
n = size(iris,2);
tree = ClassificationTree.fit(x(:,1:dimention),x(:,n));
view(tree,'mode','graph')
label = predict(tree,y(:,1:dimention));