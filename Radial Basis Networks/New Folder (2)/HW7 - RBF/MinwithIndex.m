function matrixoutput = MinwithIndex(inputarray,warning) % return the minimum elements with indexes of the inputarray
    indexes = [];
    r =1;
    Min = inputarray(1,1);
    for p = 1 : size(inputarray,1)
         for q = p + 1 : size(inputarray,2)
             if warning(p)==1 && warning(q)==1
              if inputarray(p,q) <= Min
                  if inputarray(p,q) < Min
                    for s =1 : size(indexes ,1 )
                        indexes ( s, 1:3) = -1;
                        r=1;
                    end 
                  end
                    Min = inputarray(p,q);
                    indexes(r,1)= p;
                    indexes(r,2)= q;
                    indexes(r,3)= Min;
                    r  = r+1;
                  
              end
             end
         end
          
     end
    matrixoutput = indexes ;
end