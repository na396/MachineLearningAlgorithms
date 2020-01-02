function n2= n2finding(train, LR,n1,n3)
    n2= 2;
    k=1;
    while n2 < 2*size(train,2) 
        performance = run(train,LR,n1,n2,n3);
        array(k,2)=performance;
        array(k,1)= n2; 
        k=k+1;
        n2=n2+1;
    end 
    index = find(array(:,2)==max(array(:,2)));
    n2=array(index(1),1);
end