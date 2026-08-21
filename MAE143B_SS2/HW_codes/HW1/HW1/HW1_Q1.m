clear;clc;close all;

a = 14;
w_g = 10;

z = w_g/sqrt(a);
p = w_g*sqrt(a);

s = tf('s');
D = (s+z)/(s+p);

bode(D);