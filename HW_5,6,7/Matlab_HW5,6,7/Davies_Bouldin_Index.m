function  Index = Davies_Bouldin_Index(dataset)
    dataset = insertionsort_onlabels(dataset);
    i=1;
    m= size(dataset,1);
    n = size(dataset,2);
    nc = 0;
    nci =[];
    si=[];
    vi =[];
    while i < m
        currentcluster = dataset(i,n);
        nc = nc + 1;
        sum = zeros(1,n-1);
        counter=0;
        start=i;
        while dataset(i,n)==currentcluster
            sum = sum + dataset(i,1:n-1);
            counter = counter + 1;
            i=i+1;
            if i > m
                break;
            end
        end
        nci(nc) = counter;
        vi(nc,1:n-1) = sum ./ counter;
        temp = 0;
        for j = start : i-1
            temp = temp + pdist2(dataset(j,1:n-1),vi(nc,:));
        end
        si(nc) =temp /counter;
        % i is the first of next
    end 
    vdis=[];
    Rij=[];
    Ri=zeros(1,nc);
    DB=0;
    for i=1 : nc
        for j=1 : nc
            if i == j
                vdis(i,j) = 0;
                Rij (i,j) = 0;
            else 
                vdis (i,j)= pdist2(vi(i),vi(j));
                Rij (i,j) = (si(i)+ si(j))/vdis (i,j);
                if Rij (i,j) > Ri(1,i)
                    Ri(1,i) = Rij (i,j);
                end
            end
        end
        DB = DB + Ri(1,i);
    end
    DB = DB / nc;
    Index= DB;
end