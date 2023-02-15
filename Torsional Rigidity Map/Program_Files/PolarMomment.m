function [PolarMatrix] = PolarMomment()
    %Calculate polar moment of inertia
    myFiles = dir ('*.bmp');
    PolarMatrix = zeros(length(myFiles),1);
    for J = 1:length(myFiles)
        % Read the BMP file into a matrix
        im = imread(myFiles(J).name);
        im = im2bw(im == 0);
        
        % Find the coordinates of all white pixels
        [x, y] = find(im);
        
        % Compute the area of each white pixel (assumed to be constant)
        A = 1; %mm^2
        A = A/100; %Scalling

        % Compute the area moment of inertia
        I = sum(((x./10).^2 + (y./10).^2) * A);
        
        % Display the total area moment of inertia
        PolarMatrix(J) = I;
    end
    PolarMatrix=PolarMatrix';
end