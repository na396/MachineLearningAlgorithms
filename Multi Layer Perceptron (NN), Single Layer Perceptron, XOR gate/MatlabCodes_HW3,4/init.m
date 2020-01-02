function [performance,numberofepoch] = init(inputmatrix,test, LR,n1, n2 , n3)
    
    classes = findclasses(inputmatrix);
    Error =[];
    
    [wl , winter, wr, wout]= initialweight(n1 ,n2, n3);
    epochcpounter =0;
    kerror = 1;
    num=1;
    Error=[];
    Epoch=[];
    sw=0;
    while sw==0 
        [wl, winter, wr, wout, kerror]= MLP(inputmatrix,LR ,n2, wl ,winter, wr, wout,n1,n3,classes);
        Error(num) = kerror;
        Epoch(num) = num;
        epochcpounter = epochcpounter + 1; 
        num=num+1;
        counter=num-1;
        if  num > 10 && abs(Error(counter)-Error(counter-1))< 0.00001%num == 300 
            sw=1;
        end
    end
    performance = evaluation(test, wl, winter, wr, wout, classes,n2,n1,n3);
    numberofepoch=epochcpounter;
    figure;
    plot(Epoch,Error);
    hold all;
end