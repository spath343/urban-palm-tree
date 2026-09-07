%% NACA Creation
% NACA MPXX
% M: max camber as a percentage of a chord
% XX: max thickness as a percentage of a chord
clc;clear;close all;

naca_name = '2412'; % ADD NACA AIRFOIL HERE
m = str2double(naca_name(1)) / 100; 
p = str2double(naca_name(2)) / 10;   
t = str2double(naca_name(3:4)) / 100; 

c =1; % ADD CAMBER LENGTH HERE!!

% descretizing x
N = 100;
theta = linspace(0,pi,N);
x = (c/2)*(1-cos(theta));

% half thickness distribution
a0 = 0.2969;
a1 = -0.1260;
a2 = -0.3515;
a3 = 0.2843;
a4 = -0.1015;

y_t = (c*t)/0.2*(a0*sqrt(x./c) + a1*(x./c) + a2*(x./c).^2 + a3*(x./c).^3 + a4*(x./c).^4);

% camber line and local slope
y_c = zeros(size(x)); 
dyc_dx = zeros(size(x));

for i = 1:N
    if x(i) <= p*c
        y_c(i) = (m / p^2) * (2*p*(x(i)/c) - (x(i)/c)^2) * c;
        dyc_dx(i) = (2*m / p^2) * (p - (x(i)/c));
    elseif x(i) >= p*c
        y_c(i) = (m / (1-p)^2) * ((1 - 2*p) + 2*p*(x(i)/c) - (x(i)/c)^2) * c;
        dyc_dx(i) = 2*m/(1-p)^2*(p - (x(i)/c));
    end
end

% Surface offset
theta_c = atan(dyc_dx);

x_u = x - y_t.*sin(theta_c);
x_l = x + y_t.*sin(theta_c);
y_u = y_c + y_t.*cos(theta_c);
y_l = y_c - y_t.*cos(theta_c);  

% Plotting the airfoil shape
figure;
plot(x_u, y_u, 'b', 'LineWidth', 1.5); % Upper surface
hold on;
plot(x_l, y_l, 'r', 'LineWidth', 1.5); % Lower surface
axis equal;
xlabel('Chord Position (x)');
ylabel('Height (y)');
title(['NACA ' naca_name ' Airfoil']);
legend('upper surface','lower surface','Location','best');
grid on;
hold off;

%% creating airfoil coordinates csv

X_raw = [flip(x_u), x_l(2:end)]';
Y_raw = [flip(y_u), y_l(2:end)]';
Z_raw = zeros(size(X_raw));
raw_coords = [X_raw, Y_raw, Z_raw];

% Calculate distance between consecutive points
pt_dist = sqrt(sum(diff(raw_coords, 1, 1).^2, 2));

% Keep points that are separated by more than 1e-5 m (plus the very first point)
valid_idx = [true; pt_dist > 1e-5];
airfoil_sw = raw_coords(valid_idx, :);

% Export clean tab-delimited text for SolidWorks (NO headers)
output_sw = fullfile('C:\Users\shank\OneDrive\Documents\GitHub\urban-palm-tree\projects\personal\parametric-aero-structural-tool\data', '..', 'data', 'airfoil_solidworks.txt');
writematrix(airfoil_sw, output_sw, 'Delimiter', 'tab');

%% Thin Airfoil Theory Analytical Lift Polar

integrand = dyc_dx.*(cos(theta)-1);
alpha_L0 = -(1/pi)*trapz(theta,integrand);

% Theoretical lift polar
alpha_deg = linspace(-5,15);
alpha_rad = deg2rad(alpha_deg);

C_l = 2*pi*(alpha_rad-alpha_L0);

figure;
plot(alpha_deg,C_l);
% Set plot properties for the lift polar
xlabel('Angle of Attack (degrees)');
ylabel('Coefficient of Lift (C_l)');
title("Theoretical Lift Polar for NACA " + naca_name);
grid on;
axis([-5 15 -0.5 2]);