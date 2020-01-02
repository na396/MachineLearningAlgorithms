function [wl ,winter, wr,  wout]= initialweight(n1 ,n2, n3)



   for q = 1 : n2    %gerenrating weight  for intermdeiate nodes
       winter(q)= rand (1 , 1);
       
   end
    
   for p= 1 : n3    %gerenrating weight  for uotputs nodes
       wout(p)= rand (1 , 1);
   end
   
   for i=1 : n1       %generating weighted matrix wl
       for j =1 : n2
           wl(i ,j)= rand (1 , 1);
           
       end
   end
   
   for i =1 : n2    %generating weighted matrix wr
       for j= 1 : n3 
           wr(i ,j)= rand (1 , 1);
       end
   end


end
