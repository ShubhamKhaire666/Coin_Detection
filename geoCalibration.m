function [hpx2mm, vpx2mm] = geoCalibration(i)

[m,n,~]=size(i);

%%
hpx2mm=ceil(m*round(25.4/300,1));
vpx2mm=ceil(n*round(25.4/300,1));

%%
end

