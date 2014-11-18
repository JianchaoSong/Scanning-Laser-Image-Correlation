function [] = simple_flow_simulation(amp, directory, speed, background, diameter)
% simple_flow_simulation creates a simple simulation of flowing particles.
%
% simple_flow_simulation(AMP,DIRECTORY,SPEED,BACKGROUND) simulates a series
% of images with particles represented by circles flowing through them and
% saves the results as mat files. AMP is the intensity amplitude of the
% particles. DIRECTORY is the directory where the resutls of the
% simulations are saved. SPEED is a vector containing a series of
% velcoities in pixels per frame. One simulation is performed for each
% velocity. BACKGROUND is the amplitude of the background intensity. Each
% circle has diamter DIAMETER. 
% 
% In the simulation, particles from in the positive x direction with a
% velocity from the input argument SPEED and has a random offset in the x
% and y direction corresponding to a diffusion coefficient of  0.00033
% pixels^2/second. 
%
% Example:
% simple_flow_simulation(1,cd,[1,2],0.1,5)
%
% copyright Molly J. Rossow 2009

% Set image size
imageSizeX = 256;
imageSizeY = 50;

% Number of frames
nFrames = 1024;

% Initial locations of circles
x = abs(imageSizeX*randn([1,1500]));
y = abs(imageSizeY*randn([1,1500]));
index = find(x<imageSizeX);
x = x(index);
y = y(index);
index = find(y<imageSizeY);
x = x(index);
y = y(index);
simMat = background.*ones(imageSizeY,imageSizeX,nFrames);

for j = 1:length(speed) % Displacement loop
    d = speed(j);
    for t = 1:nFrames % Frame loop
        % Create matrix
        tempFrame = zeros(imageSizeY,imageSizeX);% Frame without noise
        % Check for x and y greater than image size
        index = find(x>(imageSizeX+diameter/2));
        if length(index)>1 
            x(index) = x(index) - imageSizeX;
            y(index) = abs(imageSizeY*randn([1,length(index)]));
        end
        % Check for x and y less the 1 (due to diffusion)
        index = find(x<1);
        x(index) = 1;
        y(index) = 1;
        index = find(y<1);
        x(index) = 1;
        y(index) = 1;

        for i = 1:length(x) % Draw cirlces loop
            currentX = x(i);
            currentY = y(i);
            circleIndices = fill_in_circles(diameter,currentX,currentY,imageSizeX,imageSizeY);
            tempFrame(circleIndices) = amp;
        end % Draw cirlces loop

        % Move particles
        Dt =  0.00033; % Diffusion coefficient
        sigma = sqrt(2*Dt);
        x = x + d + sigma*randn([1,length(y)]);
        y = y + sigma*randn([1,length(y)]);
        simMat(:,:,t) = tempFrame;
    end % Frame loop
    
    try
        str = num2str(d);
        ind = find(str == '.');
        str(ind) = 'p';
        save([directory '\speed_' str '.mat'],'simMat');
    catch
        ['could not save' directory 'd' num2str(d)]
    end

end %displacement loop


