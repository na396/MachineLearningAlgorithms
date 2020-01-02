%Main of RBF
clear;
load 'matlab_datasets.mat';
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
        classes = findclasses(SortedData);
        dimension = size(SortedData,2)-1;
        sw = 0;
        numberofhiddennodes = dimension;
        PrePerformance = 0; 
        dd=1;
        while sw == 0 
            [iteration,clusters,numberelementineachcluster] = kmeans(SortedData,numberofhiddennodes);
            clusters = insertionsort_onlabels(clusters);
            [centers, variances, optweight] = RBF (SortedData,LR,classes);
            performance = computeperformance(centers, variances, optweight,te,classes);
            googoo(dd)= performance;
            dd= dd+1;
            performance
            if perofrmance < PrePerformance 
                sw = 1;
            else
                PrePerformance =perofrmance;
            end
            numberofhiddennodes = numberofhiddennodes +1;
        end