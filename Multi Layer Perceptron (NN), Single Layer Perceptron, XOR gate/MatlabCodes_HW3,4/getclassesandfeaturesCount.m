function  [n1, n3]= getclassesandfeaturesCount(arrray)

    n1= size(arrray,2)-1;
    
    n3 = size(findclasses(arrray),1);

end