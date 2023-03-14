import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Take inputs
VehicleMass = 317  # Kg
VelocityTrace = pd.read_csv('C:\Users\optim/Documents/GitHub/49ersRacing/EVLapSIM/Power Calculator/EnduranceVelocityTrace.csv')
time = VelocityTrace.iloc[:, 0].values  # set time seconds
Velocity = VelocityTrace.iloc[:, 1].values
Velocity = 0.3048 * Velocity  # convert to m/s
AccelerationTrace = pd.read_csv('C:/Users/optim/Documents/GitHub/49ersRacing/EVLapSIM/Power Calculator/EnduranceAccelerationTrace.csv')
Acceleration = AccelerationTrace.iloc[:, 1].values
Acceleration = 9.81 * Acceleration  # convert to m/s^2
air_density = 1.204  # kg/M^3
frontal_area = 1.8  # m^2
CD = 0.25
Croll = 0.2
count = 0
RegenEf = 0.3
MaxPower = 80000
n = 1
Laps = 22
TireRadius = 0.3556  # meters
GearRatio = 3.91

# power calculation
Power = (VehicleMass * Acceleration * Velocity) + ((1 / 2) * air_density * frontal_area * CD * Velocity ** 3) + (
            Croll * VehicleMass * Velocity)

# tourque calcuation
RPMWheel = (Velocity / TireRadius * (1 / (2 * np.pi) * 60))
RPMMOTOR = (RPMWheel * GearRatio)
torque = (Power * 9.549) / RPMMOTOR
torque = np.sort(torque)

# plot torque
plt.figure(9)
plt.plot(RPMMOTOR, torque)
plt.title('torque over RPM')
plt.xlabel('RPM')
plt.ylabel('torque (nm)')

# energy calculation
Power[Power > MaxPower] = MaxPower
Prows = Power.size
counter1 = 1
J = np.zeros(Prows)
Dtime = []
DPower = []
while (counter1 <= (Prows - 3)):
    Dtime = [time[counter1], time[counter1 + 1], time[counter1 + 2]]
    DPower = [Power[counter1], Power[counter1 + 1], Power[counter1 + 2]]
    Energy = np.trapz(Dtime, DPower)
    J[counter1] = Energy
    counter1 = counter1 + 1
J = J / 1000

plt.figure(1)
plt.plot(time, J)
plt.title('energy/time')
plt.xlabel('time(s)')
plt.ylabel('energy(Wh)')

EnergyP = J[J > 0]
EnergyN = J[J < 0]
EnergyRegen = EnergyN * RegenEf
EnergyTotal = (np.sum(EnergyP) + np.sum(EnergyRegen)) / 10000  # kwh output
EnduranceEnergy = EnergyTotal * Laps
print(f'{EnergyTotal:.3f} kwh of energy per lap')
print(f'{EnduranceEnergy:.3f} Kwh of energy for endurance')

sns.set(style='whitegrid')
plt.show()
