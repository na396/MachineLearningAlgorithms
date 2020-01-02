function matrix = Bayes(train, test, dataset_num)
 
    if dataset_num == 3 || dataset_num == 4 || dataset_num == 5
        train=insertionsort_onlabels(train);
    end
    
   
    k =1;                                 %index of array_parameter 
    class_name = [];                      %Array of name of the classes               
   
    i=1;                                 
    while i < size(train,1)               % while loop 5- 30 defining each class seprately and caculating parameteres for each class
    class_counter =1;
    class = train (i,size(train,2));
    l=1;
    while class == train (i,size(train,2))            %while loop 10-18 categorying each class
          temp (l,1:size(train,2)-1)= train(i,1:size(train,2)-1);
          i = i+1;
          l=l+1;
          class_counter = class_counter +1;
          if i>size(train,1)
              break;
          end
    end
     % calculating following parameters for each class:                       %indexes:
     array_parameter1(k,1:size(train,2)-1)= mean (temp);                      %1:mean
     array_parameter2(k,1:size(train,2)-1,1:size(train,2)-1)= cov(temp);      %2:covarance
     array_parameter3(k,1:size(train,2)-1,1:size(train,2)-1)= inv(cov(temp)); %3:inverse
     array_parameter4(k) = trace(logm(cov(temp)));                            %4:logdet
     array_parameter5(k) = class_counter / size(train , 1);                   %5:prior
     temp =[];           
     class_name(k )= train(i-1,size(train,2));
     k =k+1;
     
    end
    
    
    function mat = repmatman(array)            %This function extending an matrix to specific size by repeating elements
        tempman=[];
        for n=1:size(test,1)
            tempman(1:size(test,2)-1,n) = array(1:size(test,2)-1,1);
        end
        mat=tempman;
    end


    class_number=k -1;
    for x=1:size(test,1)                     %seperate label of each point from test matrix
        test_points(x,1:size(test,2)-1)= test(x,1:size(test,2)-1);
    end
    
    dummy = transpose(test_points);
    for r = 1 : class_number
        input= transpose(array_parameter1(r,1:size(train,2)-1));
        temporary = repmatman(input);
        d(r, 1:size(train,2)-1,1:size(temporary,2))= dummy - temporary;
    end
    
    function deletedmatrix  =  removeonedimension(matrix)  % this function delete one dimension
    
        for o =1: size(matrix,2)
            for p =1: size(matrix,3)
                t(o,p) = matrix(1,o,p); 
            end
        end
        deletedmatrix = t;
    end


    for x=1 : size(test,1)
         
            for j=1 : class_number
                m = array_parameter3(j ,1:size(train,2)-1,1:size(train,2)-1 );
                mm = removeonedimension(m);
                d1 = d(j,1:size(train,2)-1 ,x);
                d2 = d(j,1:size(train,2)-1 ,x);
                md1= removeonedimension(d1);
                md2= removeonedimension(d2);
                part1= transpose(md1) * mm * md2  ;  
                %part2= array_parameter4(j)-2*log(array_parameter5(j));
                array_g(j) = -(size(train,2)-1)/2 * log (2*pi)- array_parameter4(j)/2 - 1/2*(part1)+log(array_parameter5(j));
            end
            index_test= find(array_g == max(array_g));
            test(x,size(test,2))=class_name(index_test); 
     end
    matrix=test;

end 