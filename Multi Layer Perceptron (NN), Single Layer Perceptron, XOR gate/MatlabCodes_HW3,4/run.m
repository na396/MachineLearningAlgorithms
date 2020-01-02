function performance = run(inputmatrix, LR,n1, n2 , n3)
    classes =  findclasses(inputmatrix);
    Error =[]; 
     
    [train,validation]=selectingtestandtrain(inputmatrix, 0.25);
    [wl , winter, wr, wout]= initialweight(n1 ,n2, n3);
    kerror = 1;
    num=1;
    Error=[];
    sw=0;
    while sw==0 
        [wl, winter, wr, wout, kerror]= MLP(train,LR ,n2, wl ,winter, wr, wout,n1,n3,classes);
        Error(num) = kerror;
        Epoch(num) = num;
        num=num+1;
        counter=num-1;
        if  num > 10 && abs(Error(counter)-Error(counter-1))< 0.00001
                sw=1;
        end
    end
        performance = evaluation(validation, wl, winter, wr, wout, classes,n2,n1,n3); 
        %plot(Epoch,Error);
        %hold all;
    
end