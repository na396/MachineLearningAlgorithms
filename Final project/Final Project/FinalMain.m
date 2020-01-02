%FINAL MAIN
answer = [];
[Header, Sequence]=fastaread('promoterseq.txt');
s = size(Sequence,2);
d= size(Sequence{1},2);
tt = zeros(s,2*d+1); 
for b=1 : s
    temp = Sequence{b};
    answer = CTB(temp); 
    tt(b,1:2*d)=answer(1,1:2*d);
    tt(b,2*d+1)=1;
end
tta = [];
for c=1 : s
    for u=1 : 2*d
        diboo = rand();
        if diboo > 0.5
            tta(c,u)=1;
        else
            tta(c,u)=0;
        end
            tta(c,2*d+1)=2;
    end
end
trainarray = [tt;tta];
answer2=FEMLP(trainarray,8,0.2);
performance = 0;
Sp=0;
Sn=0;
for iii=1: 4
    [train,test]=selectingtestandtrain(answer2,0.2);
    dimension = size(answer2,2)-1;
    n = size(answer2,2);
    %tree
    LR = 0.1;
    while LR < 1
        %tree
        ens= fitensemble(train(:,1:dimension),train(:,n),'AdaBoostM1',100,'tree','LearnRate',LR);
        figure;
        plot(resubLoss(ens,'mode','cumulative'));
        xlabel('Number of Decision Tree');
        ylabel('Resubstitution error');
        u=predict(ens,test(:,1:dimension));
        [performance,Sp,Sn] = Results(test(:,n),u);
        performance
        Sp
        Sn


        ens= fitensemble(train(:,1:dimension),train(:,n),'LogitBoost',100,'tree','LearnRate',LR);
        figure;
        plot(resubLoss(ens,'mode','cumulative'));
        xlabel('Number of Decision Tree');
        ylabel('Resubstitution error');
        u=predict(ens,test(:,1:dimension));
        [performance,Sp,Sn] = Results(test(:,n),u);
        performance
        Sp
        Sn


        ens= fitensemble(train(:,1:dimension),train(:,n),'GentleBoost',100,'tree','LearnRate',LR);
        figure;
        plot(resubLoss(ens,'mode','cumulative'));
        xlabel('Number of Decision Tree');
        ylabel('Resubstitution error');
        u=predict(ens,test(:,1:dimension));
        [performance,Sp,Sn] = Results(test(:,n),u);
        performance
        Sp
        Sn
        LR = LR + 0.4;
    end
    llll=1;
end