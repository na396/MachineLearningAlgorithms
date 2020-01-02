%Decision Tree
function [warning,tree]= DT(data, classes)
    warning = zeros(1,size(data,1));
    dimention= size(data,2)-1;
    n = size(data,2);
    tree = ClassificationTree.fit(data(:,1:dimention),data(:,n));
    %view(tree,'mode','graph')
    Y = predict(tree,data(:,1:dimention));
    counter = 1;
    matchcounter = 1;
    mismatchcounter = 1;
    mat =[];
    dismat = [];
    while counter <= size(data,1)
       temp = pdist2(Y(counter),classes(:,1));
       indextemp = find(temp == min(temp));
       if data(counter,n)== classes(indextemp(1),1)
           warning(counter)= 0; 
       else
           warning(counter)= 1;
       end
       counter = counter + 1;
    end
end