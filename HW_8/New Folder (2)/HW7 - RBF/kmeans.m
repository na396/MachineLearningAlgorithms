function [iteration,clustermatrix,numberelementineachcluster] = kmeans(dataset,k)
    center_average = [];
    for a=1 : size(dataset,1)
        dataset(a,size(dataset,2))= 0;
    end 
    for b=1 : size(dataset,1)
        warning(b)= 1;
    end
    for i=1 : k
        indexarray(i) = rand();
        indexarray(i)= round(indexarray(i)*size(dataset,1));
        if indexarray(i) == 0
           while indexarray(i)== 0
               indexarray(i)= rand();
               indexarray(i)= round(indexarray(i)*size(dataset,1));
           end
           center(i,:)=dataset(indexarray(i),:);
        else center(i,:)=dataset(indexarray(i),:);
        end
    end
    for c=1 : k
        warning(indexarray(c))=0;
    end
    for g=1 : k
        dataset(indexarray(g),size(dataset,2))= g;
    end
    iterationcounter =1;
    distancetocenter = [];
    sw=0;
    while sw == 0 && iterationcounter <= 1000 
        countero=0;
        for d=1 : size(dataset,1)
            if warning(d)~=0
                 for e=1 : k
                       sumgoli =0;
                       for f=1 : size(dataset,2)-1
                         sumgoli = sumgoli + (center(e,f)-dataset(d,f))^2;
                       end
                       distancetocenter(e)= sqrt(sumgoli);
                 end
                 indexes=find( distancetocenter == min(distancetocenter));
                dataset(d,size(dataset,2))=indexes(1); 
            end
        end
        for c=1 : k
            if indexarray(c)~=-1
                warning(indexarray(c))=1;
            end
        end
        dataset = insertionsort_onlabels(dataset);
        t=1;
        clustercounter=1;
        while t < size(dataset,1)
            for sumcount=1:size(dataset,2)-1
                sumgoli(sumcount) =0;
            end
            cluster_name = dataset(t,size(dataset,2));
            tcounter = 0;
            while dataset(t,size(dataset,2))== cluster_name
                for rr=1: size(dataset,2)-1
                    sumgoli(rr) = sumgoli(rr)+ dataset(t,rr);
                end
                t = t+1;
                if t > size (dataset,1)
                    break;
                end
                tcounter = tcounter +1;
            end
            for hh=1:size(dataset,2)-1
                temp_centroo = center(clustercounter,hh);
                center(clustercounter,hh) = sumgoli(hh)/tcounter;
                if temp_centroo ==center(clustercounter,hh)
                    countero=countero+1;
                end
            end
            clustercounter = clustercounter+1;
        end
        if countero ==k
            sw=1;
        else
            for kk=1:size(center,1)
                tempoli = searchonarray(dataset,center(kk,:));
                if tempoli ~= 0
                    warning(tempoli)= 0;
                    indexarray(kk)=tempoli;
                else indexarray(kk)=-1;
                end
            end
            iterationcounter =iterationcounter+1;
        end
        
    end
    iteration = iterationcounter;
    clustermatrix = dataset;
    i=1;
    nc=0;
    m = size(dataset,1);
    n = size(dataset,2);
    numberelementineachcluster =zeros(1,k);
    boo = 0;
    while i < m
        currentcluster = clustermatrix(i,n);
        nc = nc + 1;
        start=i;
        boo = 0;
        while clustermatrix(i,n)==currentcluster
            i=i+1;
            boo = boo +1;
            if i > m
                break;
            end
            
        end
        numberelementineachcluster(1,nc)= boo;
        % i is the first of next
    end 
end