function [TR] = moveSTL(TR,trans,rotation)

% define transformations
transX = trans(1);
transY = trans(2);
transZ = trans(3);

% define angles of rotation
THx = rotation(1);
THy = rotation(2);
THz = rotation(3);

% cull the x,y & z coordinates from data matrix + apply transformations
TR.vertices(:,1) = TR.vertices(:,1) + transX;
TR.vertices(:,2) = TR.vertices(:,2) + transY;
TR.vertices(:,3) = TR.vertices(:,3) + transZ;

% define rotation matrices
Rx = [cosd(THx) sind(THx) 0; -sind(THx) cosd(THx) 0; 0 0 1];
Ry = [cosd(THy),0,sind(THy);0,1,0;-sind(THy),0,cosd(THy)];
Rz = [cosd(THz),-sind(THz),0;sind(THz),cosd(THz),0;0,0,1];

% combine i,j,k into one object matrix & rotate
TR.vertices = TR.vertices*Rx*Ry*Rz;

end