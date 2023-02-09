% Load the data from the CSV file
data = csvread('EnduranceVelocityTrace.csv');

% Extract the second column of data
y = data(:,2);

% Sort the data in ascending order
y = sort(y);

% Define the independent variable x
x = 1:length(y);

% Fit a line of best fit to the data
p = polyfit(x, y, 1);

% Plot the data and the line of best fit
figure;
plot(x, y, 'o', x, polyval(p, x), '-');
xlabel('x');
ylabel('y');
title('Line of Best Fit');

% Calculate the area under the curve from 0 to 14990 using the trapezoidal method
x_limits = [0, 14990];
x_index = x_limits(1) <= x & x <= x_limits(2);
area = trapz(x(x_index), y(x_index));
disp(['The area under the curve from 0 to 14990 is: ', num2str(area), ' joules']);

total_Energy = area/3600;
disp(['Total Energy required: ', num2str(total_Energy), ' watt-hours']);