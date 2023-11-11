clc;
clear all;
%% 

[FileName,PathName] = uigetfile('*.tdms','Select rHealth file');
filename =  fullfile(PathName,FileName);
raw = tdms_read(filename);
%%
[  area_peak_DP, median_area_DP, mean_area_DP, count_DP, CV_DP,xa_newDP,xb_newDP ] = switch_channel(raw, 1 );
[  area_peak_MP, median_area_MP, mean_area_MP, count_MP, CV_MP,xa_newMP,xb_newMP ] = switch_channel(raw, 2 );

%% 
DP_area = [];
MP_area = [];

for i = 1: length(xa_newDP)
    for j = 1: length(xa_newMP)
        %if xa_newMP(j) > xa_newDP(i) & xa_newMP(j) < xa_newDP(i)+ 500
        if xa_newMP(j) == xa_newDP(i)
            DP_area = [DP_area area_peak_DP(j)];
            MP_area = [MP_area area_peak_MP(j)];
        end
    end
end
%% 


