import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


#Radiator Sizing Calculator
#Inputs
cpWater = 4.187 #Kj/KgK
cpAir = 1.005 #Kj/KgK
massFlowWater =  #Kj/KgK 
massFlowair = 2.51 #kg/s at 40mph

CWater = cpWater * massFlowWater
CAir = cpAir * massFlowair

#Heat transfer coeff
Cmin = min(CWater, CAir)
Cmax = max(CWater, CAir)
TWi =  #Water temp in
TWo = #Water temp out
TAi = 298.15 #Air temp in
TAo = 298.15 #Air temp out
CR = Cmin/Cmax
qMax = Cmin(TWi-TAi)
q = CWater(TWi - TWo)
epsilon = q/qMax