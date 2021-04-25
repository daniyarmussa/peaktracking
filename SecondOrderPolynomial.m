%	The FBG spectrum is interpolated with a fucntion that approximates its shape

function [EstimatedBraggWavelength] = SecondOrderPolynomial(Reflectivity, lambda)
	%Reflectivity =~ a2*lambda.^2 + a1*lambda + a0;
	%we may use polyfit() function to find the coefficients of polynomial
	%[a2 a1 a0] = polyfit(lambda, Reflectivity, 2)
	
	Reflectivity_polynomial = polyfit(lambda, Reflectivity, 2);
	a2 = Reflectivity_polynomial(1);
	a1 = Reflectivity_polynomial(2);
	a0 = Reflectivity_polynomial(3);
	
	%the Estimated Bragg wavelength then calculated by equating derivative of equation to zero
	EstimatedBraggWavelength = -a1./(2*a2);
end