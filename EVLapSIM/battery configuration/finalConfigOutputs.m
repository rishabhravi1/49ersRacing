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
IdealCapacity = 7; %KWh
MinPower = 50; %KW

for I = 1:numel(PerCellMassV)
    
    [OutputS(I,1),OutputP(I,1),OutputMass(I,1),OutputPower(I,1)] = SingleCellAnalysis(MaxPower,CellCapcityV(I,1),PerCellContCurrentV(I,1),nominalVoltageV(I,1),CellMaxVoltage,PerCellMassV(I,1),IdealCapacity,MinPower);
    
    OutputMass(I,2) = I;
    OutputS(I,2) = I;
    OutputP(I,2) = I;
    OutputPower(I,2) = I;
    OutputS = nonzeros(OutputS);
    OutputP = nonzeros(OutputP);
    OutputPower = nonzeros(OutputPower);
    OutputMass = nonzeros(OutputMass);
end
%Error in finalConfigOutputs (line 35)
        %IdealCell = OutputMass(I,2);

currentMass = 100;
for I = 1:numel(OutputMass)
    if(OutputMass(I,1) < currentMass)
        currentMass = OutputMass(I,1);
        IdealCell = I;
    end
end
fprintf('lightest cell and configuration cell # %f and %f series, %f paraelle power output cont. is %f Kw',IdealCell,OutputS(IdealCell,1),OutputP(IdealCell,1),OutputPower(IdealCell,1))



