function [] = SliceSTL(filename,TR,n)
V = TR.vertices;
F = TR.faces;

VVV(:,1)=((V(:,1)-max(max(V))/2)*1);
VVV(:,2)=((V(:,2)-max(max(V))/2)*1);
VVV(:,3)=((V(:,3)-max(max(V))/2)*1);


VVV = VVV * 10; % Adjust scale for higher resoltion

disp(['CAD file ' filename ' imported.....'])

v_number=max(max(F));

new_VV(:,1)=VVV(:,1)-min(min(VVV(:,1)));
new_VV(:,2)=VVV(:,2)-min(min(VVV(:,2)));
new_VV(:,3)=VVV(:,3)-min(min(VVV(:,3)));
clear VVV

disp('Slicing Started.......')
max_X=max(max(new_VV(:,1)));
max_Y=max(max(new_VV(:,2)));

%% Slicing

%Slicing Mode
% 1: Image w/ hole select
% 2: Fabrication
% 3: Fabrication w/ contour
% 4: Fabrication w/ hole select
mode=3;

%Size of Figure
area_mode=2;   % 1:Automatic  2:Manual type in below
height=20000;   % x- size of figure
width=20000;   % y- size of figure

new_VV(:,1)=new_VV(:,1)+height/2-max_X/2; % Set x- of obj. in center.
new_VV(:,2)=new_VV(:,2)+width/2-max_Y/2; % Set y- of obj. in center.
Z_Zp=max(new_VV(:,3));  % Height of object

Zp_1=uint16(linspace(1,(Z_Zp-1),n));  % z- axial of object slicing

    for kk=1:n
        slic_save_v2(v_number,new_VV,Zp_1(kk),kk,mode,area_mode,height,width);
    end
end