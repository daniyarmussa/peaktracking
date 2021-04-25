%	The methods performs the curve fitting of the whole FBG spectrum with
%	Nth order polynomialfunction

function [EstimatedBraggWavelength] = HigherOrderPolynomial(Reflectivity, lambda, n)
	%Reflectivity =~ sum(a*lambda.^n);
	%n is the order of polynomial
	%we may use polyfit() function to find the coefficients of polynomial
	%[a2 a1 a0] = polyfit(lambda, Reflectivity, 2)
	
	Reflectivity_polynomial_coef = polyfit(lambda, Reflectivity, n);
	%constuct polynomial from coefficients
	Reflectivity_polynomial = poly2sym(Reflectivity_polynomial_coef,x);
	%Find the extrema of polynomial to find the optimal maximum point
    g = diff(Reflectivity_polynomial,x); %derivative
    %extremum point
    extrema = vpa(solve(g == 0, x));
    
	
	%the Estimated Bragg wavelength
	EstimatedBraggWavelength = extrema(1,:);
end