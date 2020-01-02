function small_image = smallresizeaverage(bigphoto)
sizex=size(bigphoto,1);
sizey=size(bigphoto,2);
if  mod(sizex,2)==1
    sizex=sizex-1;
end
if mod(sizey,2)==1
    sizey=sizey-1;
end
k=1;
for i=1 :2: sizex
    l=1;
    for j=1:2: sizey
    temp(k,l)=(bigphoto(i,j)+bigphoto(i+1,j)+bigphoto(i,j+1)+bigphoto(i+1,j+1))/4;
    
    l=l+1;
    end
  
k=k+1;
end
small_image=temp;
end