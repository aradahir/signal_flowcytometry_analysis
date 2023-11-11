function [ area_peak2 ] = areapeak( xa,xb,x )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
area_peak2 = [];
for i = 1:length(xa)
    area =0;
    for k = xa(i):xb(i)  
        area= area + x(k);
    area_peak2 =[area_peak2 area] ;
    end
end

