function [class_1,class_2] = dataset_2(numberofpoint)
class_1=randn([numberofpoint,2]);
class_2= 2+(4 *randn([numberofpoint,2]));
    for i=1: size(class_1,1)
        class_1(i,3)='A';
    end
    
    for i=1: size(class_2,1)
        class_2(i,3)='B';
    end
end