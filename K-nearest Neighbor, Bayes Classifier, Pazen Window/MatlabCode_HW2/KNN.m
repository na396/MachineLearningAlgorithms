function matrix = KNN(train , test,kParam,dataset_num)
    
    
    function sortarray=insertionsort(array)
        for m=2 :size(array,1)                                                             %insertionsort( line 14 to 25)
     
          key = array(m,1); 
          r = m-1;
          while r>0 && key < array(r,1) 
             array(r+1,1)=array(r,1);
             array(r+1,2)=array(r,2);
             r = r-1;
          end
          array(r+1,1) = key; 
          array(r+1,2) = m;
          
       end
        sortarray =array;
    end
    
    if dataset_num == 3 || dataset_num == 4 || dataset_num == 5
        train = insertionsort_onlabels(train);
    end
    temp = test;
    dataclass= findclasses(train);
    
    for i=1 : size(test, 1)      % calculate the distance between one element of test per element of train
        l=1;
        
        for j=1 : size(train , 1)        
            tempdistance=0; 
            for k=1:size (test,2)-1
                tempdistance = tempdistance+ ( (test( i ,k) - train(j,k))^2); %distance between to elements
            end
            tempdistance = sqrt(tempdistance);
            distance(l,1)=tempdistance;
            distance(l,2)=j;
            l=l+1;
        end
     % class_Number  
     % func out matrix n*2 n= class_number ; out matrix=classes
     % func getclassnum out : int  in = matrix n*2
     
     dummy =insertionsort(distance);
     for ii=1: size(dataclass,1)
         dataclass(ii,2)=0;
     end
     summtion =0 ;
     %l=l-1;
     for t=1 : kParam 
         summtion = summtion+ dummy(t,1);   
         for x =1 : size(dataclass , 1)
             if dataclass(x,1) == train(dummy(t,2),size(train ,2 ));
                 dataclass(x,2)=dataclass(x,2)+1;
             end  
         end 
            
     end 
     
        maxdata = find (dataclass(: ,2)== max(dataclass(:,2) ));
        if summtion == 0 
        temp(i,size(test,2)) =-1;
        elseif size(maxdata)==1
            temp(i,size(test,2)) = dataclass(maxdata(1),1);%
        else
        
        average = summtion /kParam ;
        
        for t=1 : kParam
           averagearray(t,1) = abs(dummy(t,1)-average);
           averagearray(t,2) = dummy(t ,2);
        end
        label = insertionsort(averagearray);
        temp(i,size(test,2))=train(label(1,2),size(train,2));                   %assinng label of nearestneighbor to test
        end
    end
    matrix = temp;
end