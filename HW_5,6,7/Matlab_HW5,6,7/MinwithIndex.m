function matrixoutput = MinwithIndex(inputarray,warning) % return the minimum elements with indexes of the inputarray
    indexes = [];
    r =1;
    MinI = -1;
    for p = 1 : size(inputarray,1)
         for q = p + 1 : size(inputarray,2)
             if warning(p)==0 && warning(q)==0
                 if MinI == -1
                     MinI = inputarray(p,q);
                     indexes(r,1)= p;
                     indexes(r,2)= q;
                     indexes(r,3)= MinI;
                 else
                    if inputarray(p,q) < MinI
                        MinI = inputarray(p,q);
                        indexes(r,1)= p;
                        indexes(r,2)= q;
                        indexes(r,3)= MinI;
                    end
                 end
             end
         end   
     end
    matrixoutput = indexes ;
end