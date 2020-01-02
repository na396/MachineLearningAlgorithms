function [centers, variances, optweight] = RBF (tr,datasetcluster,LR,classes,numberofclusters)
    m = size(datasetcluster,1);
    n = size(datasetcluster,2);
    dimension = size(datasetcluster,2)-1;
    numberofclasses = size(classes,1);
    i=1;
    nc=0;
    %temp = zeros(numberofclusters,numberofclasses);
    errorarray=[];
    
    while i < m
        currentcluster = datasetcluster(i,n);
        nc = nc + 1;
        start=i;
        while datasetcluster(i,n)==currentcluster
            i=i+1;
            if i > m
                break;
            end
        end
        centers(nc,1:dimension)= mean (datasetcluster(start:i-1, 1 : dimension ));
        variances(nc,1:dimension)= var (datasetcluster(start:i-1, 1 : dimension ));
        % i is the first of next
    end
    numberofclusters = nc;
    weightedmatrix = rand(numberofclusters , numberofclasses);
    temp = zeros(numberofclusters,numberofclasses);
    for kkk=1:numberofclusters
        errorarray(kkk,1:numberofclasses)=0.0001;
    end
    sw=0; 
    while sw == 0
        for i = 1 : size(datasetcluster ,1 ) 
            target = zeros(1,size(classes,1));
            for classindex=1 : size(classes,1)
                if tr(i,n) == classes(classindex,1)
                    target(classindex) = 1;
                else
                    target(classindex) = 0;
                end
            end
            phi = zeros(1,numberofclusters);
            [bb bbb]=size(variances);
            for j =1 : numberofclusters
                diffrences = tr(i,1: dimension) - centers(j);
                magdif = norm(diffrences,2);
                rrr=norm(variances(j,1:dimension),2);
                phi(j)= exp(-magdif/(2*rrr));
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
                    weightedmatrix(L,K)=weightedmatrix(L,K)+ (LR*Delta(K)*phi(L));
                end
            end
        end
        difff =abs(temp - weightedmatrix);
        if difff < errorarray
            sw=1;  
        else
            temp = weightedmatrix;
        end
    end
    optweight = weightedmatrix;
end