function [class_1,class_2] = dataset_1(pointnumber)
    function xn_class1 = randomx_class_1(n)    % x dimension of a number from class1
        xn_class1 =  -1 *(2 * rand(n ,1));     % -2<x<0   
    end
    function yn_class1= randomy_class_1(n)    %y dimension of a number from class1
        yn_class1 = (4 *rand(n ,1)) -2 ;      %  -2<y<2
    end
    function xn_class2 = randomx_class_2(n)    %x dimension of a number from class2
        xn_class2 = 2 * rand(n ,1);            % 0<x<2
    end
    function yn_class2 = randomy_class_2(n)    %y dimension of a number from class
        yn_class2 = ( 4 *rand(n ,1)) - 3 ;     % -3<y<1
    end
    counter = pointnumber ; 
    j=1;
    while counter > 0                          % while for class 1
     x = randomx_class_1(counter);
     y = randomy_class_1(counter);
     r = sqrt(x.^2 + y.^2) ;
     acceptableindexes = find ( r <= 2);
     for i = 1 : size(acceptableindexes)
         if r(acceptableindexes(i)) <= 1
             x(acceptableindexes(i)) = -x(acceptableindexes(i));
             y(acceptableindexes(i)) = y(acceptableindexes(i)) - 1 ;
         end
         class_1(j,1) = x(acceptableindexes(i));
         class_1(j,2) = y(acceptableindexes(i));
         class_1(j,3) = 'A' ;                    % class_1 = Class A
         j=j+1;
     end
     counter = pointnumber - size(class_1,1) ;
    end
    j=1;
    counter = pointnumber ; 
    while counter > 0 
         x = randomx_class_2(counter);
         y = randomy_class_2(counter);
         r = sqrt(x.^2 + y.^2) ;
         acceptableindexes = find ( r <= 2);
         for i = 1 : size(acceptableindexes)
             if r(acceptableindexes(i)) <= 1
                 x(acceptableindexes(i)) = -x(acceptableindexes(i));
                 y(acceptableindexes(i)) = y(acceptableindexes(i)) + 1 ;
             end
             class_2(j,1) = x(acceptableindexes(i));
             class_2(j,2) = y(acceptableindexes(i));
             class_2(j,3) = 'B' ;                    % class_2 = Class B
             j=j+1;
          end
        counter = pointnumber - size(class_2,1) ;
    end
end
