function larged_image = doubleresize(smallphoto)
sizex=size(smallphoto,1);
sizey=size(smallphoto,2);
k=1;
for i=1:sizex
    l=1;
    for j=1:sizey
        temp(k,l)=smallphoto(i,j);
        temp(k+1,l)=smallphoto(i,j);
        temp(k,l+1)=smallphoto(i,j);
        tem(k+1,l+1)=smallphoto(i,j);
        l=l+2;
    end
    k=k+2;
end
larged_image=temp;
end