clc
clear
%function inputs
maxPower = 80; %Kw
PerCellCap = 4.5; %Ah
PerCellMaxCurrent = 45; %A
CellNominalVoltage = 3.7;
CellMaxVoltage = 4.2;
perCellMass = 46; %grams
IdealCapacity = 5.6;

%create Cell count, battery mass, power, capacity vectors
R = 1;
SeriesMax = 600/CellMaxVoltage;
for S = 1:SeriesMax
    for P = 1:10
        Power = (PerCellMaxCurrent*CellNominalVoltage*S*P)/1000;
        Capacity = (PerCellCap*CellNominalVoltage*S*P)/1000;
        CellCountV(1,R) = S*P;
        TotalBatteryMassV(1,R) = (S*P*perCellMass)/1000; 
        SV(R,1) = S;
        PV(R,1) = P;
        PowerV(R,1) = Power;
        CapacityV(R,1) = Capacity;
        R = R+1;
    end
end

% create ideal capcity plane
[x,y]=meshgrid(1:max(SV),1:max(PV));
z = ones(max(PV),1).*IdealCapacity;

%% find Series and paraelle connections that work for ideal capacity
for I = 1:numel(CapacityV)
    if(CapacityV(I,1)>=(IdealCapacity-.1)&&CapacityV(I,1)<=(IdealCapacity+.1))
            IdealS(I,1) = SV(I,1);
            IdealP(I,1) = PV(I,1);
    end
end
IdealP = nonzeros(IdealP);
IdealS = nonzeros(IdealS);
%find lightest weight configuration
MassPast = 100;
for I = 1:numel(IdealP)
    MassCurrent = IdealS(I,1)*IdealP(I,1)*perCellMass/1000;
    if (MassCurrent < MassPast)
        MassPast = MassCurrent;
        LightP = IdealP(I,1);
        LightS = IdealS(I,1);
    end
end
fprintf('lightest configuration is %f S %f P',LightS,LightP)
% filter power to be useable power
for I = 1:numel(PowerV)
    if(PowerV(I,1)>=80)
        PowerV(I,1) = 80;
    end
end

%plot capacity
figure(1)
plot3(SV,PV,CapacityV)
hold on
plot3(x,y,z,'-')
hold off
title('Capacity(Kwh)')
xlabel('Series')
ylabel('Paraelle')
zlabel('Capacity(Kwh)')
%plot power
figure(2)
plot3(SV,PV,PowerV)
title('Power(Kw)')
xlabel('Series')
ylabel('Paraelle')
zlabel('Power(Kw)')
%plot mass
figure(3)
plot3(SV,PV,TotalBatteryMassV)
title('Mass(kg)')
xlabel('Series')
ylabel('Paraelle')
zlabel('Mass(kg)')
%plot ideal P over ideal S
figure(4)
plot(IdealS,IdealP,'*')
title('P/S')
xlabel('series')
ylabel('parelle')