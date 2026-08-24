%% NACA DEFINITION
% NACA MPXX
% M: max camber as a percentage of a chord
% XX: max thickness as a percentage of a chord

naca_name = '2412';
M = str2double(naca_name(2)) / 100; % Max camber
P = str2double(naca_name(3)) / 10;   % Position of max camber
T = str2double(naca_name(3:4)) / 100; % Max thickness


