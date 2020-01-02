function [array_train , array_test] =selectingtestandtrain(dataset,testpercentage)
    testsize =ceil (testpercentage * size(dataset,1));    %size of test dataset
    temparraytest = round(size(dataset ,1)*(rand(testsize , 1)));
    for r=1: size(temparraytest,1)
        while temparraytest(r)== 0
            temparraytest(r) = round(size(dataset ,1)*(rand(1 , 1)));
        end
    end
    
    for i=1 : testsize
        if dataset(temparraytest(i),size(dataset,2))~=-1
        array_test(i,1:size(dataset,2)) = dataset(temparraytest(i),1:size(dataset,2));
        dataset(temparraytest(i),size(dataset,2))= -1;          %it shows that this item has chocen for test
        else
            sw = 0;
            while sw == 0
              temporary = round(size(dataset ,1)*(rand(1 , 1)));
              if temporary ~= 0
                     if dataset(temporary,size(dataset,2))~= -1
                       array_test(i,1:size(dataset,2)) = dataset(temporary,1:size(dataset,2));
                        dataset(temporary,size(dataset,2))= -1; 
                        sw = 1;
                     end
              end
            end
        end
    end
    k=1;
    for j=1 : size(dataset,1)
        if dataset(j,size(dataset,2)) ~= -1
            array_train(k,1:size(dataset,2)) = dataset(j, 1:size(dataset,2));
            k=k+1;
        end
    end
    
end