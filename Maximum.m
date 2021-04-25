%	Simply estimates the peak wavelength as the wavelength
%	at which the max Reflectivity is observed

function [EstimatedBraggWavelength] = Maximum(Reflectivity, lambda)
	%if Reflectivity  == max(Reflectivity)
		[~, index] = max(Reflectivity);
		EstimatedBraggWavelength = lambda(index);
	%end 
end