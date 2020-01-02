function sortarray=insertionsort_onlabels(array)
        for m=2 :size(array,1)                                                             %insertionsort( line 14 to 25)
     
          key = array(m,1:size(array,2));
          r = m-1;
          while r>0 && key(size(key,2)) < array(r,size(array,2)) 
             array(r+1,1:size(array,2))=array(r,1:size(array,2));
             r = r-1;
          end
          array(r+1,1:size(array,2)) = key;
          
          
   
      end
        sortarray =array;
    end