function Index = S_Dbw_Validity_Index(dataset)
    dataset = insertionsort_onlabels(dataset);
    i=1;
    m = size(dataset,1);
    n = size(dataset,2);
    nc = 0;
    nci =[];
    vi =[];
    Vari=[];
    meanvector = mean(dataset(:,1:n-1));
    varvector =var(dataset(:,1:n-1)); 
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
        Vari(nc,:) = var(dataset(start:i-1,1:n-1));
    end
    vardown = norm (varvector);
    varup=zeros(1,nc);
    sumvarup=0;
    for k=1: nc 
        varup(k) = norm(Vari(k,:));
        sumvarup = sumvarup + varup(k);
    end
    
    Scatt = sumvarup/(vardown*nc);
    stdev = sqrt(sumvarup)/nc;
    % compute Dens_bw
    Dens_bw = 0;
    tempDens=0;
    for i=1 :nc
        for j=1: nc
            if i~=j
                Uij  = (vi(i,1:n-1) + vi(j,1:n-1))/2;
                tempDens = tempDens +  density(Uij,stdev,dataset)/max(density(vi(i,1:n-1),stdev,dataset),density(vi(j,1:n-1),stdev,dataset));
            end
        end
    end
    Dens_bw = tempDens/(nc*(nc-1));
    % Result
    Index = Scatt + Dens_bw;
end