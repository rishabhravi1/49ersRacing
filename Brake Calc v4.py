import math 
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn
import sympy as sp
from sympy import symbols, factor, expand, diff, integrate, limit, oo, Eq, solve

#Brake system inputs, eventually import from excel sheet
#Initial test will be from 40 to 0 mph with an decceleration of 1.4 g's

mr = .60708 #Single rotor weight Kg's
Ar = .027 #Single rotor surface area
Cp = 460.55 #Specific heat of the rotor J/kgk

#Vehicle inputs, import certain values from motec over time

theta = 0       #Grade of surface (radians)
g = 32.2        #gravitational acceleration ft/s^2
h = 12.2        #cg height in inches
L = 61.5        #Vehicle wheelbase in inches
c = 27.45       # Distance from Rear axle to cg in.
b = L - c       # Distance from front axle to cg in.
W = 550         #Total vehicle weight in lbs
mv = 254        #Vehicle mass in kg's
ax = -1.4*32.2  #Vehicle accel in ft/sec^2 (Replace with motec data over time)

Vint = 17.88    #Initial vehicle speed m/s, not to be used with motec data
Vf = 0          #Final vehicle speed m/s, not to be used with motec data
Tair = 20       #Temp in degrees celcius

A = .06485      #Single rotor surface area both sides
ht = 7.8        #heat transfer coeff 

#Weight transfer calculations

Wdf = (c/L)*W*(math.cos(theta)) - (h/L)*W*(math.sin(theta)) - ((h*ax)/(L*g))*W #Dynamic weight front (lbs) - have this be iterated in the future
Wdr = (b/L)*W*(math.cos(theta)) + (h/L)*W*(math.sin(theta)) + ((h*ax)/(L*g))*W  #Dynamic weight rear (lbs) - ""

print(Wdf)
print(Wdr)

fwp = Wdf/(Wdf + Wdr) #Dynamic front weight percent
Wf = fwp * W
Wr = (1-fwp)*W

Ke = (mv*((Vf-Vint)**2))/2 #Kinetic energy from braking
deltaT = Ke / (mr*4*Cp) #Change in temp K or C
print(deltaT)
DeltaTf = deltaT * fwp  #Change in temp from axle (2 combined)
DeltaTr = deltaT * (1-fwp)  #Change in temp rear (2 combined)

print (DeltaTf, DeltaTr)

Drf = DeltaTf / 2 #Change in temp per corner
Dlf =  DeltaTf / 2
Drr = DeltaTr / 2
Dlr = DeltaTr / 2

Trf = Drf + Tair    #To be iterated later
Tlf = Dlf + Tair
Trr = Drr + Tair
Tlr = Dlr + Tair


print (Trf, Tlf, Trr, Tlr)

df = pd.read_csv('Underbird23_Endurance_mod.csv')
column_c_vector = df['G Force Long']
column_a_vector = df['Time']
column_e_vector = df['Ground Speed']
#print(column_c_vector)
#a = (column_c_vector.iloc[4] + .41)*32.2
#print(a)
n=50000
x_plot = []; y_a = []
j_plot = []; y_Wdf = []
v_plot = []; y_Wdr = []
z_plot = []; y_DeltaTf = []
k_plot = []; y_maxtempf = []

Wdf = Wf 
DeltaTf_old = 0
maxtempf = Tair
maxtempr = Tair
j = 0
for i in range(3, n+1):
    a = ((column_c_vector.iloc[i] +.41)*1.4)*32.2
    t = column_a_vector.iloc[i]
    t_old = column_a_vector.iloc[i-1]
    V = (column_e_vector.iloc[i])/3.6
    V_old = (column_e_vector.iloc[i-1])/3.6
    Wdf = (c/L)*W*(math.cos(theta)) - (h/L)*W*(math.sin(theta)) - ((h*a)/(L*g))*W
    Wdr = (b/L)*W*(math.cos(theta)) + (h/L)*W*(math.sin(theta)) + ((h*a)/(L*g))*W
    x_plot.append(i); y_a.append(a); 
    y_Wdf.append(Wdf); j_plot.append(i)
    v_plot.append(i); y_Wdr.append(Wdr)
    
    
    fwp = Wdf/(Wdf + Wdr)

    Ke = ((mv) * (abs(V**2 - V_old**2)))  / 2 #v^2 - V0 ^2 
    
    if a < 0: 
        deltaT = abs(Ke) / (mr*4*Cp)
        DeltaTf = deltaT *fwp   #Change in temp from axle (2 combined)
        DeltaTr = deltaT * (1-fwp)
        maxtempf += DeltaTf
        maxtempr += DeltaTr
        z_plot.append(t); y_DeltaTf.append(DeltaTf)
    k_plot.append(t); y_maxtempf.append(maxtempf)
    


print(maxtempf)

print(maxtempr)

k_plot.append(t); y_maxtempf.append(maxtempf)
plt.plot(k_plot, y_maxtempf)
plt.show()

z_plot.append(t); y_DeltaTf.append(DeltaTf)
plt.plot(z_plot, y_DeltaTf)
plt.show()

x_plot.append(i); y_a.append(a) # run 1 time out of loop to get last value
j_plot.append(i); y_Wdf.append(Wdf)
v_plot.append(i); y_Wdr.append(Wdr)
plt.plot(j_plot, y_Wdf)
plt.show()
plt.savefig('front axle.png')
plt.close()
plt.plot(x_plot,y_a)
plt.savefig('acceleration.png')
plt.close()
plt.plot(v_plot,y_Wdr)
plt.savefig('Rear axle.png')


#look up seaborn graphs 