function [performance,Sp,Sn]= Results(correct,predict)
    TP=0;
    FP=0;
    FN=0;
    for i=1:size(correct,1)
        if correct(i,1)==predict(i,1)
            TP=TP+1;
        else
            if correct(i,1)==1
                FN=FN+1;
            else
                FP=FP+1;
            end
        end
    end
    Sp = TP/(TP+FP);
    Sn = TP/(TP+FN);
    performance = (TP/size(correct,1))*100;
end