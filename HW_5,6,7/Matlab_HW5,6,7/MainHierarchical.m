%MAIN for HierarchicalClustering
% Neeloufar Aghaie 810890001
clear;
load 'matlab_datasets.mat';
dataset_num = input('choose dataset, (iris=1,satimage=2) = ');
data = [];
firstt = 0;
second = 0;
switch dataset_num 
    case 1 
        data = normalize(iris);
        firstt = 2;
        second = 5;
    case 2
        data = normalize(satimage);
        firstt = 4;
        second = 8;
    otherwise
        error
        break;    
end
counter = 1;
run= 1:5;
range = 0;
first=0;
for k=firstt : second
    first = counter;
    for u=1 : 5
        [clusters(: , :),numberinclster] =HierarchicalClustering(data,k);
        k
        
        numberinclster  
        clustermatrix(counter, :, :)=clusters; 
        evaluttionmatriDavis(counter) =Davies_Bouldin_Index(clusters);
        [RMSSDT,RS] = RMSSDT_and_RS(clusters);
        evaluttionmatrixRMSSDT(counter) = RMSSDT;
        evaluttionmatrixRS(counter) = RS ;
        counter = counter +1;
    end
    range = first : first+4;
    figure
    title('evaluations for HierarchicalClustering Davies Bouldin Index: red and S Dbw Validity Index: blue') ;
    xlabel('run')
    ylabel('evaluation')
    plot(run,evaluttionmatriDavis(range),'r');
    hold all;
    plot(run,evaluttionmatrixRMSSDT(range),'g');
    hold all;
    plot(run,evaluttionmatrixRS(range),'y');
    hold all;
end
minindexDavies = find(evaluttionmatriDavis == min(evaluttionmatriDavis));
kopt = ceil(minindexDavies(1)/5)+ firstt-1;
uopt =  mod ( minindexDavies(1),5);
if uopt == 0
    uopt = 5;
end
str = sprintf('Davies_Bouldin_Index = %d and k of Davies= %d and numberofiteration = %d', evaluttionmatriDavis(1,minindexDavies(1)), kopt , uopt);
str
minindexRMSSDT = find(evaluttionmatrixRMSSDT == min(evaluttionmatrixRMSSDT));
kopt = ceil(minindexRMSSDT(1)/5)+firstt-1;
uopt =  mod ( minindexRMSSDT(1),5);
if uopt == 0
    uopt =5;
end
str2 = sprintf('RMSSDT = %d and k = %d and numberofiteration = %d', evaluttionmatrixRMSSDT(1,minindexRMSSDT(1)), kopt , uopt);
str2
maxindexRS = find(evaluttionmatrixRS == max(evaluttionmatrixRS));
kopt = ceil(maxindexRS(1)/5) + firstt -1;
uopt = mod ( maxindexRS(1),5);
if uopt == 0
    uopt = 5;
end
str3 = sprintf('RS = %d and k = %d and numberofiteration = %d', evaluttionmatrixRS(1,maxindexRS(1)), kopt , uopt);
str3
