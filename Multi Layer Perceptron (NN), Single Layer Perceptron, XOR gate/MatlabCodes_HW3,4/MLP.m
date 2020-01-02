function [optwl , optwinter, optwr, optwout,totalerror] = MLP( train, LR,n2, wl ,winter, wr,  wout, n1, n3,classes)
        error=[];
        
       for datasize = 1 : size(train ,1)
            for i=1 : n2
                sum = winter(i); 
                 for j=1 : n1
                      sum = sum + wl(j,i)*train(datasize,j);  
                 end 
                 o(i) = 1./(1+exp(-sum)) ;
            end  
            
            for i=1 : n3
                 sum = wout(i);
                 for j=1 : n2
                      sum = sum + wr(j,i) * o(j);  
                 end 
                 olast(i) = 1./(1 + exp(-sum)) ;
                 
            end
            targetindex=0;
            for classindex=1:size(classes,1)
                if train(datasize,size(train,2))==classes(classindex,1)
                    targetindex = classindex;
                end
            end
            error(datasize)=0;
            for x=1 : n3
                if x == targetindex
                    target=1;
                else target=0;
                end
                delta(x)= olast(x)*(1-olast(x))*(target-olast(x));
                error(datasize) = error(datasize) + (target-olast(x)).^2;
            end
            for y=1 : n3
                deltasecond(y,1)= LR * delta(y);
                for z=2 : n2+1
                    deltasecond(y, z)= LR * delta(y)*o(z-1);
                end
            end
            for i=1 : n2
                temp = 0;
                for j=1 : n3
                    temp = temp+ wr(i,j)*delta(j);
                end
                deltainter(i)= o(i) *(1-o(i))* temp;
            end
        
            for y=1 : n2
                deltafirst(y,1)= LR * deltainter(y);
                for z=2 : n1+1
                    deltafirst(y, z)= LR * deltainter(y)*train(datasize, z-1);
                end
            end
            for a=1 :n2
                winter(a)=winter(a)+ deltafirst(a,1);
            end
            for b=1 : n3
                wout(b)=wout(b)+deltasecond(b,1);
            end
            for i=1 : n1       
                for j =1 : n2
                    wl(i ,j)= wl(i , j)+deltafirst(j,i+1);  
                end
            end 
   
            for i =1 : n2    
                for j= 1 : n3 
                    wr(i ,j)= wr(i , j)+deltasecond(j,i+1);
                end
            end

       end
       totalerror = 0;
       for n=1 : size(error,2)
           totalerror = totalerror + error(n);
       end
       totalerror = totalerror /(2*size(train,1));
       optwl = wl;
       optwinter =winter;
       optwr = wr;
       optwout=wout;
end