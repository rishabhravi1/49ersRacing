clear
%% Take inputs
VehicleMass = 40.194277;
VelocityTrace = csvread('EnduranceVelocityTrace.csv');
time = VelocityTrace( :,1);
Velocity = VelocityTrace(:,2);
Velocity = .3048 .* Velocity;
AccelerationTrace = csvread('EnduranceAccelerationTrace.csv');
Acceleration = AccelerationTrace(:,2);
Acceleration = 9.81 .* Acceleration;
air_density = 1.225;
frontal_area = 1.8;
CD = .25;
Croll = .2;

%%
Power = VehicleMass .* AccelerationTrace .* VelocityTrace + (1/2)* air_density * frontal_area * CD .* VelocityTrace.^3 + Croll * VehicleMass .* VelocityTrace;


time_limits = [min(time), max(time)];
time_index = time_limits(1) <= time & time <= time_limits(2);
dx = time(2) - time(1); % Calculate the step size
Energy = sum(Velocity(time_index)) * dx;

disp(['The Energy required for 1 lap is: ', num2str(Energy), ' joules']);

total_Energy = (Energy*13)/3600;
disp(['Total Energy required to complete endurance is: ', num2str(total_Energy), ' watt-hours']);
