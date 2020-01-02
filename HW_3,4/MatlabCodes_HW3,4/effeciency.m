function performance = effeciency(test,matrix)
    counter =0 ;
    for i=1 : size(test,1)
        if test(i,size(test,2)) == matrix(i,size(test,2))
            counter=counter+1;
        end
    end
    performance = (counter /size(test,1))*100;
end