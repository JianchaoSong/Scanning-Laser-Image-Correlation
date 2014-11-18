function [averageG, allGs] = n_pixel_shifted_corr(data, nPixel)
% n_pixel_shifted_corr cross correlation between all pixels with a fixed 
% distancebetween them. 
%
%  [AVERAGEG, ALLGS] = n_pixel_shifted_corr(DATA, NPIXEL) calculates the
%  cross correlation between columns of the 2 dimensional matrix d that are
%  nPixel distance apart and returns allGs, a 2 dimensional matrix
%  containing all sets of pair correlations and averageG, a 1 dimensional
%  matrix containing the average of the curves in allGs. Correlation is
%  calculated between the left and the right pixel.
%
%  copyright Molly J. Rossow 2009


s = size(data);
ydim = s(1);
fTransform = fft(data,[],1); %fft of columns
sA = single(repmat(sum(data(:,1+nPixel:end),1),[ydim,1]));
sB = single(repmat(sum(data(:,1:end-nPixel),1),[ydim,1]));
clear matrix3D
P = fTransform(:,1+nPixel:end).*conj(fTransform(:,1:end-nPixel));
clear fTransform
graw = ifft(P,[],1);
clear P

%normalize graw
allGs = graw.* ydim./(sA.*sB) - 1;

averageG = mean(allGs,2);




