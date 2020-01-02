function optimalweightedmatrix = XOR_GATE()


    trainingset = [ 0 0 0; 0 1 1; 1 0 1; 1 1 0];         %trainingset
    
    LR = 0.2;                                            %Learning Rate
    W = [0.7 ; -0.3; 0.5];                                   
    for i=1 : 15
        counter = 0;
        for j=1 : 4
            
            output =hardlim( W(1,1)*trainingset(j,1) + W(2,1)* trainingset(j,2) + W(3,1));
            
            
            if  output ~= trainingset(j,3)
                counter = counter +1;
                error = trainingset(j,3) - output  ;
                W = W + LR * error *  [trainingset(j,1);trainingset(j,2);1];
                
                
            end
            
            
        end
        if counter == 0
            break;
        end
        
    end
    
    for j=1 : 4
        output =hardlim( W(1,1)*trainingset(j,1) + W(2,1)* trainingset(j,2) + W(3,1));
        disp(output);
    end
    optimalweightedmatrix = W;

end