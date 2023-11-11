function [ xa_r, xb_r, cut_1, width ] = peak_xaxis1( x, coeff )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
blue = x(2000000:end);
%blue = x;

%cut_1 = mean(blue1)+3*std(blue1)+5;
%oldversion 
cut_1= prctile(blue,[1 99]) + coeff;

cnt = 0;  
xa = [];
xb = [];
  
for i = 200000:length(x)
    if  x(i) > cut_1(2)  & cnt == 0
        cnt = 1;
        xa = [xa i];
    elseif x(i)< cut_1(2) & cnt ==1
        cnt = 0;
        xb = [xb i];
    end        
end

xa= xa(1:length(xb));
width = xb-xa;
%cut_2= prctile(width,[7.5 80])
cut_2= prctile(width,[1 99]) ;

xa_r = [];
xb_r = [];
for j = 1: length (width)
    if  width(j) <= cut_2(2) & width(j) > cut_2(1)
        xa_r = [xa_r xa(j)];
        xb_r = [xb_r xb(j)];
    end        
end

end

