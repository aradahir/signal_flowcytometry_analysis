function [ xa_r, xb_r, width ] = peak_xaxis( x )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
blue = x(2000000:end);
blue1 = movmean(blue,3); 

%cut_1 = mean(blue1)+3*std(blue1)+5;
%newversion 
cut_1= prctile(blue,[1 99])+22
%cut_1= prctile(blue1,[1 95])+5
cnt = 0;  
xa = [];
xb = [];
  
for i = 2000000:length(x)
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
cut_2= prctile(width,[30 80])

cnt = 0;
xa_r = [];
xb_r = [];
for j = 1: length (width)
    if  width(j) > cut_2(1) 
        xa_r = [xa_r xa(j)];
        xb_r = [xb_r xb(j)];
    end        
end


% xa_new = xa;
% xb_new = [];
% for  n = 2: length(xa)
%     for m = x_remove(n): xa(n)
%         if xa(
%            xa_new(m) = 0;
%         end
%         xa_new(n) = xa(n);
%     end
% end
