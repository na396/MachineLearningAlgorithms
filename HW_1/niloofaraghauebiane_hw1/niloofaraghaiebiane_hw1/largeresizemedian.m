function large_image = largeresizemedian(smallphoto)
sizex=size(smallphoto,1);
sizey=size(smallphoto,2);
k=1;
for i=1 : sizex-1
    l=1;
    for j=1 : sizey-1
         array=[smallphoto(i,j) smallphoto(i+1,j) smallphoto(i,j+1) smallphoto(i+1,j+1)]; %insertionsort
          for m=2 : 4
          key = array(m);
          r = m-1;
          while r>0 && key < array(r) 
             array(r+1)=array(r);
             r = r-1;
          end
          array(r+1) = key ;
          end
          temp(k,l)= (array(2)+array(3))/2 ;
          temp(k+1,l)= (array(2)+array(3))/2 ;
          temp(k,l+1)= (array(2)+array(3))/2 ;
          temp(k+1,l+1)= (array(2)+array(3))/2 ;
          l=l+2;
    end
 k=k+2;
 
end
large_image = temp;


end