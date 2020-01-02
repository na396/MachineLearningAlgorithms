function matrix = ParzenWindows(train , test,dataset_num, inputh)
    

    if dataset_num == 3 || dataset_num == 4 || dataset_num == 5
        train = insertionsort_onlabels(train);
    end
    
    class_names = findclasses(train);
    
 function sortarray=insertionsort(array)           %insertionsort( line 14 to 25)
        for m=2 :size(array,1)                            
     
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
    
    temp = test;
    for i=1 : size(test, 1)      % calculate the distance between one element of test per element of train
      k=1;
      
       for j=1 : size(train , 1)        
            test_distance = 0;
            for l =1 : (size(train,2)-1)
                test_distance = test_distance + (test( i ,l) - train(j,l))^2;
            end
            distance(k,1) = sqrt(test_distance);                   %distance between to elements
            distance(k,2) = j;
            k=k+1;
            
        end
        
   dummy =insertionsort(distance);
   l=1;
   h= inputh; 
   for kk=1:size(class_names,1)
       class_names(kk,2) = 0;
   end
   summtion =0 ; 
   while dummy(l,1)<= h
     summtion = summtion+ dummy(l,1);
      for x =1 : size(class_names , 1)
          if class_names(x,1) == train(dummy(l,2),size(train ,2 ));
              class_names(x,2)=class_names(x,2)+1;
              
          end  
      end
      l=l+1;
   end 
   indexofmax=[];
   indexofmax = find(class_names(: ,2)== max(class_names(:,2) ));
   if summtion == 0
      temp(i,size(test,2))= -1; 
   elseif size(indexofmax) == 1
     temp(i,size(test,2))= class_names(indexofmax(1),1);  
   else
       average = summtion /(l-1) ;
        
        for t=1 : l-1
           averagearray(t,1) = abs(dummy(t,1)-average);
           averagearray(t,2) = dummy(t ,2);
        end
        label = insertionsort(averagearray);
        temp(i,size(train,2))=train(label(1,2),size(train,2));                   %assinng label of nearestneighbor to test

       
   end
   
   
    end
   
    
    matrix = temp;
end
