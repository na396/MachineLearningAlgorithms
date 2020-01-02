function [treearray,alpha]= Adaboosting(data,M,classes)
    weight = [];
    N = size(data,1);
    for i=1: N
        weight(i)=1/N;
    end
    matcharray = [];
    mismatcharray = [];
    for m=1 : M
        [tempwarning,tree]= DT(data, classes);
        treearray{m} = tree;
        err = 0;
        for j=1 : size(tempwarning,2)
            err = err + weight(1,j)*tempwarning(1,j);
        end
        if err > 0.5
            disp('err > 0.5');
            break;
        end 
        alpha(m) = 0.5* log((1-err)/err);
        for k=1 : size(tempwarning,1) 
            weight(k) = weight(k)* exp(-alpha(m)*tempwarning(k));
        end
    end
end