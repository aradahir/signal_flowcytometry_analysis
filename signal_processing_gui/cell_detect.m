function [ area_peak, median_area, mean_area, count, CV,xa_new,xb_new] = cell_detect( x, coeff, channel )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[ xa, xb, cut ] = peak_xaxis1(x,coeff);
[ higharea ] = highpeak(xa,xb,x);
[xa_new, xb_new] = singlecelldetection(x, xa,xb,higharea,channel);
[ area_peak ] = 0.7*areapeak(xa_new,xb_new,x);
median_area = median( area_peak );
mean_area = mean(area_peak);
count = length(area_peak); 
CV = std(area_peak)/sqrt(count);
end

