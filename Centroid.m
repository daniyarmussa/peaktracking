%	Determines the Bragg wavelength as the center of
% 	mass refflection spectrum of the FBG

function [EstimatedBraggWavelength] = Centroid(Reflectivity, lambda)
    %Takes average value of wavelength in the grid 
	EstimatedBraggWavelength = sum(Reflectivity.*lambda)./sum(Reflectivity);
end