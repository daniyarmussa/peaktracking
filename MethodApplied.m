
clear all; close all; clc

lambdaB = 1550e-9; % Bragg wavelength 
lambda = 1548e-9 : 1e-12 : 1552e-9; %Wavelength axis with 1pm wavelength resolution 
%lambda2 = 1548e-9 : 78e-12 : 1552e-9;
%lambda3 = 1548e-9 : 156e-12 : 1552e-9;
kL = 2.5; % Grating strength
L = 0.01; % Grating length 
v = 1;  % Fringe visibility 
neff = 1.5; % Effective refractive index 
dneff = 1e-5; % Modulation amplitude of refractive index 
SNR = 100;
%SNR2 = 30;
%SNR3 = 60;
X_dB = 3;




for k = 1:100
    Reflectivity = FBGspectrum(lambdaB, lambda, kL, L, dneff, neff, v);
    NoiseReflectivity = awgn(Reflectivity,SNR);
    est_lambdaB_ref(k) = Spline(Reflectivity, lambda);
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



for n = 1:10
    delta_lambda(n) = -20e-12+(20e-12+80e-12)*rand (1,1);
    lambdaBB(n) = lambdaB + delta_lambda(n);
    Reflectivity = FBGspectrum(lambdaBB(n), lambda, kL, L, dneff, neff, v);
    NoiseReflectivity = awgn(Reflectivity, SNR);
    est_lambdaB(n) = Spline(Reflectivity, lambda);
    delta_lambda_est(n) = est_lambdaB(n) - lambdaB_ref;
    err(n) = delta_lambda_est(n) - delta_lambda(n);
end

  error = mean(err)
  RMSE = sqrt(sum(err.^2)./length(err))
  %dB = 10.*log(NoiseReflectivity)
  figure (2)
plot(lambda,10.*log(NoiseReflectivity), 'b' ,'LineWidth' , 2 );
hold on
plot(lambda, 10.*log(Reflectivity), 'r' ,'LineWidth' , 2 );
hold on
title('Input noisy spectrum of FBG, resolution=78pm', 'FontSize', 15);
xlabel('Wavelength, nm', 'FontSize', 15);
ylabel('Reflectivity', 'FontSize', 15);
legend('Noisy spectrum', 'Reference spectrum');

N_mc = 10^3;
snr = 10: 5: 100;
RMSE_pm = zeros(1,length(snr));
for Snr = 1:length(snr)
 for n = 1:N_mc
    delta_lambda(n) = -20e-12+(20e-12+80e-12)*rand (1,1);
    lambdaBB(n) = lambdaB + delta_lambda(n);
    Reflectivity = FBGspectrum(lambdaBB(n), lambda, kL, L, dneff, neff, v);
    NoiseReflectivity = awgn(Reflectivity, snr(Snr));%Snr -> snr
    est_lambdaB(n) = Spline(Reflectivity, lambda);
    delta_lambda_est(n) = est_lambdaB(n) - lambdaB_ref;
    err(n) = delta_lambda_est(n) - delta_lambda(n);
 end
 error = sum(err.^2)/N_mc;
 RMSE_pm(Snr)= sqrt(error);%./length(error));%Snr -> snr
end
figure (3)
plot(snr, RMSE_pm, '-o','LineWidth' , 2 );
title('RMSE over SNR', 'FontSize', 15);
xlabel('SNR, dB', 'FontSize', 15);
ylabel('RMSE, pm', 'FontSize', 15);

%hold on
%plot(lambda, Reflectivity, 'black' ,'LineWidth' , 2 );
%title('Spline is applied', 'FontSize', 15);
%xlabel('Wavelength, nm', 'FontSize', 15);
%ylabel('Reflectivity', 'FontSize', 15);

