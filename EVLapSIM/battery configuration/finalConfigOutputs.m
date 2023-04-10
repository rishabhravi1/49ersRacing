clc
clear

%% inputs
Data = readmatrix("2024 FSAEV Cell Decision Matrix.xlsx");
Data = Data(2:46,:);
MaxPower = 80; %Kw max power specified by rules
CellCapcityV = Data(:,5)./1000; %pulls all cell capacity turns it to Ah
PerCellContCurrentV = Data(:,7); %pulls all cell cont current rating A
nominalVoltageV = Data(:,6); %pulls nominal voltage of cells
CellMaxVoltage = 4.2; %max Voltage
PerCellMassV = Data(:,8); %weight per cell Grams
IdealCapacity = 5;

for I = 1:numel(PerCellMassV)
    [OutputS(I,1),OutputP(I,1),OutputMass(I,1)] = SingleCellAnalysis(MaxPower,CellCapcityV(I,1),PerCellContCurrentV(I,1),nominalVoltageV(I,1),CellMaxVoltage,PerCellMassV(I,1),IdealCapacity);
    OutputMass(I,2) = I;
    OutputS(I,2) = I;
    OutputP(I,2) = I;
end

currentMass = 100;
for I = 1:numel(PerCellMassV)
    if(OutputMass(I,1) < currentMass)
        currentMass = OutputMass(I,1);
        IdealCell = OutputMass(I,2);
    end
end
fprintf('lightest cell and configuration out of given cells is cell # %f and %f series, %f paraelle',IdealCell,OutputS(IdealCell,1),OutputP(IdealCell,1))



