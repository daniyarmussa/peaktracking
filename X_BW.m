%	Most popular technique for peak tracking in FBGs 
%	in dense wavelength sampling (with resolution dlambda = 1 - 5 pm)

function [EstimatedBraggWavelength] = X_BW(Reflectivity, lambda, X_dB)
	%set Threshold reflectivity having X_dB below the max measured Reflectivity
	%X_dB often set to 3dB
	R_threshold = max(Reflectivity)./(10*log10(X_dB));
	lambda_threshold = 0;
	%the set of wavelength is calcuated for Reflectivity >= R_threshold
	for i = 1:length(lambda)
        if Reflectivity(i) >= R_threshold
            lambda_threshold(i) = lambda(i);
        end
    end
	%estimation made as the center of inner bandwidth
	EstimatedBraggWavelength = min(lambda_threshold) + (max(lambda_threshold) - min(lambda_threshold))./2;

end