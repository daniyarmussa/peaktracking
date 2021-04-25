%	Karhunen-Loeve Transform method is designed for the coarsest wavelegth resolution
%	and resolves inter-pixel peak-tracking.
% 	it is designed for coarset wavelength resolution 
%	and resolves inter-pixel peak-tracking
function [Xi] = KLT(Reflectivity, lambda)
	N = numel(lambda);			%number of array elements
	F = fft(Reflectivity, N);	%FFT of Reflectivity
	M = toeplitz(F); 			%M is Toeplitz matrix of FFT
	[V,D] = eig(M); 			%eigenvectors and diagonal eigenvalues of Toeplitz Matrix
	Xi = max(D);				%extracting highest rank eigenvalue(xi_N)
end