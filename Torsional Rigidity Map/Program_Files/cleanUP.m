function cleanUP
    % Load image
    %Calculate polar moment of inertia
    myFiles = dir ('*.bmp');
    for mm= 1:length(myFiles)
        % Load the image into Matlab
        image = imread(myFiles(mm).name);

        imwrite(image,(myFiles(mm).name));
    end
end
