% Load the data from the CSV file
data = csvread('EnduranceVelocityTrace.csv');

% Extract the second column of data
y = data(:,2);
y = .3048 .*y;

% Sort the data in ascending order
%y = sort(y);

% Extract the first column of data (untouched)
x = data(:,1);
x = .3048 .*x;

% Plot the data
figure;
plot(x, y, 'o');
xlabel('x');
ylabel('y');
title('Data');

% Calculate the area under the curve from the minimum to the maximum values of x using manual calculation
x_limits = [min(x), max(x)];
x_index = x_limits(1) <= x & x <= x_limits(2);
dx = x(2) - x(1); % Calculate the step size
area = sum(y(x_index)) * dx;

disp(['The area required for 1 lap is: ', num2str(area), ' joules']);
area = area * 13;
total_Energy = area/3600;
disp(['Total Energy required to complete endurance is: ', num2str(total_Energy), ' watt-hours']);
