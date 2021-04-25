%	Allows interpolating the reflection Spectrum with
%	a piecewise polynomial function 

function [EstimatedBraggWavelength] = Spline(Reflectivity, lambda)
	SplineResol = 1e-13 ;   %Resoution of the Spline 
    xq = lambda(1): SplineResol :lambda(length(lambda));    
    dlambda = lambda(2) - lambda(1); %resolution of given lambda grid
    coeff = dlambda/SplineResol;
    %spline() returns a vector of interpolated values ss corresponding to the query points in xq 
    ss = spline(lambda, Reflectivity, xq); 
    [peak, index] = max(ss);    %assign the peak reflectivity and its corresponding index
	EstimatedBraggWavelength = lambda(int16(index/coeff));
end