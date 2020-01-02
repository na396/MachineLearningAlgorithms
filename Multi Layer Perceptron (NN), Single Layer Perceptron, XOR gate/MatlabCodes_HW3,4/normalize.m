function matrix = normalize(train)
    
   average = mean(train( : , 1 : size(train,2)-1 )); 
   variance = var(train( :  , 1 : size(train,2)-1));
   standard_dev = sqrt(variance);
   temp = train;
   
   for i=1 : size(train,1)
        for j=1 : size(train,2)-1
            temp(i,j)= (train(i,j)-average(j))/standard_dev(j);
        end
   
   end
   
    matrix =temp;
end