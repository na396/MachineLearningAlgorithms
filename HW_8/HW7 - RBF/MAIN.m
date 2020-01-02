%MAIN for Kmeans
clear;
load 'matlab_datasets.mat';
dataset_num = input('choose dataset, (iris=1,satimage=2) = ');
LR = input('Choose a Learning Rate between 0 and 1 = ');

data = [];
firstt = 0;
second = 0;
switch dataset_num 
    case 1 
        data = normalize(iris);
    case 2
        data = normalize(satimage);
    case 3
        [x,y] = dataset_2(100);
        data = [x;y];
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
    cccc =1;
    while cccc < 10%sw == 0   
        %for tileek=1:5
            counter = 1; 
            first=0;
            clustermatrix = [];
            for u=1 : 5
                [iteration,clusters(: , :),numberinclster] =kmeans(SortedData,numberofhiddennodes);
                iterationkmeans(counter)=iteration;  
                clustermatrix(counter, :, :)=clusters; 
                evaluttionmatriDavis(counter) =Davies_Bouldin_Index(clusters);
                counter = counter +1;
            end
            minindexDavies = find(evaluttionmatriDavis == min(evaluttionmatriDavis));
            clusters(:,:) = clustermatrix(minindexDavies(1),:,:);
            clusters = insertionsort_onlabels(clusters); 
            [centers, variances, optweight] = RBF (tr,clusters,LR,classes,numberofhiddennodes);
            performance = computeperformance(centers, variances, optweight,te,classes);
            googoo(dd)= performance; 
            dd= dd+1; 
            performance
        %end
        if performance < PrePerformance 
            sw = 1;
        else
            PrePerformance = performance;
        end
        numberofhiddennodes = numberofhiddennodes +1;
        cccc = cccc +1;
    end


    

        