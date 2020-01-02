function outputmatrix = equalityinmatrix(inputarray)
    c=1;
    counter = 0;
    nextclusnum=0;
    tempmatrix=[];
    for a=1:size(inputarray,1)
       sw=0;
       if size(tempmatrix,1) ~= 0
           for i=1 : size(tempmatrix,1)
               if tempmatrix(i,1) == inputarray(a,1)&& tempmatrix(i,2)==inputarray(a,2)
                  nextclusnum = tempmatrix(i,4);
                  sw=1;
               end
           end
           if sw ==0
               counter = counter +1;
               nextclusnum = counter;
               
           end
       else counter=1;    
           nextclusnum = counter;
       end
       
       if sw == 0
          temp1= inputarray(a,1);
          temp2= inputarray(a,2);
          tempmatrix(c,1) = inputarray(a,1);
          tempmatrix(c,2) = inputarray(a,2);
          tempmatrix(c,3) = inputarray(a,3);
          tempmatrix(c,4) = nextclusnum;
          c = c+1;
       end
       
       for b=a+1 : size(inputarray,1)
           sw2=0;
           if temp1 == inputarray(b,1) || temp1 == inputarray(b,2) || temp2 == inputarray(b,1) || temp2 == inputarray(b,2)
                if size(tempmatrix,1) ~= 0
                    for i=1 : size(tempmatrix,1)
                        if tempmatrix(i,1) == inputarray(b,1)&& tempmatrix(i,2)==inputarray(b,2)
                            sw2=1;
                        end
                    end
                end
                if sw2==0
                    tempmatrix(c,1) = inputarray(b,1);
                    tempmatrix(c,2) = inputarray(b,2);
                    tempmatrix(c,3) = inputarray(b,3);
                    tempmatrix(c,4) = nextclusnum;
                    c = c +1;
                end
            
           end
       end
    end
    
    outputmatrix = tempmatrix;
    
end
