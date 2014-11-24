function allAverageG = calc_slic(data,maxShift)
% calc_slic performs SLIC (Scanning Laser Image Correlation Spectroscopy)
% analysis on a data set. 
% 
% ALLAVERAGEG = calc_slic(DATA,MAXSHIFT) performs slic analysis on a data
% set, DATA where DATA is a two dimensional array where the x axis
% represnets location and the y axis represents time. In a SLIC
% measurements the row corresponds to a trace of a laser scan. MAXSHIFT is
% the maximum spacing between locations to calculate a correlation. 

% copyright Molly J. Rossow 2009

allPixShift = 1:maxShift;
s = size(data);
allAverageG = zeros(s(1),255);
index = 1;
% For each pixel shift, calculate the correlation.
for i = 1:length(allPixShift)
    p = allPixShift(i);
    [averageG,~] = n_pixel_shifted_corr(data,p);
    allAverageG(:,index) = averageG;
    index = index +1;
end
