%	The goal is to artificially expand the resolution of the spectrometer
%	dlambda into a much denser wavelegth

function [lambdaResampled] = Resampling(Q, lambda)
	%Q is a resampling rate
	dlambda = lambda(2)-lambda(1); %resolution
	dlambdaR = dlambda/Q;	%new resolution
	lambdaResampled = lambda(1) : dlambdaR : lambda(end);
end