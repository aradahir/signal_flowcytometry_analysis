function CP = gmclust(X,gr,bins,opt_pic);
[hY hX] = hist(X,bins);
color = jet(gr);
GM = fitgmdist(X,gr);
ID = cluster(GM,X);
for g = 1:gr;
    CL{g} = X(ID == g);
    maxCL(g) = max(CL{g});
    minCL(g) = min(CL{g});
end

if opt_pic == 1;
area(hX,hY);
hold on
    for g = 1:gr
        line([minCL(g) minCL(g)],[0 max(hY)],'color',color(g,:));
        line([maxCL(g) maxCL(g)],[0 max(hY)],'color',color(g,:));
        pause
    end
else end
CP = min(maxCL);
end