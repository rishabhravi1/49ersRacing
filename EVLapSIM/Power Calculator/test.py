from Power_Calculator_func import power_calc
import pandas as pd
import matplotlib.pyplot as plt

df = pd.DataFrame({'E':[], 'V':[]})

for i in range(300,500, 50):
   # print()
    df.append({'E': power_calc(VehicleMass=i), 'V': i}, ignore_index=True)

plt.figure(1)

plt.plot(df['E'], df['V'], '.')
# plt.title('torque over RPM')
# plt.xlabel('RPM')
# plt.ylabel('torque (nm)')
plt.show()
print(df)
# df.plot(x=df['E'], y=df['V'], kind='scatter')