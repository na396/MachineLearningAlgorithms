%boo
load 'matlab_datasets.mat';
data = iris;
dimension = size(data,2)-1;
n = size(data,2);
P = data(1:130,1:dimension);
T = data(1:130,n);
P=P';
T=T';
test=data(131:150,1:dimension);
test=test';
tp=data(131:150,n);
tp=tp';
net = newff(minmax(P),[5 1],{'tansig' 'purelin'});
%plot(P,T,P,Y,'o');
net.trainParam.epochs = 1000;
net = train(net,P,T);
Y = sim(net,test);
%plot(P,T,P,Y,'o')