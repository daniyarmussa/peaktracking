function [delta_shift] = Correlation(Reflectivity, Reflectivity_shift, lambda,kL, L, dneff, neff, v)
Pmax = 0;
Nmax = 0;
est_lambda = Spline(Reflectivity_shift, lambda);
for N = 1:100
    delta_lambda(N) = -20e-12 + N*1e-12;
    delta_lambda_e(N) = est_lambda + delta_lambda(N);
    Reflectivity1 = FBGspectrum(delta_lambda_e(N), lambda, kL, L, dneff, neff, v);
   P(N) = Reflectivity*Reflectivity1';
   %P(N) = max(xcorr(Reflectivity_ref,Reflectivity1));
    if (P(N)>Pmax)        
        Pmax = P(N);
        Nmax = N;
        Reflectivity_max = Reflectivity1;
        
    end  
end

delta_shift = delta_lambda(Nmax)
figure 
plot(delta_lambda, P,'r','LineWidth' , 1.5)
grid on;
title('Cross-correlation', 'FontSize', 15);
ylabel('Pm', 'FontSize', 15);
xlabel('∆𝜆, m', 'FontSize', 15);
set(gcf,'color','w');
end

