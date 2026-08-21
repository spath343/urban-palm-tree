clear;clc;close all;

h = 0.001;
w_g = 10;
w_c = 978.4765;
s = tf('s');

% Lead and Double Lag (squared)
D_lead = (s + 2.673) / (s + 37.417);
D_double_lag = ((s + 0.4852) / (s + 0.04852))^2;

% Inverse Chebyshev 4th-order LPF
num_lpf = 9.99e-4*(s/w_c)^4 + 7.659e3*(s/w_c)^2 + 7.333e9;
den_lpf = (s/w_c)^4 + 757.75*(s/w_c)^3 + 2.871*(s/w_c)^2 + 6.4019e7*(s/w_c) + 7.333e9;
D_lpf = num_lpf / den_lpf;

% Combined continuous-time compensator 
D_s = D_lead * D_double_lag * D_lpf;

% Le Tustin approximation with pre-warping at w_g
opts = c2dOptions('Method', 'tustin', 'PrewarpFrequency', w_g);
D_z = c2d(D_s, h, opts);

% Extract and normalize polynomial coefficients
[num, den] = tfdata(D_z, 'v');
b_bar = num / den(1);
a_bar = den / den(1);

% Display formatted to 4 significant digits
fprintf('--- DENOMINATOR COEFFICIENTS (a_bar) ---\n');
for i = 2:length(a_bar)
    fprintf('a_%d = %.4g\n', i-1, a_bar(i));
end

fprintf('\n--- NUMERATOR COEFFICIENTS (b_bar) ---\n');
for i = 1:length(b_bar)
    fprintf('b_%d = %.4g\n', i-1, b_bar(i));
end
