function matrix = OneNN(train , test)
    temp = test;
    distance= [];
    for i=1 : size(test, 1)      % calculate the distance between one element of test per element of train
        k=1;
        nearestneighbor=[];
        for j=1 : size(train , 1)   
            test_distance = 0;
            for l =1 : (size(train,2)-1)
                test_distance = test_distance + (test( i ,l) - train(j,l))^2;
            end
            distance(k) = sqrt(test_distance);                   %distance between to elements
            k=k+1;
        end
        nearestneighbor = find(distance == min(distance));       %finde the index of nearest  neighbors
        temp(i,size(train,2))=train(nearestneighbor(1),size(train,2));                   %assinng label of nearestneighbor to test
    end
    matrix = temp;
end 