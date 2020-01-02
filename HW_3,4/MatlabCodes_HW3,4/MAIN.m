
clear;
load 'datasets.mat';
dataset_num = input('choose dataset, (iris=1,satimage=2) = ');
LR = input('please enter Learning Rate between 0-1 = ');

data = [];
switch dataset_num 
    case 1 
        data = normalize(iris);
    case 2
        data = normalize(satimage);
    otherwise
        error
        break;    
end
        [tr,te] = selectingtestandtrain(data, 0.25);
        SortedData = insertionsort_onlabels(tr);
        [n1, n3]= getclassesandfeaturesCount(SortedData);
        n2= n2finding(SortedData,LR,n1,n3);
        n2 
        figure;
        epnum = earlystoppingmethod(SortedData,LR,n1,n2,n3);
            
        [Half1,Half2] = selectingtestandtrain(SortedData, 0.5);
        [Part1,Part2] = selectingtestandtrain(Half1, 0.5);
        [Part3,Part4] = selectingtestandtrain(Half2, 0.5);
        %multi fold
        p=[0,0,0,0];
        pp=1;
        for k=1:4
            if k==1
                test=Part1;
                train =[Part2;Part3;Part4];
            elseif k==2
                test=Part2;
                train =[Part1;Part3;Part4];
            elseif k==3
                test=Part3;
                train =[Part1;Part2;Part4];
            else
                test=Part4;
                train =[Part1;Part2;Part3];
            end
            SortedData = insertionsort_onlabels(train);
            [n1, n3]= getclassesandfeaturesCount(SortedData);  
            
            [performance,epochcounter] = init(SortedData,test, LR, n1, n2 , n3);
            epochcounter
            performance
            p(pp)=performance;
            pp=pp+1;
        end
        average= mean(p);
        average
        variance = var (p);
        variance
        