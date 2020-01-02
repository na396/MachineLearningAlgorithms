function [datamatrix]=FEMLP(data,n2,LR)
    err = 0;
    preerr = 0;
    n1= size(data,2)-1;
    n3= n1;
    wl = rand(n1, n2);
    wr = rand (n2, n3);
    sw=0;
    sumoo=0;
    while sw == 0  
        for datasize = 1 : size(data ,1)
            err = 0;
            sumoo=0;
            for i=1 : n2 
                 for j=1 : n1
                      sumoo = sumoo + wl(j,i)*data(datasize,j);  
                 end 
                 o(i) = 1./(1+exp(-sumoo)) ;
            end  
            sumoo =0;
            for i=1 : n3             
                 for j=1 : n2
                      sumoo = sumoo + wr(j,i) * o(j);  
                 end 
                 olast(i) = sumoo ;
            end
            for qq=1 : n3
                for pp=1 : n2
                    wr(pp,qq)= wr(pp,qq)+LR*(data(datasize,qq)-olast(qq))*o(pp);
                end
                err = err + (data(datasize,qq)-olast(qq))^2;
            end
            for hh=1 : n2
                delta(hh)=0; 
                for gg=1 : n3
                    delta(hh)= delta(hh)+wr(hh,gg)*(data(datasize,gg)-olast(gg));
                end
                delta(hh)= delta(hh)*o(hh)*(1-o(hh));
            end
            for ii=1 : n2
                for kk=1 : n1
                    wl(kk,ii)= wl(kk,ii)+LR*delta(ii)*data(datasize,kk);
                end
            end
        end 
        err = err / (2*size(data,1));
        if err - preerr < 0.0001
            sw = 1;
        end
        preerr = err;
    end
    
    for ii = 1 : size(data ,1)
            for i=1 : n2 
                 sumoo=0;
                 for j=1 : n1
                      sumoo = sumoo + wl(j,i)*data(ii,j);  
                 end 
                 datamatrix(ii,i) = sumoo ;
            end
            datamatrix(ii,n2+1) = data(ii,size(data,2));
    end
end
