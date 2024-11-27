function [] = gray_backg_line(filename)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

arrow_Img = filename;

r = arrow_Img(:,:,1);
g = arrow_Img(:,:,2);
b = arrow_Img(:,:,3);

r(1:3, :) = 163;
r(end-2:end, :) = 163;
r(: , 1:3) = 163;
r(: , end-2:end) = 163;
g(1:3, :) = 20;
g(end-2:end, :) = 20;
g(: , 1:3) = 20;
g(: , end-2:end) = 20;
b(1:3, :) = 46;
b(end-2:end, :) = 46;
b(: , 1:3) = 46;
b(: , end-2:end) = 46;


arrow_Img_gray = cat( 3, r, g, b );

imwrite(arrow_Img_gray, 'arrow_Img_gray.png');



end

