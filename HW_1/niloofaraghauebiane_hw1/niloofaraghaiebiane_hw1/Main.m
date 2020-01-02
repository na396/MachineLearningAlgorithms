load 'Images.mat';

I=largeresizemedian(Image256);
imshow(I);
title 'Resize Image 256'

figure
I=largeresizemedian(Image512);
imshow(I);
title 'Resize Image 512'

figure
I=largeresizemedian(Image1024);
imshow(I);
title 'Resize Image 1024'

figure
I=doubleresize(Image256);
imshow(I);
title 'Resize Image 256'

figure
I=doubleresize(Image512);
imshow(I);
title 'Resize Image 512'

figure
I=doubleresize(Image1024);
imshow(I);
title 'Resize Image 1024'

figure
I=smallresizeaverage(Image256);
imshow(I);
title 'Resize Image 256'

figure
I=smallresizeaverage(Image512);
imshow(I);
title 'Resize Image 512'

figure
I=smallresizeaverage(Image1024);
imshow(I);
title 'Resize Image 1024'

figure
I=smallresizemedian(Image256);
imshow(I);
title 'Resize image 256'

figure
I=smallresizemedian(Image512);
imshow(I);
title 'Resize image 512'

figure
I=smallresizemedian(Image1024);
imshow(I);
title 'Resize image 1024'