function output = density(v,R,dataset)
    counter = 0;
    for i=1 : size(dataset,1)
        distance = pdist2(dataset(i,1:size(dataset,2)-1),v);
        if distance <= R
            counter = counter +1;
        end
    end
    output = counter;
end