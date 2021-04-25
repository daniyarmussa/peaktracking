%	Determines the Bragg wavelength as the center of
% 	mass refflection spectrum of the FBG

function [EstimatedBraggWavelength] = Centroid(Reflectivity, lambda)
	EstimatedBraggWavelength = sum(Reflectivity.*lambda)./sum(Reflectivity);
end