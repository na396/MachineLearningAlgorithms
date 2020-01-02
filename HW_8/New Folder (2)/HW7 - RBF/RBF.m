function [centers, variances, optweight] = RBF (dataset,LR,classes)
    m = size(dataset,1);
    n = size(dataset,2);
    dimension = size(dataset,2)-1;
    numberofclasses = size(classes,1);
    numberofclusters = dimension;
    i=1;
    nc=0;
    while i < m
        currentcluster = dataset(i,n);
        nc = nc + 1;
        start=i;
        while dataset(i,n)==currentcluster
            i=i+1;
            if i > m
                break;
            end
        end
        centers(nc,1:dimension)= mean (dataset(start:i-1, 1 : dimension ));
        variances(nc,1:dimension)= var (dataset(start:i-1, 1 : dimension ));
        % i is the first of next
    end
    weightedmatrix = rand(numberofclusters , numberofclasses);
    temp = zeros(numberofclusters,numberofclasses);
    sw=0;
    while sw == 0
        for i = 1 : size(dataset ,1 ) 
            target = zeros(1,size(classes,1));
            for classindex=1 : size(classes,1)
                if dataset(i,n) == classes(classindex,1)
                    target(classindex) = 1;
                else
                    target(classindex) = 0;
                end
            end
            phi = zeros(1,numberofclusters);
            for j =1 : numberofclusters
                diffrences = dataset(i,1: dimension) - centers(j);
                magdif = norm(diffrences,2);
                phi(j)= exp(-magdif/(2*norm(variances(j,1:dimension),2)));
            end
            output =zeros(1,numberofclasses);
            Delta =zeros(1,numberofclasses);
            for p=1 : numberofclasses
                for q=1 : numberofclusters
                    output(p)= output(p)+ weightedmatrix(q,p)* phi(q);
                end
                %output(p) = 1./(1+exp(-output(p)));
                error(p) = target(p) - output(p);
                Delta(p) = error(p);
            end
            %update weight
            for K=1: numberofclasses
                for L=1: numberofclusters
                    weightedmatrix(L,K)=weightedmatrix(L,K)+ (LR*Delta(K)*output(K));
                end
            end
        end
        if temp==weightedmatrix
            sw=1;
        else
            temp = weightedmatrix;
        end
    end
    optweight = weightedmatrix;
end