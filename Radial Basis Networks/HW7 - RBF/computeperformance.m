function performance = computeperformance(centers, variances, optweight,test,classes)
    counter=0;
    dimension = size(test,2)-1; 
    numberofclusters = size(centers,1);
    numberofclasses = size(optweight,2);
    for i=1: size(test,1)
        phi = zeros(1,numberofclusters);
        for j =1 : numberofclusters
            diffrences = test(i,1: dimension) - centers(j);
            magdif = norm(diffrences,2);
            phi(j)= exp(-magdif/(2*norm(variances(j,1:dimension),2)));
        end
        output =zeros(1,numberofclasses);
        for p=1 : numberofclasses
            for q=1 : numberofclusters
                output(p)= output(p)+ optweight(q,p)* phi(q);
            end
        end
        MaxIndex = find(output==max(output));
        if test(i,size(test,2))==classes(MaxIndex(1),1)
            counter= counter+1;
        end
    end
    performance = (counter/size(test,1))*100; 
end
