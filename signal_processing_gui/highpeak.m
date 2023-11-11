function [ high_peak ] = highpeak( xa,xb,x )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
high_peak = [];

for i = 1:length(xa)
    high_point = [];
    for k = xa(i):xb(i)  
       high_point =[high_point x(k)] ;
    end
    high_peak = [high_peak max(high_point)];
end     
end


