function [Reflectivity] = FBGspectrum(lambdaB, lambda, kL, L, dneff, neff, v)

% Main FBG spectrum generation function

% lambdaB - Bragg wavelength [m]
% lambda - wavelength axis [m]
% L - grating length (in m)
% kL - grating strength
% dneff - refractive index modulation amplitude
% neff - effective refractive index.
% v - fringe visibility

%Computation section 

k = (kL/L) / v; % Defining k coefficient

sigma = pi./lambda*dneff; % Sigma function

delta = 2*pi*neff*(1./lambda - 1./lambdaB); %Delta fubction 

fsigma = pi./lambda*dneff + 2*pi*neff*(1./lambda - 1./lambdaB);

% Reflectivity for uniform grating 
Reflectivity = ( sinh(L*sqrt(k.^2 - fsigma.^2)).^2 ) ./ ( ( cosh(L*sqrt(k.^2 - fsigma.^2)).^2 ) - (fsigma.^2)./(k.^2)); 


end

