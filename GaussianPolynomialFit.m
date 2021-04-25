%	The FBG spectrum is approximated as a Gaussian function
% 	technique: logarithm of the reflection spectrum and its second order interpolation

function [EstimatedBraggWavelength] = GaussianPolynomialFit(Reflectivity, lambda)
	%Reflectivity =~ A * exp( -(lambda-lambda0)^2 / (2*sigma^2) );
	% the fitting is been done by a polyfit() the lan of the data.
	
	Reflectivity_log = log(Reflectivity);
	Reflectivity_polynomial = polyfit(lambda, Reflectivity_log, 2);
	a2 = Reflectivity_polynomial(1:1);
	a1 = Reflectivity_polynomial(2);
	a0 = Reflectivity_polynomial(3);
	
	%Gaussian parameters
	sigma = sqrt(-1/(2*a2));
	lambda0 = a1*sigma^2;
    A = exp(a0+lambda0^2/(2*sigma^2));
	
	%the Estimated Bragg wavelength then calculated by equating derivative of equation to zero
	EstimatedBraggWavelength = -a1./(2*a2);
end