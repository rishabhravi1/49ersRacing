function [LightS,LightP,Mass] = SingleCellAnalysis(maxPower,PerCellCap,PerCellMaxCurrent,CellNominalVoltage,CellMaxVoltage,perCellMass,IdealCapacity)
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

%find Series and paraelle connections that work for ideal capacity
for I = 1:numel(CapacityV)
    if(CapacityV(I,1)>=(IdealCapacity-.1))
        if(CapacityV(I,1)<=(IdealCapacity+.1))
            IdealS(I,1) = SV(I,1);
            IdealP(I,1) = PV(I,1);
        end
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
        Mass = MassCurrent;
    end
end
% filter power to be useable power
for I = 1:numel(PowerV)
    if(PowerV(I,1)>=maxPower)
        PowerV(I,1) = 80;
    end
end
end