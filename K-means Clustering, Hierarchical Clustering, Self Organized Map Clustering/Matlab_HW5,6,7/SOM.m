function [iteration,clusters,numberelementineachcluster] = SOM (dataset,k)
    orgindataset = dataset;
    for q=1 : size(dataset,1)
        dataset(q,size(dataset,2))= -1;
    end
    dimensions = size(dataset,2)-1;
    for m= 1 : k
        for n=1 : dimensions
            error_array(m,n) = 0.0001;
            temp_matrix(m,n) = 0;
        end
    end
    weightedmatrix = rand(k,dimensions);
    numberofepoch = 1;
    LR = 0.8;
    sw = 0;
    while sw == 0 
        for i=1 : size(dataset,1)
            distancetocenter = [];
            for j=1 : k
                summ =0;
                for r=1 : dimensions
                   summ = summ +((dataset(i,r)- weightedmatrix(j,r))^2);
                end
                distancetocenter(j)=summ; 
            end
            winner = find(distancetocenter == min(distancetocenter));
            weightedmatrix(winner,:) = weightedmatrix(winner, :) + LR*(dataset(i,1:dimensions)- weightedmatrix(winner, :));
        end
        if weightedmatrix == temp_matrix    %error_array
                sw = 1;
        end
        temp_matrix = weightedmatrix; 
        numberofepoch = numberofepoch +1;
        if LR > 0.1 
           LR = LR - 0.125 ;
        end    
    end
   for p=1 : size(dataset,1)
        distancetocenter = [];
        for j=1 : k
                summ =0;
                for r=1 : dimensions
                   summ = summ +((dataset(p,r)- weightedmatrix(j,r))^2);
                end
                distancetocenter(j)=summ; 
        end
        dataset(p,size(dataset,2)) = find(distancetocenter == min(distancetocenter));
    end
    clusters = insertionsort_onlabels(dataset);
    i=1;
    nc=0;
    m = size(dataset,1);
    n = size(dataset,2);
    numberelementineachcluster =zeros(1,k);
    boo = 0;
    while i < m
        currentcluster = clusters(i,n);
        nc = nc + 1;
        start=i;
        boo = 0;
        while clusters(i,n)==currentcluster
            i=i+1;
            boo = boo +1;
            if i > m
                break;
            end
            
        end
        numberelementineachcluster(1,nc)= boo;
        % i is the first of next
    end 
    iteration = numberofepoch-1;
end