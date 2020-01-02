function output = searchonarray(array,key)
    for i=1 : size(array,1)
        if key(1,1:size(array,2)-1) == array(i,1:size(array,2)-1)
            output=i;
            break;
        end
    end
    output=0;
end