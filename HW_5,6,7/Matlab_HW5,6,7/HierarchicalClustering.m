function [outputtable, numberelementineachcluster] = HierarchicalClustering(dataset , k)
    orgindataset = dataset;
    for i=1 : size(dataset,1)
       dataset(i,size(dataset,2)) = 0;
    end
    
    m= size(dataset,1);
    n = size(dataset,2);
    dimension = size(dataset,2)-1;
    clusternumberII = 0;
    clusternumberI = size(dataset,1);
    clusters=zeros(m,n);
    for h=1 : m
       warning(h) = 0;
    end
    for h=m+1 : 2*m
       warning(h) = 2;
    end
    dataset= [dataset;clusters];
    used = 0 ;
    while clusternumberI > k
        fakedistance = pdist(dataset(1:m+clusternumberII,1:dimension));
        distance = squareform (fakedistance);
        MinandIndexes = MinwithIndex(distance,warning); 
        tempo=1;
        
        if dataset(MinandIndexes(tempo,1),n) ~= 0 || dataset(MinandIndexes(tempo,2),n) ~= 0 
            if dataset(MinandIndexes(tempo,1),n) ~= 0 && dataset(MinandIndexes(tempo,2),n) ~= 0 
                clusternumberII = clusternumberII +1;    
                currentcluster = clusternumberII;
                for tt = 1: m+used 
                    if dataset(tt,n) == dataset(MinandIndexes(tempo,1),n) || dataset(tt,n) == dataset(MinandIndexes(tempo,2),n)
                        dataset(tt,n) = currentcluster;
                    end
                end
            else if dataset(MinandIndexes(tempo,1),n) ~= 0
                    currentcluster = dataset(MinandIndexes(tempo,1),n);
                else 
                    currentcluster = dataset(MinandIndexes(tempo,2),n);
                end
            end
        else
            clusternumberII = clusternumberII +1;
            currentcluster = clusternumberII;
        end
        if MinandIndexes(tempo,1)> m
            warning(MinandIndexes(tempo,1))= 2;
        else
            warning(MinandIndexes(tempo,1))= 1;
        end
        if MinandIndexes(tempo,2)> m
            warning(MinandIndexes(tempo,2))= 2;
        else
            warning(MinandIndexes(tempo,2))= 1;
        end
        dataset(MinandIndexes(tempo,1),size(dataset,2))= currentcluster;
        dataset(MinandIndexes(tempo,2),size(dataset,2))= currentcluster;
        emptyIndex= find(warning==max(warning));
        if emptyIndex(1)> used
            used = emptyIndex(1)-m;
        end
        dataset(emptyIndex(1),1:dimension) = (dataset(MinandIndexes(tempo,1),1:dimension)+dataset(MinandIndexes(tempo,2),1:dimension))/2;
        warning(emptyIndex(1))= 0; 
        dataset(emptyIndex(1),n)= currentcluster;
        clusternumberI = clusternumberI - 1;  
            if clusternumberI<9 && clusternumberI> 3
                    outputtable = insertionsort_onlabels(dataset(1: size(orgindataset,1), :));
            i=1;
            nc=0;
            m = size(orgindataset,1);
            n = size(orgindataset,2);
            numberelementineachcluster =zeros(1,k);
            boo = 0;
            while i < m
                currentcluster = outputtable(i,n);
                nc = nc + 1;
                boo = 0;
                while outputtable(i,n)==currentcluster
                    i=i+1;
                    boo = boo +1;
                    if i > m
                        break;
                    end
                end
                numberelementineachcluster(1,nc)= boo; 
                % i is the first of next
            end
            numberelementineachcluster
            davis =Davies_Bouldin_Index(outputtable);
            davis
            [RMSSDT,RS] = RMSSDT_and_RS(outputtable);
            RMSSDT
            RS
            end
    end
      
%     outputtable = insertionsort_onlabels(dataset(1: size(orgindataset,1), :));
%     i=1;
%     nc=0;
%     m = size(orgindataset,1);
%     n = size(orgindataset,2);
%     numberelementineachcluster =zeros(1,k);
%     boo = 0;
%     while i < m
%         currentcluster = outputtable(i,n);
%         nc = nc + 1;
%         boo = 0;
%         while outputtable(i,n)==currentcluster
%             i=i+1;
%             boo = boo +1;
%             if i > m
%                 break;
%             end
%         end
%         numberelementineachcluster(1,nc)= boo; 
%         % i is the first of next
%     end
end