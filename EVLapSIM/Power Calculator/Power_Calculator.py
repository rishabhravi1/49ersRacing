import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Take inputs
VehicleMass = 317  # Kg
VelocityTrace = pd.read_csv('EnduranceVelocityTrace.csv').values
time = VelocityTrace[:, 0]  # set time seconds
Velocity = VelocityTrace[:, 1]
Velocity = 0.3048 * Velocity  # convert to m/s
AccelerationTrace = pd.read_csv('EnduranceAccelerationTrace.csv').values
Acceleration = AccelerationTrace[:, 1]
Acceleration = 9.81 * Acceleration  # convert to m/s^2
air_density = 1.204  # kg/M^3
frontal_area = 1.8  # m^2
CD = 0.25
Croll = 0.2
count = 0
RegenEf = 0.3
MaxEnergy = 8000
n = 1

# Calculations
Power = (VehicleMass * Acceleration * Velocity) + ((1 / 2) * air_density * frontal_area * CD * Velocity ** 3) + (
            Croll * VehicleMass * Velocity)

dx = time[1] - time[0]  # Calculate the step size
Energy = Power * (dx / ((60 ** 2) * 1000))
EnergyN = np.where(Energy < 0)[0]
EnergyP = np.where(Energy > 0)[0]
N = len(EnergyP)
EnergyP[EnergyP > MaxEnergy] = MaxEnergy
EnergyRegen = EnergyN * RegenEf
EnergyTotal = (np.sum(EnergyP) - np.sum(EnergyRegen)) / 1000  # kwh output
print(f"{EnergyTotal} kwh of energy per lap")

sns.set_style('darkgrid')

plt.figure(figsize=(8, 6))
sns.lineplot(x=time, y=Acceleration)
plt.title('Acceleration')
plt.xlabel('Time (s)')
plt.ylabel('Acceleration (m/s^2)')
plt.show()

plt.figure(figsize=(8, 6))
sns.lineplot(x=time, y=Velocity)
plt.title('Velocity')
plt.xlabel('Time (s)')
plt.ylabel('Velocity (m/s)')
plt.show()

plt.figure(figsize=(8, 6))
sns.lineplot(x=time, y=Energy)
plt.title('Energy')
plt.xlabel('Time (s)')
plt.ylabel('Energy (kW)')
plt.show()

plt.figure(figsize=(8, 6))
sns.lineplot(x=time, y=Power)
plt.title('Power')
plt.xlabel('Time (s)')
plt.ylabel('Power (kW)')
plt.show()
