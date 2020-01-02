%MAIN
% dataset_1 = 1
% dataset_2 = 2
% dataset_phoneme = 3
% dataset_iris = 4
% dataset_satimage = 5
%///////////////////////
% OnNN = 1
% Bayes = 2
% KNN = 3
% ParzenWindows =4
%\\\\\\\\\\\\\\\\\\\\


algorithm_num=input ( 'please enter number of algorithm between1-4 : ');
dataset_num =input ( 'please enter number of dataset between1-5 : ');
load 'matlab_datasets.mat';

switch dataset_num 
case 1   %dataset_1
    switch algorithm_num
        case 1     %dataset_1 with  OneNN
            for i =1 : 5
                 pointnumber = input ( 'please enter number of dataset_1 u want: ');
                 [x,y]=dataset_1(pointnumber);
                 z=[x;y];
                 
                 for j = 1 : 5
                          percentage = input ( ' please enter percentage of the test for dataset_1: '); 
                         [train,test]=selectingtestandtrain(z,percentage);
                         temp_OneNN=OneNN(train,test);
                          performance_OneNN=effeciency(test,temp_OneNN);
                          disp(performance_OneNN);
        
                 end
            end
        case 2    % dataset_2 with  Bayes
            for i =1 : 5
                 pointnumber = input ( 'please enter number of dataset_1 u want: ');
                 [x,y]=dataset_1(pointnumber);
                 z=[x;y];
                 
                 for j = 1 : 5
                          percentage = input ( ' please enter percentage of the test for dataset_1: '); 
                         [train,test]=selectingtestandtrain(z,percentage);
                         temp_Bayes=Bayes(train,test,1);
                          performance_Bayes=effeciency(test,temp_Bayes);
                          disp(performance_Bayes);
        
                 end
            end
        case 3      %dataset_1 with  KNN
            for i =1 : 5
                 pointnumber = input ( 'please enter number of dataset_1 u want: ');
                 [x,y]=dataset_1(pointnumber);
                 z=[x;y];
                 
                 for j = 1 : 5
                          percentage = input ( ' please enter percentage of the test for dataset_1: '); 
                         [train,test]=selectingtestandtrain(z,percentage);
                         train_temp = train;
                         test_temp = test;
                         temp_KNN_5=KNN(train,test,5,1);
                          performance_KNN_5=effeciency(test,temp_KNN_5);
                          disp(performance_KNN_5);
                          
                          temp_KNN_10=KNN(train_temp ,test_temp ,10,1);
                          performance_KNN_10=effeciency(test_temp,temp_KNN_10);
                          disp(performance_KNN_10); 
                          
        
                 end
            end
        case 4    %dataset_1 with ParzenWindows
            for i =1 : 5
                 pointnumber = input ( 'please enter number of dataset_1 u want: ');
                 [x,y]=dataset_1(pointnumber);
                 z=[x;y];
                 
                 for j = 1 : 5
                          percentage = input ( ' please enter percentage of the test for dataset_1: '); 
                         [train,test]=selectingtestandtrain(z,percentage);
                         train_temp = train;
                         test_temp = test;
                         
                         temp_ParzenWindows_1=ParzenWindows(train,test,1,0.5);
                          performance_ParzenWindows=effeciency(test,temp_ParzenWindows_1);
                          disp(performance_ParzenWindows);
                          
                           temp_ParzenWindows_2=ParzenWindows(train_temp,test_temp,1,1);
                          performance_ParzenWindows=effeciency(test,temp_ParzenWindows_2);
                          disp(performance_ParzenWindows);
                          
        
                  end
            end
    end
    case 2 % dataset_2
        
        switch algorithm_num
        case 1      %dataset_2 with  OneNN
            for i =1 : 5
                 pointnumber = input ( 'please enter number of dataset_2 u want: ');
                 [x,y]=dataset_2(pointnumber);
                 z=[x;y];
                 
                 for j = 1 : 5
                          percentage = input ( ' please enter percentage of the test for dataset_2: '); 
                         [train,test]=selectingtestandtrain(z,percentage);
                         temp_OneNN=OneNN(train,test);
                          performance_OneNN=effeciency(test,temp_OneNN);
                          disp(performance_OneNN);
        
                  end
            end
        case 2   %dataset_2 with  Bayes
            for i =1 : 5
                 pointnumber = input ( 'please enter number of dataset_2 u want: ');
                 [x,y]=dataset_2(pointnumber);
                 z=[x;y];
                 
                 for j = 1 : 5
                          percentage = input ( ' please enter percentage of the test for dataset_2: '); 
                         [train,test]=selectingtestandtrain(z,percentage);
                         temp_Bayes=Bayes(train,test,2);
                          performance_Bayes=effeciency(test,temp_Bayes);
                          disp(performance_Bayes);
        
                  end
            end
        case 3    %dataset_2 with KNN
            for i =1 : 5
                 pointnumber = input ( 'please enter number of dataset_2 u want: ');
                 [x,y]=dataset_2(pointnumber);
                 z=[x;y];
                 
                 for j = 1 : 5
                          percentage = input ( ' please enter percentage of the test for dataset_2: '); 
                         [train,test]=selectingtestandtrain(z,percentage);
                         train_temp = train;
                         test_temp = test;
                         temp_KNN_5=KNN(train,test,5,2);
                          performance_KNN_5=effeciency(test,temp_KNN_5);
                          disp(performance_KNN_5);
                          
                          temp_KNN_10=KNN(train_temp ,test_temp ,10,2);
                          performance_KNN_10=effeciency(test_temp,temp_KNN_10);
                          disp(performance_KNN_10);
        
                  end
            end
        case 4      %dataset_2 with  Parzenwindows
            for i =1 : 5
                 pointnumber = input ( 'please enter number of dataset_2 u want: ');
                 [x,y]=dataset_2(pointnumber);
                 z=[x;y];
                 
                 for j = 1 : 5
                          percentage = input ( ' please enter percentage of the test for dataset_2: '); 
                         [train,test]=selectingtestandtrain(z,percentage);
                         
                         train_temp = train;
                         test_temp = test;
                         
                         temp_ParzenWindows_1=ParzenWindows(train,test,2,0.5);
                          performance_ParzenWindows=effeciency(test,temp_ParzenWindows_1);
                          disp(performance_ParzenWindows);
                          
                           temp_ParzenWindows_2=ParzenWindows(train_temp,test_temp,2,1);
                          performance_ParzenWindows=effeciency(test,temp_ParzenWindows_2);
                          disp(performance_ParzenWindows);
                         
                         
        
                  end
            end
    end
    case 3   %dataset_phoneme
        switch algorithm_num
        case 1      %dataet_phoneme with  OneNN
                 for qq = 1 : 5
        
                    percentage = input ( ' please enter percentage of the test for dataset_phoneme: '); 
                    [train,test]=selectingtestandtrain(phoneme,percentage);
                    temp_OneNN=OneNN(train,test);
                    performance_OneNN=effeciency(test,temp_OneNN);
                    disp(performance_OneNN);
        
                end
        case 2    %dataset_phoneme with  Bayes
            for qq = 1 : 5
        
                    percentage = input ( ' please enter percentage of the test for dataset_phoneme: '); 
                    [train,test]=selectingtestandtrain(phoneme,percentage);
                    temp_Bayes=Bayes(train,test,3);
                    performance_Bayes=effeciency(test,temp_Bayes);
                    disp(performance_Bayes);
        
             end
        case 3    %dataset_phoneme with  KNN
            for qq = 1 : 5
        
                    percentage = input ( ' please enter percentage of the test for dataset_phoneme: '); 
                    [train,test]=selectingtestandtrain(phoneme,percentage);
                    train_temp = train;
                    test_temp = test;
                    temp_KNN_5=KNN(train,test,5,3);
                    performance_KNN_5=effeciency(test,temp_KNN_5);
                    disp(performance_KNN_5);
                         
                    temp_KNN_10=KNN(train_temp ,test_temp ,10,3);
                    performance_KNN_10=effeciency(test_temp,temp_KNN_10);
                    disp(performance_KNN_10);
        
             end
        case 4   %dataset_phoneme  with  ParzenWindows
            for qq = 1 : 5
        
                    percentage = input ( ' please enter percentage of the test for dataset_phoneme: '); 
                    [train,test]=selectingtestandtrain(phoneme,percentage);
                    train_temp = train;
                         test_temp = test;
                         
                         temp_ParzenWindows_1=ParzenWindows(train,test,3,1);
                          performance_ParzenWindows=effeciency(test,temp_ParzenWindows_1);
                          disp(performance_ParzenWindows);
                          
                           temp_ParzenWindows_2=ParzenWindows(train_temp,test_temp,3,2);
                          performance_ParzenWindows=effeciency(test,temp_ParzenWindows_2);
                          disp(performance_ParzenWindows);
                         
        
            end
        end
           
    case 4    %dataset_iris
     switch algorithm_num
        case 1   %dataset_iris with  OneNN
                 for qq = 1 : 5
        
                    percentage = input ( ' please enter percentage of the test for dataset_iris: '); 
                    [train,test]=selectingtestandtrain(iris,percentage);
                    temp_OneNN=OneNN(train,test);
                    performance_OneNN=effeciency(test,temp_OneNN);
                    disp(performance_OneNN);
        
                end
        case 2     %dataset_iris with  Bayes
            for qq = 1 : 5
        
                    percentage = input ( ' please enter percentage of the test for dataset_iris: '); 
                    [train,test]=selectingtestandtrain(iris,percentage);
                    temp_Bayes=Bayes(train,test,4);
                    performance_Bayes=effeciency(test,temp_Bayes);
                    disp(performance_Bayes);
        
            end
        case 3     %dataset_iris with  KNN
            for qq = 1 : 5
        
                    percentage = input ( ' please enter percentage of the test for dataset_iris: '); 
                    
                   [train,test]=selectingtestandtrain(iris,percentage);
                         train_temp = train;
                         test_temp = test;
                         temp_KNN_5=KNN(train,test,5,4);
                          performance_KNN_5=effeciency(test,temp_KNN_5);
                          disp(performance_KNN_5);
                          
                          temp_KNN_10=KNN(train_temp ,test_temp ,10,4);
                          performance_KNN_10=effeciency(test_temp,temp_KNN_10);
                          disp(performance_KNN_10);

        
            end
        case 4        %dataset_iris with ParzenWindows
            for qq = 1 : 5
        
                    percentage = input ( ' please enter percentage of the test for dataset_iris: '); 
                    [train,test]=selectingtestandtrain(iris,percentage);
           
                    train_temp = train;
                         test_temp = test;
                         
                         temp_ParzenWindows_1=ParzenWindows(train,test,4,0.8);
                          performance_ParzenWindows=effeciency(test,temp_ParzenWindows_1);
                          disp(performance_ParzenWindows);
                          
                           temp_ParzenWindows_2=ParzenWindows(train_temp,test_temp,4,1.7);
                          performance_ParzenWindows=effeciency(test,temp_ParzenWindows_2);
                          disp(performance_ParzenWindows);
                         
        
            end
    end
    case 5    %dataset_satimage
       switch algorithm_num
           case 1      %dataset_satimage with OneNN
                 for qq = 1 : 5
        
                    percentage = input ( ' please enter percentage of the test for dataset_satimage: '); 
                    [train,test]=selectingtestandtrain(satimage,percentage);
                    temp_OneNN=OneNN(train,test);
                    performance_OneNN=effeciency(test,temp_OneNN);
                    disp(performance_OneNN);
        
                end
        case 2       %dataset_satimage with  Bayes
            for qq = 1 : 5
        
                    percentage = input ( ' please enter percentage of the test for dataset_satimage: '); 
                    [train,test]=selectingtestandtrain(satimage,percentage);
                    temp_Bayes=Bayes(train,test,5);
                    performance_Bayes=effeciency(test,temp_Bayes);
                    disp(performance_Bayes);
        
             end
        case 3         %dataset_satimage with  KNN
            for qq = 1 : 5
        
                    percentage = input ( ' please enter percentage of the test for dataset_satimage: '); 
                    [train,test]=selectingtestandtrain(satimage,percentage);
                    train_temp = train;
                    test_temp = test;
                    temp_KNN_5=KNN(train,test,5,4);
                    performance_KNN_5=effeciency(test,temp_KNN_5);
                    disp(performance_KNN_5);
                          
                    temp_KNN_10=KNN(train_temp ,test_temp ,10,4);
                    performance_KNN_10=effeciency(test_temp,temp_KNN_10);
                    disp(performance_KNN_10);

        
             end
        case 4     %dataset_satimage with  ParzenWindows
            for qq = 1 : 5
        
                    percentage = input ( ' please enter percentage of the test for dataset_satimage: '); 
                    [train,test]=selectingtestandtrain(satimage,percentage);
                    train_temp = train;
                         test_temp = test;
                         
                         temp_ParzenWindows_1=ParzenWindows(train,test,1,20);
                          performance_ParzenWindows=effeciency(test,temp_ParzenWindows_1);
                          disp(performance_ParzenWindows);
                          
                           temp_ParzenWindows_2=ParzenWindows(train_temp,test_temp,1,40);
                          performance_ParzenWindows=effeciency(test,temp_ParzenWindows_2);
                          disp(performance_ParzenWindows);
                         
        
            end
       end
end

       
    
