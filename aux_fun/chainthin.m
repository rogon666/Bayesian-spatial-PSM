function [chaint, athin] = chainthin(chain)
% Automatic thinning of a MCMC chain
% R Gonzales
%% Automatic thinning
n = length(chain);
chaint = chain; 
acft = autocorr(chaint,30);
thins = 1;
while acft(2) > .2
    thins = thins + 1;
    indt=1:thins:n; 
    chaint = chain(indt); 
    acft = autocorr(chaint,30);
end
athin = thins;

  