% Example for SLIC calculation on simulated data. The files speed3.mat and
% speed5.mat where created using simple_flow_simulation.m and represent
% particles flowing at 3 pixels per frame and 5 pixels per fram
% respectively. The simulated data sets are added together to the analysis
% considers data with two populations moving at different speeds. The
% simulated data includes entire frames (such as would be acquired with a
% camera) selected a sinlge horizontal line simulates a set of pixels
% scanned with a laser as in done in a SLIC measurement. 
%
% copyright Molly J. Rossow 2009

clear all

% Load simulated data
load('speed_3.mat')
lines = simMat(128,:,:); % Select one line across the entire image to 
                         % represent a scanned line. 
nMat1 = reshape(lines,[256,1024])';
load('speed_5.mat')
lines = simMat(128,:,:); % Select one line across the entire image to 
                         % represent a scanned line. 
nMat2 =reshape(lines,[256,1024])';

% Add data at two speed s
data = nMat1 + nMat2;

% Calculate SLIC
allAverageG = calc_slic(data,255);

% Plot results
figure
subplot(1,2,1)
imagesc(data)
colormap('gray')
set(gca,'XAxisLocation','top')
title('Simulated Data')
xlabel('location')
ylabel('time')

subplot(1,2,2)
imagesc(allAverageG(1:256,:))
xlabel('distance')
ylabel('correlation shift')
set(gca,'XAxisLocation','top')
colorbar





