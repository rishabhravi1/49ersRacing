function [EnduranceEnergy,PosRPM,PosTorque] = powerCalculator(VehicleMass,VelocityTrace,AccelerationTrace,air_density,frontal_area,CD,Croll,RegenEf,MaxPower,Laps,TireRadius,GearRatio)
%calculates accumulator capacity from velocity over time and acceleration
%over time
%   Detailed explanation goes here
%% Take inputs
%VehicleMass = 317; %Kg
%VelocityTrace = csvread('EnduranceVelocityTrace.csv');
time = VelocityTrace( :,1); %set time seconds
Velocity = VelocityTrace(:,2);
Velocity = Velocity ./ 3.281; %convert to m/s
%AccelerationTrace = csvread('EnduranceAccelerationTrace.csv');
Acceleration = AccelerationTrace(:,2);
Acceleration = 9.81 .* Acceleration; %convert to m/s^2
%air_density = 1.204; %kg/M^3
%frontal_area = 1.8; %m^2
%CD = .19;
%Croll = .2;
count = 0;
%RegenEf = .3;
%MaxPower = 80000;
n = 1;
%Laps = 22;
%TireRadius = .3556;%meters
%GearRatio = 3.91;

%% calculations

%power calculation
Power = ((VehicleMass .* Acceleration) + ((1/2) * air_density * frontal_area .* CD .* Velocity .^2) + (Croll .* VehicleMass)) .* Velocity;


%tourque calcuation
RPMWheel = (Velocity./TireRadius*(1/(2*pi)*60));
RPMMOTOR = (RPMWheel*GearRatio);
torque = (Power*9.549) ./ RPMMOTOR;
sort(torque);
torqueRPM = [torque,RPMMOTOR];
totalTorque = numel(torque);
for i=1:totalTorque
if(torque(i)<=0)
    minTorqueRow = i;
    break
end
end
minTorqueRow = minTorqueRow-1;
PosTorque = torque(1:minTorqueRow,1);
PosRPM = RPMMOTOR(1:minTorqueRow,1);



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

dx = time(2) - time(1); % Calculate the step size
Energy = Power .* dx;
EnergyN = find(Energy<0);
EnergyP = find(Energy>0);
N = numel(EnergyP);
%EnergyP(EnergyP>MaxEnergy) = MaxEnergy;
EnergyRegen = EnergyN .* RegenEf;
EnergyTotal = (sum(EnergyP) - sum(EnergyRegen)); %wh output





EnergyP = J(J>0);
EnergyN = J(J<0);
EnergyRegen = EnergyN .* RegenEf;
EnergyTotal = (sum(EnergyP) + sum(EnergyRegen))/10000; %kwh output
EnduranceEnergy = EnergyTotal * Laps;

end