%NeuralNetwork
function [warning,net]= NN(data,LR, numberofhiddennodes, classes)
    warning = zeros(1,size(data,1));
    dimension = size(data,2)-1;
    n = size(data,2);
%     P = data(1:130,1:dimension);
%     T = data(1:130,n);
%     P=P';
%     T=T';
%     test=data(131:150,1:dimension);
%     test=test';
%     tp=data(131:150,n);
%     tp=tp';
    P = data(:,1:dimension);
    T = data(:,n);
    P=P';
    T=T';
    net = newff(minmax(P),[numberofhiddennodes 1],{'tansig' 'purelin'});
    %plot(P,T,P,Y,'o');
    net.trainParam.epochs = 1000;
    net.trainParam.lr = LR;
    net = train(net,P,T);
    Y = sim(net,P);  
    counter = 1;
    matchcounter = 1;
    mismatchcounter = 1;
    mat =[];
    dismat = [];
    while counter < size(data,1)
       temp = pdist2(Y(counter),classes(:,1));
       indextemp = find(temp == min(temp));
       if data(counter,n)== classes(indextemp,1)
           warning(counter)= 0;
       else
           warning(counter)= 1;
       end
       counter = counter + 1;
    end
end
