%% This programs graphs torsional rigidity over the length of a chassis
% This code my not be redistributed by anyone.

%By: Joseph Cranfill
% Date: 12/15/22

clear
clc
close all
warning off

%% Inputs
%Enter the name of the stl file you are looking to test
%Must be a Binary STL file
filename = 'Chassis_Rev2.STL'; %'model.stl'

%Name of the folder you want the files saved to
foldername = 'Rev1'; %'Rev1'

%Translates the maxtrix in the x,y,z direction
trans = [0,0,0]; %[x,y,z]

%Rotates the matrix about the x,y,z axis
rotation = [0,-90,0]; %[x,y,z]

% Resolution(# of slices)
% The higher the resolution the longer the sim will take to run.
n=20; %1-999

%Shear Modulas of Material
G=80; %GPa

%% --------------------- DO NOT EDIT BELOW THIS LINE ---------------------
%% Folder Setup
mkdir (foldername)
addpath(genpath('Program_Files'))

%% Load the STL file
TR = stlread(filename);
TR = moveSTL(TR,trans,rotation);
patch(TR,'FaceColor',       [0.8 0.8 1.0], ...
         'EdgeColor',       'none',        ...
         'FaceLighting',    'gouraud',     ...
         'AmbientStrength', 0.15);

% Add a camera light, and tone down the specular highlighting
camlight('headlight');
material('dull');

% Fix the axes scaling, and set a nice view angle
axis('image');
view(2)

%set up graph
grid on
set(gca, 'fontsize', 14)
xlabel ('Length of Chassis(mm)')
ylabel ('Height of Chassis(mm)')
title('Torsional Rigidity Over the Length of Chassis')
yyaxis right
ylabel ('Torsional Stiffness(N.m/deg)/m')
hold on

%% Chassis Dimensions Calculation
%Calculates the dimensions of the chassis
[x,y,z]= fileDem(TR);

%% Calculate Polar moment of inertia from stl cross sections
%Read file
[F,V,N] = stlread(filename);
TR = moveSTL(TR,trans,[0,90,-90]);

%Slice stl file and export cross sections as bmp files
SliceSTL(filename,TR,n)
cleanUP;
[J] = PolarMomment;

L = z/n;
Length = 0:z/(n-1):z;

%% Conversions
J=J*(10^-12); %mm^4 to m^4 
z=z/1000; %mm to m
G=G*10^9; %GPa to N/m^2

%% Calculates Rigidity of any Section on the Chassis
Tr=(J*G*(pi/180));

%% Plots the data
plot(Length, Tr, "LineWidth",2 ) 
hold off
saveas(gcf,'Map.png')

%% Display Logo
line1 ='  _  _   ___               _____            _             ';
line2 =' | || | / _ \             |  __ \          (_)            ';
line3 =' | || || (_) |___ _ __ ___| |__) |__ _  ___ _ _ __   __ _ ';
line4 =' |__   _\__, / _ \  _ / __|  _  // _  |/ __| |  _ \ / _  |';
line5 ='    | |   / / (__/ |  \__ \ | \ \ (_| | (__| | | | | (_| |';
line6 ='    |_|  /_/ \___|_|  |___/_|  \_\__,_|\___|_|_| |_|\__, |';
line7 ='                                                     __/ |';
line8 ='                                                    |___/ ';

fprintf('%s', line1)
fprintf('\n')
fprintf('%s', line2)
fprintf('\n')
fprintf('%s', line3)
fprintf('\n')
fprintf('%s', line4)
fprintf('\n')
fprintf('%s', line5)
fprintf('\n')
fprintf('%s', line6)
fprintf('\n')
fprintf('%s', line7)
fprintf('\n')
fprintf('%s', line8)
fprintf('\n')
fprintf('Torsional Rigidity Calculator\nBy: Joseph Cranfill\nLast Revision: 12/26/2022\n\n')

%% Move files to folder
movefile('*.bmp', foldername);
movefile('Map.png', foldername);
%movefile(filename, foldername); %%Comment out for testing