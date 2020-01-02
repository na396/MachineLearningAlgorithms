function outputmatrix = sortmatrix(inputarray)
    temp = [];
    o=1;
    for x=1 : size(inputarray,1)
      for y=1 : size(inputarray,2)
             mintemp(3) = inputarray(x,y);
             mintemp(1)=x;
             mintemp(2)=y;
             yy =y;
             if x==size(inputarray,1)
                 xx= x+1;
             else
                 xx=x;
             end
             for first=xx : size(inputarray ,1)
                 for second=yy : size(inputarray ,2)
                     if inputarray(first,second) < mintemp(3)
                         mintemp(3) = inputarray(first,second);
                         mintemp(1)= first;
                         mintemp(2)= second;
                      end
                      
                 end
                  yy=1;
             end         
            temp(o,1)=mintemp(1);
            temp(o,2)=mintemp(2);
            temp(o,3)=mintemp(3);
            o=o+1;
            temp1=inputarray(mintemp(1),mintemp(2));
            inputarray(mintemp(1),mintemp(2))=inputarray(x,y);
            inputarray(x,y)=temp1;
        end
    end
    outputmatrix=temp;
    
end                                                                                                         