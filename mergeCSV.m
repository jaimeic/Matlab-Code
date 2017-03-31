function [ time, roi_data ] = mergeCSV( strFilePrefix )
%MERGE_CSV Merge the outputs of the Cellvizio IC Viewer Software
%   Merges all the csv files with the fluorescence data from the IC Viewer
%   into a single matrix. Time stamps are in a separate column array. 
%   Note: Make sure the files are in the correct order and labeled 
%   correctly so that when they are imported they stay in the correct
%   order. 
%
%   Output from Cellvizio software is split by frame number. The first recording 
%   will be titled: “prefix_from1to7259.csv,” the second file will be 
%   “prefix_from7260to14518.csv,” and the third will be “prefix_from14519to21777.csv.” 
%   However, Matlab will mess up the order of these files and will put the 
%   third file as coming before the second file because the seven in 7260 is a 
%   greater number than the one in 14,519. To fix this, you need to pad the 
%   file name with zeros such that the total digits is the same as the total 
%   digits of the largest frame number. To fix these files, I would rename 
%   file 1 to “prefix_from00001to7259.csv,” and file 2 to 
%   “prefix_from07260to14518.csv.” This way, Matlab reads in the files in the 
%   correct order.
% 
% 
% 
%   input: The first letters of the file name. All files should have the
%   same prefixes, but differ at the end. Files need to be in same
%   directory as formula (for now). 
%   example input: 'file_prefix*.csv'
%     
% 
%   output: A column array with time data. A matrix with the average
%   fluroescence of all the ROIs. Each ROI is a column. 
% 
% 
% 
%Jaime Castro
%2/3/2017


%Import all csv files into a struct
all_csv = dir( strFilePrefix );

%Get fluorescence data of each ROI in a matrix. Each column is an ROI
%(column 1 is ROI1, column 2 is ROI2 etc.)
roi_data = csvread(all_csv(1).name,1,2);

    for i = 2:length(all_csv)
        roi_data = vertcat(roi_data, csvread(all_csv(i).name,1,2));
    end
    

%Get time data
get_time = csvread(all_csv(1).name,1,1,[1 1 10000 1]);
step_array = zeros(length(get_time),1);
    for j = 2:length(get_time)
        step_array(j-1) = get_time(j)-get_time(j-1);
    end
   
step_time = mean(step_array);
time(:,1) = [1:length(roi_data)]'*step_time;


%Quickly plot to visualize data and make sure everything is ok
for i = 1: size(roi_data, 2)
    plot(time, roi_data(:,i))
    title('Vasospasm Analysis')
    xlabel('Time (sec)')
    ylabel('Fluorescence (a.u)')
    hold on
end



