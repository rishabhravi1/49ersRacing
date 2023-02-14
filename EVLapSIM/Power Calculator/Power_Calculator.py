import pandas as pd
import numpy as np

# Take inputs
VehicleMass = 40.194277
VelocityTrace = pd.read_csv('EnduranceVelocityTrace.csv').values
time = VelocityTrace[:, 0]
Velocity = VelocityTrace[:, 1]
Velocity = 0.3048 * Velocity
AccelerationTrace = pd.read_csv('EnduranceAccelerationTrace.csv').values
Acceleration = AccelerationTrace[:, 1]
Acceleration = 9.81 * Acceleration
air_density = 1.225
frontal_area = 1.8
CD = 0.25
Croll = 0.2

# Calculate Power
Power = VehicleMass * AccelerationTrace * VelocityTrace + (1/2) * air_density * frontal_area * CD * VelocityTrace**3 + Croll * VehicleMass * VelocityTrace

# Calculate Energy
time_limits = [np.min(time), np.max(time)]
time_index = (time_limits[0] <= time) & (time <= time_limits[1])
dx = time[1] - time[0]
Energy = np.sum(Velocity[time_index]) * dx

print('The Energy required for 1 lap is: {} joules'.format(Energy))

total_Energy = (Energy * 13) / 3600
print('Total Energy required to complete endurance is: {} Kilo watt-hours'.format(total_Energy))
