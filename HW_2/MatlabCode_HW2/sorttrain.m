function matrix = sorttrain(train, classes)
    
        function num = getclassnum(classes,name)
        
           for ll=1 : size(classes,1)
                     if classes(ll,1)==name
                           num = classes(ll,2);
                         break;
                     end
            end
        end
        temp=[];
    class_number = [];
    for j = 1: size(classes ,1 )
    class_number(j)= 0 ;
    end
    
    for i=1 : size(train,1)
        class_numb = getclassnum(classes,train (i,size(train,2 )));
       temp(class_numb,class_number(class_numb),1:size(train,2)) = train(i,1:size(train,2)) ;
       
 
    end
    matrix = temp(1,:,:);
    for k = 2 :size(class_number,1)
        matrix = [matrix;temp(k,:,:)];
        
    end
    
end