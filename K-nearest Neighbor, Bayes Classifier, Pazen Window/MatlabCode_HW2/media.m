function example= media()
array=[2 15 6 38]; %insertionsort
      for m=2 : 4
          key = array(m);
          r = m-1;
          while r>0 && key < array(r) 
             array(r+1)=array(r);
             r = r-1;
          end
          array(r+1) = key;
   
      end
      example= (array(2)+array(3))/2 ;
end