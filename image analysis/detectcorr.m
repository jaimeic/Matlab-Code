function [Ccorr] = detectcorr(template_name, reference_name)
figure(101); 

%%
% Read template and reference images as DOUBLE arrays T and R respectively,
%	then convert to GRAYSCALE:
R = imread(reference_name);
R = rgb2gray(im2double(R));
T = imread(template_name);
T = rgb2gray(im2double(T));
Tsize = size(T);


% Compute the normalized correlation between R and T, and find the index
% achieving the maximum:
Ccorr = xcorr2(R,T)./( sqrt(sum(R(:).^2)) * sqrt(xcorr2(R.^2, ones(size(T)))) );
[maxval, maxidx] = max(Ccorr(:)); %#ok<*ASGLU>
[r, c] = ind2sub(size(Ccorr), maxidx);


% Draw a rectangle around the image region best matching the template:
imshow(R); hold on
rectangle('Position',[c-Tsize(2) r-Tsize(1) Tsize(2) Tsize(1)], 'EdgeColor','r','LineWidth',2);
title('Detection by Correlation')
      

%% %Do the same thing again with the 2D convolution:
% T = rot90(T,2);
% Cconv  = conv2(T,R)./( sqrt(sum(R(:).^2)) * sqrt(xcorr2(R.^2, ones(size(T)))) );
% [maxval, maxidx] = max(Cconv(:));
% [r, c] = ind2sub(size(Cconv), maxidx);
% 
% 
% 
% subplot(122); imshow(R); hold on
% rectangle('Position',[c-Tsize(2) r-Tsize(1) Tsize(2) Tsize(1)], 'EdgeColor','r','LineWidth',2);
% title('Detection by Convolution')
end
      
