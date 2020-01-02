function classmatrix = findclasses(train)
    tempout=[];
    i=1;
    l=1;
    while i <= size(train,1)
        class_counter =1;
        class = train (i,size(train,2));
        tempout(l,1)=class;
        tempout (l,2)=0;
        while class == train (i,size(train,2))
          i = i+1;
          class_counter = class_counter +1;
          if i>size(train,1)
              break;
          end
        end
        l=l+1;
    end
    classmatrix =tempout;
end