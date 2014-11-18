function circleIndices = fill_in_circles(d, x, y, imageSizeX, imageSizeY)
% fill_in_circles returns the indices for plotting a filled in circled.
%
% CIRCLEINDICES = fill_in_circles(D, X, Y, imageSizeX, imageSizeY) Returns
% the indices for plotting a filled in circle with diamater D centered at
% coordinates X and Y in an image with dimensions IMAGESIZEX and
% IMAGESIZEY. 

 circleIndices = [];
 
for k = 1:d % Fill in circle loop (for one circle)
    cols = x-k/2:0.1:x+k/2;
    rows1 = [sqrt((k/2)^2-(cols-x).^2)]+y;
    rows2 = [-sqrt((k/2)^2-(cols-x).^2)]+y;
    cols = [cols cols];
    rows = [rows1, rows2];

    % Throw out points out side of image
    % Throw out points to the right of the images
    index = find(cols>1); %Index to keep
    rows = rows(index);
    cols = cols(index);
    index = find(rows>1);% Index to keep
    rows = rows(index);
    cols = cols(index);
    
    % Throw out points to the left of the image
    index = find(cols<imageSizeX);% Index to keep
    rows = rows(index);
    cols = cols(index);
    index = find(rows<imageSizeY);% Index to keep
    rows = rows(index);
    cols = cols(index);

    I = sub2ind([imageSizeY,imageSizeX],round(rows),round(cols));
    circleIndices = [circleIndices I];
end 