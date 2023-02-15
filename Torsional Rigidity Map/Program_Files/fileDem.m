function [x,y,z] = fileDem(TR)
%% Chassis Dimensions Calculation
%Calculates the dimensions of the chassis
Zmax = NaN;
Zmin = NaN;
Xmax = NaN;
Xmin = NaN;
Ymax = NaN;
Ymin = NaN;
for row = 1:size(TR.vertices,1)
    if abs(TR.vertices(row,1)) > Zmax || isnan(Zmax)
        Zmax = abs(TR.vertices(row,1));
    end
    if abs(TR.vertices(row,1)) < Zmin || isnan(Zmin)
        Zmin = abs(TR.vertices(row,1));
    end
    if abs(TR.vertices(row,2)) > Ymax || isnan(Ymax)
        Ymax = abs(TR.vertices(row,2));
    end
    if abs(TR.vertices(row,2)) < Ymin || isnan(Ymin)
        Ymin = abs(TR.vertices(row,2));
    end
    if abs(TR.vertices(row,3)) > Xmax || isnan(Xmax)
        Xmax = abs(TR.vertices(row,3));
    end
    if abs(TR.vertices(row,3)) < Xmin || isnan(Xmin)
        Xmin = abs(TR.vertices(row,3));
    end
end
z = Zmax - Zmin;
y = Ymax - Ymin;
x = Xmax - Xmin;
end