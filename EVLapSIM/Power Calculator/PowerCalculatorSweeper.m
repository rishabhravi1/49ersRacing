clear
clc
Iterations = input('number of steps less than 5: ');
Mass = 317; %Kg
VelocityTrace = readmatrix('EnduranceVelocityTrace.csv');
AccelerationTrace = readmatrix('EnduranceAccelerationTrace.csv');
air_density = 1.204; %kg/M^3
frontal_area = .937; %m^2
CD = 0;
Croll = .2;
RegenEf = .3;
MaxPower = 80000;
Laps = 22;
TireRadius = .3556;%meters
GearRatio = 3.91;
MaxCD = input('max CD in sweep: ');



for R = 1: Iterations
    C = 1;
    CD = CD +(MaxCD/Iterations);
    g(R,:) = powerCalculator(Mass,VelocityTrace,AccelerationTrace,air_density,frontal_area,CD,Croll,RegenEf,MaxPower,Laps,TireRadius,GearRatio);
    j(R,:) = CD;
end
figure(R)
plot(j,g)
ylabel('capacity(Kwh)')
xlabel('CD')
title('CD = %f',CD)
