function stoppingepoch = earlystoppingmethod(train, LR, n1, n2, n3)
    
   class = findclasses(train);
   [trainingsample,validationsample] = selectingtestandtrain(train,0.8);
   [t1, t2, t3, t4]= initialweight(n1 ,n2, n3);
   s1=t1;
   s2=t2;
   s3=t3; 
   s4=t4;
   
   for kk=1 : 300
        [p1, p2, p3, p4, error_training] = MLP(trainingsample, LR,n2,t1,t2,t3,t4,n1,n3,class);
        [s1, s2, s3, s4, error_validation] = MLP(validationsample, LR,n2,t1,t2,t3,t4,n1,n3,class);
        example(1,kk)= error_training;
        example(2,kk)= error_validation;
        epoche(kk)=kk;
        t1=p1; 
        t2=p2; 
        t3=p3;
        t4=p4;
   end
   plot(epoche,example(1,:)); 
   hold all; 
   plot(epoche,example(2,:));
   stoppingepoch =10;
end