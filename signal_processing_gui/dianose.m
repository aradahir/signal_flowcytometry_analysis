function [ type ] = dianose( meanx, count, channel, threshold )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    switch channel
        case 2
            if count<100
                 type =  'low event';
            elseif meanx > threshold
                 type =  'Mia positive';
            elseif meanx<= threshold
                 type = 'Mia negative';
            end
        case 1
            if count<100
                 type =  'low event';
            elseif meanx  > threshold
                 type = 'Rh positive';
            else 
                 type = 'Rh negative';
            end
        case 3
            if count<100
                 type = 'low event';
            elseif meanx > 1500
                 type = 'Rh positive';
            elseif meanx > 200 & meanx <= 1500
                 type = 'Rh weak';
            else 
                 type = 'Rh negative';
            end
    end
end

