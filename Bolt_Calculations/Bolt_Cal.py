import numpy as np
import matplotlib.pyplot as plt

# Constants
dx = 0.01  # in
L = 5.14
x1 = np.arange(0, 1 + dx, dx)  # in
x2 = np.arange(1, 4.51 + dx, dx)  # in
x3 = np.arange(4.5, L + dx, dx)  # in
F = 702.19  # lbf
a = 1  # in
b = 0.63  # in
b2 = 3.51  # in
d = 0.375  # in
E = 2710000  # ksi
I = (np.pi * (d**4)) / 64  # in^4
R2 = ((a * F) + (F * (L - b))) / L  # lbf
R1 = ((F * (L - a)) + F * b) / L
M1 = R1 * a
M2 = R2 * b

# Initialize arrays
y1 = np.zeros_like(x1)
y4 = np.full_like(x1, R1)
y7 = R1 * x1

y5 = np.full_like(x2, R1 - F)
y8 = np.zeros_like(x2)
M_P2 = np.zeros_like(x2)

y6 = np.full_like(x3, -R2)
y9 = np.zeros_like(x3)

# Calculate values
for i in range(len(x1)):
    y1[i] = -(F * b2 * x1[i]) / (6 * L * E * I) * (L**2 - b2**2 - x1[i]**2)

for i in range(len(x2)):
    y8[i] = R1 * x2[i] - F * (x2[i] - a)
    M_P2[i] = y8[i]

for i in range(len(x3)):
    y9[i] = M_P2[i] - R2 * (x3[i] - b) + 2920.614

# Plot results
plt.figure(1)
plt.plot(x1, y1)
plt.title('Figure 1')
plt.xlabel('x (in)')
plt.ylabel('y')
plt.grid(True)

plt.figure(2)
plt.plot(x1, y4, 'b', label='y4')
plt.plot(x2, y5, 'b')
plt.plot(x3, y6, 'b')
plt.plot(x1, y7, 'g', label='y7')
plt.plot(x2, y8, 'g')
plt.plot(x3, y9, 'g')
plt.title('Figure 2')
plt.xlabel('x (in)')
plt.ylabel('y')
plt.legend()
plt.grid(True)

plt.show()
