function [LightS,LightP,Mass,Power] = SingleCellAnalysis(maxPower,PerCellCap,PerCellMaxCurrent,CellNominalVoltage,CellMaxVoltage,perCellMass,IdealCapacity,AcceptablePower)
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
        if(CapacityV(I,1)<=(IdealCapacity+2))
           
            IdealSC(I,1) = SV(I,1);
            IdealPC(I,1) = PV(I,1);
           
        end
    end
end

%power ideal finder
IdealPower = (IdealSC .* IdealPC .* PerCellMaxCurrent * CellNominalVoltage)./1000;
for I = 1:numel(IdealPower)
    if(IdealPower(I,1)<=maxPower)
        if(IdealPower(I,1)>=AcceptablePower)
            IdealP(I,1) = PV(I,1);
            IdealS(I,1) = SV(I,1);
        end
    end
end

IdealP = nonzeros(IdealP);
IdealS = nonzeros(IdealS);
%find lightest weight configuration
MassPast = 100;
for I = 1:numel(IdealP)
    J = (numel(IdealP)+1)-I;
    MassCurrent = IdealS(J,1)*IdealP(J,1)*perCellMass/1000;
    if (MassCurrent < MassPast)
        MassPast = MassCurrent;
        LightP = IdealP(J,1);
        LightS = IdealS(J,1);
        Mass = MassCurrent;
    end
end
Power = (LightP*LightS*PerCellMaxCurrent*CellNominalVoltage)/1000;
% filter power to be useable power
for I = 1:numel(PowerV)
    if(PowerV(I,1)>=maxPower)
        PowerV(I,1) = 80;
    end
end
end