clc
clear
Length = 4; %cm
minSweep = .00000000001;
steps = 100;
Width = linspace(minSweep,1,steps); %cm
Thickness = linspace(minSweep,1,steps); %cm
Hf = 293; %Kj/Kg (heat of fusion)
Density = 8.908; %g/cm^3 (density)
R = .0000064; %ohm-cm
i = 60;
J = 1;
maxblowT = .015;
minblowT = .05;


for W = 1:steps
    for T = 1:steps      
mass = (Length*Width(W)*Thickness(T)*Density)/1000; %mass in Kg
r = (R.*Length)/(Width(W)*Thickness(T));
time(J,1) = (i^2*r)/(mass*Hf);
width(J,1) = Width(W);
thickness(J,1) = Thickness(T);
J = J+1;
    end
end

for S = 1:numel(time)
    if(time(S,:) <= maxblowT)
            thicknessI(S,1) = thickness(S,:);
            widthI(S,1) = width(S,:);
            timeI(S,1) = time(S,:);        
    end
end
% thicknessI = nonzeros(thicknessI);
% widthI = nonzeros(widthI);
% timeI = nonzeros(timeI);

output = [thicknessI,widthI];

for p = 1:numel(thicknessI)
    area(p) = thicknessI(p,1)*widthI(p,1);
end
maxArea = max(area);
minArea = min(area);

% figure(1)
% plot3(thicknessI,widthI,timeI)
% xlabel('thickness(cm)')
% ylabel('width(cm)')
% zlabel('blow time(S)')
% 
% figure(2)
% plot(thicknessI,widthI,'*')
% xlabel('width(cm)')
% ylabel('thickness(cm)')

