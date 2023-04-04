import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def power_calc(VehicleMass = 317,
                air_density = 1.204,  # kg/M^3
                frontal_area = 1.8,  # m^2
                CD = 0.25,
                Croll = 0.2,
                count = 0,
                RegenEf = 0.3,
                MaxPower = 80000,
                TireRadius = 0.3556, # meters
                GearRatio = 3.91):
      # Kg
    VelocityTrace = pd.read_csv('EnduranceVelocityTrace.csv').values
    time = VelocityTrace[:, 0]  # set time seconds
    Velocity = VelocityTrace[:, 1]
    Velocity = 0.3048 * Velocity  # convert to m/s
    AccelerationTrace = pd.read_csv('EnduranceAccelerationTrace.csv').values
    Acceleration = AccelerationTrace[:, 1]
    Acceleration = 9.81 * Acceleration  # convert to m/s^2
    
    n = 1
    Laps = 22
    

    # power calculation
    Power = (VehicleMass * Acceleration * Velocity) + ((1 / 2) * air_density * frontal_area * CD * Velocity ** 3) + (
                (Croll * VehicleMass) * Velocity)

    # torque calculation
    RPMWheel = ((Velocity / TireRadius) * (1 / (2 * np.pi) * 60))
    RPMMOTOR = (RPMWheel * GearRatio)
    torque = (Power * 9.549) / RPMMOTOR
    np.sort(torque)
    torqueRPM = np.column_stack((torque, RPMMOTOR))
    totalTorque = len(torque)
    minTorqueRow = torque[0]
    for i in range(totalTorque):
        if torque[i] <= 0:
            minTorqueRow = i
            break
    minTorqueRow = minTorqueRow - 1
    PosTorque = torque[0:minTorqueRow]
    PosRPM = RPMMOTOR[0:minTorqueRow]

    # plot torque
    plt.figure(9)
    plt.plot(PosRPM, PosTorque, '.')
    plt.title('torque over RPM')
    plt.xlabel('RPM')
    plt.ylabel('torque (nm)')
    plt.show()

    # energy calculation
    Power[Power > MaxPower] = MaxPower
    Prows = len(Power)
    counter1 = 1
    J = np.zeros(Prows)
    Dtime = []
    DPower = []
    while counter1 <= (Prows - 3):
        Dtime = [time[counter1], time[counter1 + 1], time[counter1 + 2]]
        DPower = [Power[counter1], Power[counter1 + 1], Power[counter1 + 2]]
        Energy = (np.trapz(DPower, Dtime))
        J[counter1] = Energy
        counter1 = counter1 + 1
    J = J / 1000

    plt.figure(1)
    plt.plot(time, J, '.')
    plt.title('energy/time')
    plt.xlabel('time(s)')
    plt.ylabel('energy(Wh)')
    plt.show()

    EnergyP = J[J > 0]
    EnergyN = J[J < 0]
    EnergyRegen = EnergyN * RegenEf
    EnergyTotal = (sum(EnergyP) + sum(EnergyRegen)) / 10000  # kwh output
    EnduranceEnergy = EnergyTotal * Laps
    print(EnergyTotal, 'kwh of energy per lap')
    print(EnduranceEnergy, 'Kwh of energy for endurance')

    return EnduranceEnergy


power_calc()