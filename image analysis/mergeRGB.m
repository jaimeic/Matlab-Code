function [ rgbImage ] = mergeRGB(redChannel, blueChannel, greenChannel)
%Merge RGB Channels into one image

rgbImage = cat(3, redChannel, blueChannel, greenChannel);

figure
imshow(rgbImage)
title('Merged Image')


end

