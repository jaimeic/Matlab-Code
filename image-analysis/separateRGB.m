function [ redChannel greenChannel blueChannel ] = separateRGB( file_name )
%Separate Image into Red Green and Blue Channels and display them with

rgbImage = imread(file_name);

redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);

figure
subplot(2, 2, 1);
imshow(rgbImage);
title('Original color Image');

subplot(2, 2, 2);
imshow(redChannel);
title('Red Channel');
subplot(2, 2, 3);
imshow(greenChannel);
title('Green Channel');
subplot(2, 2, 4);
imshow(blueChannel);
title('Blue Channel');

end

