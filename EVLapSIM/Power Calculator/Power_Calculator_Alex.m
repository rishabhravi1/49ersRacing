clear
clc
%% Take inputs
VehicleMass = 317; %Kg
VelocityTrace = csvread('EnduranceVelocityTrace.csv');
time = VelocityTrace( :,1)./(60^2); %convert seconds to hours
Velocity = VelocityTrace(:,2);
Velocity = .3048 .* Velocity; %convert to m/s
AccelerationTrace = csvread('EnduranceAccelerationTrace.csv');
Acceleration = AccelerationTrace(:,2);
Acceleration = 9.81 .* Acceleration; %convert to m/s^2
air_density = 1.204; %kg/M^3
frontal_area = 1.8; %m^2
CD = .25;
Croll = .2;
count = 0;
RegenEf = .3;
MaxEnergy = 8000;
n = 1;

%%
Power = (VehicleMass .* Acceleration .* Velocity) + ((1/2) * air_density * frontal_area * CD .* Velocity .^3) + (Croll * VehicleMass .* Velocity);
figure(1)
plot(time, Power)

dx = time(2) - time(1); % Calculate the step size
Energy = Power .* dx;
EnergyN = find(Energy<0);
EnergyP = find(Energy>0);
N = numel(EnergyP);
EnergyP(EnergyP>MaxEnergy) = MaxEnergy;
EnergyRegen = EnergyN .* RegenEf;
EnergyTotal = sum(EnergyP) - sum(EnergyRegen);
fprintf('%f Wh of energy per lap', EnergyTotal)

figure(4)
plot(time,Acceleration)
title('Acceleration')
figure(2)
plot(time,Velocity)
title('velocity')
figure(5)
plot(time,Energy)
title('energy')

