clear all; close all; clc

lambdaB = 1550e-9; % Bragg wavelength 
lambda = 1548e-9 : 1e-12 : 1552e-9; %Wavelength axis with 1pm wavelength resolution 
kL = 2.5; % Grating strength
L = 0.01; % Grating length 
v = 1;  % Fringe visibility 
neff = 1.5; % Effective refractive index 
dneff = 1e-5; % Modulation amplitude of refractive index 
SNR = 50;



for k = 1:100
    Reflectivity = FBGspectrum(lambdaB, lambda, kL, L, dneff, neff, v);
    NoiseReflectivity = awgn(Reflectivity,SNR);
    est_lambdaB_ref(k) = Maximum(Reflectivity, lambda);
end
lambdaB_ref = mean(est_lambdaB_ref)

figure (1)
%subplot(2,2,1)
plot(lambda, NoiseReflectivity, 'b' ,'LineWidth' , 2 );
hold on
plot(lambda, Reflectivity, 'r' ,'LineWidth' , 2 );
hold on
title('Input noisy spectrum of FBG, resolution=78pm', 'FontSize', 15);
xlabel('Wavelength, nm', 'FontSize', 15);
ylabel('Reflectivity', 'FontSize', 15);
legend('Noisy spectrum', 'Reference spectrum');

for m = 1:100
 amega_lambda = 100e-12;
 delta_lambda_est = m*amega_lambda; 
 delta_lambda = amega_lambda - delta_lambda_est;
 Reflectivity = FBGspectrum(lambdaB, lambda, kL, L, dneff, neff, v);
 Reflectivity_delta = FBGspectrum(lambdaB, delta_lambda, kL, L, dneff, neff, v);
 SUM = Reflectivity.*Reflectivity_delta;
 Pm(m) = symsum(SUM, lambda);
end 

figure (2)
plot(delta_lambda, Pm, 'b' ,'LineWidth' , 2 );



