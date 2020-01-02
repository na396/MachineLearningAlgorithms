function small_image= smallresizemedian(bigphoto)
sizex=size(bigphoto,1);
sizey=size(bigphoto,2);
if  mod(sizex,2)==1
    sizex=sizex-1;
end
if mod(sizey,2)==1
    sizey=sizey-1;
end
k=1;
for i=1 :2: sizex                          %walking through row i(selecting 2 entry )
    l=1;
    for j=1 :2: sizey                      %selecting 2 entry exactly entries whom are exactly under entries  i had selected
      array=[bigphoto(i,j) bigphoto(i+1,j) bigphoto(i,j+1) bigphoto(i+1,j+1)]; %sorting array with 4 enrty using 
      for m=2 : 4                                                             %insertionsort( line 14 to 25)
     
          key = array(m);
          r = m-1;
          while r>0 && key < array(r) 
             array(r+1)=array(r);
             r = r-1;
          end
          array(r+1) = key;
   
      end
      temp(k,l)= (array(2)+array(3))/2 ;                                         %computing median of 4entry: 
      l=l+1;                                                                     %i,j i+1,j  i,j+1 i+1,j+1
    end
  
   k=k+1;
end
small_image=temp;                                                                %ouput_smalled image
end