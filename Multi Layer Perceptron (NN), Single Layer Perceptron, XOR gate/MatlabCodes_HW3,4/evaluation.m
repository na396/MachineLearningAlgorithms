function performance = evaluation(test , optwl, optwinter, optwr, optwout,classes,n2,n1,n3)

    temp_test = test;
    for testindex=1 : size(test,1)
            for i=1 : n2
                sum = optwinter(i);
                for j=1 : n1
                     sum = sum + optwl(j,i)*test(testindex,j);  
                end
                o(i) = 1./(1 + exp(-sum)) ;
            end  
        
            for i=1 : n3
                sum = optwout(i);
                for j=1 : n2
                     sum = sum + optwr(j,i) * o(j);  
                end
                olast(i) = 1./(1 + exp(-sum)) ;
            end
            
            max_index = find(olast == max(olast));
            
%             for j=1 : n3
%                 distance(j) = abs(test(testindex,size(test,2))- classes(j,1));%olast(j)
%                 distance_class(j)= classes(j,1);
%             end
%             min_index = find(distance == min(distance));
            temp_test(testindex,size(test,2)) = classes(max_index(1),1);

    end
    performance = effeciency(test,temp_test);
    
end