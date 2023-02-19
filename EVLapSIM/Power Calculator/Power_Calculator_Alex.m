clear
clc
%% Take inputs
VehicleMass = 317; %Kg
VelocityTrace = csvread('EnduranceVelocityTrace.csv');
time = VelocityTrace( :,1); %set time seconds
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
MaxPower = 80000;
n = 1;
Laps = 22;
TireRadius = .3556;%meters
GearRatio = 3.91;

%% calculations

%power calculation
Power = (VehicleMass .* Acceleration .* Velocity) + ((1/2) * air_density * frontal_area * CD .* Velocity .^3) + (Croll * VehicleMass .* Velocity);

%tourque calcuation
RPMWheel = (Velocity./TireRadius*(1/(2*pi)*60));
RPMMOTOR = (RPMWheel*GearRatio);
torque = (Power*9.549) ./ RPMMOTOR;
sort(torque);

%plot torque
figure(9)
plot(RPMMOTOR,torque)
title('torque over RPM')
xlabel('RPM')
ylabel('torque (nm)')

%energy calculation
Power(Power>MaxPower) = MaxPower;
Prows = numel(Power);
counter1 = 1;
J = zeros(Prows,1);
Dtime = [];
DPower = [];
while(counter1 <= (Prows-3))
    Dtime = [time(counter1,1);time(counter1 + 1,1);time(counter1 + 2,1)];
    DPower = [Power(counter1,1);Power(counter1 + 1,1);Power(counter1 + 2,1)];
    Energy = (trapz(Dtime, DPower));
    J(counter1)=Energy;
    counter1 = counter1 + 1;
end
J = J ./ 1000;

figure(1)
plot(time,J)
title('energy/time')
xlabel('time(s)')
ylabel('energy(Wh)')

EnergyP = J(J>0);
EnergyN = J(J<0);
EnergyRegen = EnergyN .* RegenEf;
EnergyTotal = (sum(EnergyP) + sum(EnergyRegen))/10000; %kwh output
EnduranceEnergy = EnergyTotal * Laps;
fprintf('%f kwh of energy per lap ', EnergyTotal)
fprintf('%f Kwh of energy for endurance',EnduranceEnergy)



