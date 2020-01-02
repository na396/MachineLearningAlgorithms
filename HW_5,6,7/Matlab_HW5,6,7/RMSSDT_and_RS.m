function  [RMSSDT,RS] = RMSSDT_and_RS(dataset)
    dataset = insertionsort_onlabels(dataset);
    i=1;
    m= size(dataset,1);
    n = size(dataset,2);
    nc = 0;
    nci =[];
    SSw=0;
    SSt=0;
    %si=[];
    vi =[];
    sigma=0;
    meanvector = mean(dataset(:,1:n-1));
    for i=1 : n-1
        for j=1: m
            SSt = SSt + (dataset(j,i)-meanvector(1,i))^2;
        end
    end 
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
        sigma = sigma + (counter-1)*(n-1);
        vi(nc,1:n-1) = sum ./ counter;
        temp = 0;
        for dim = 1: n-1
            for j = start : i-1
                temp = temp + (dataset(j,dim)-vi(nc,dim))^2;
            end
        end
        SSw = SSw + temp;
        %si(nc) =temp /counter;
        % i is the first of next
    end 
    RS = (SSt - SSw)/SSt;
    RMSSDT = sqrt(SSw/sigma);
    %RMSSDT_and_RS
end