% denoise rg images with speckle

close all
clear all

%% Read images and separate color channels
rgbImage = imread(filename);
redChannel = rgbImage(:,:,1);
greenChannel = rgbImage(:,:,2);
blueChannel = rgbImage(:,:,3);

%% Fix Contrast
imshow(redChannel),imcontrast(gca)
red_contrast = getimage(gcf);

imshow(greenChannel),imcontrast(gca)
green_contrast = getimage(gcf);

imshow(blueChannel),imcontrast(gca)
blue_contrast = getimage(gcf);

%% De Noise
% De noise red and green channel separetely using wiener filter
wiener_red = wiener2(red_contrast,[5 5]);
wiener_green = wiener2(green_contrast,[5 5]);
wiener_blue = wiener2(blue_contrast,[5 5]);

% De noise using median filter
median_red = medfilt2(red_contrast);
median_green = medfilt2(green_contrast);
median_blue = medfilt2(blue_contrast);

% De noise using averaging filter




% Show three images in order to compare
%Red Channel
figure 
imshow(red_contrast) 
figure
imshow(wiener_red)
figure
imshow(median_red)

%Green Channel
figure 
imshow(green_contrast) 
figure
imshow(wiener_green)
figure
imshow(median_green)


%% Merge channels into image again
rgb_new = cat(3, 'best filter red', 'best filter green', 'best filter blue');
imshow(rgb_new)

%% Save fixed image
imwrite(rgb_new, filename_new);
