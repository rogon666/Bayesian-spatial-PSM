%% Post-estimation routines
% PS Balancing property test 
% (Bayesian Natural-Conjugate version of the Smith & Todd test)
p = path;
path(p,'aux_fun')
disp('Computing Bayesian Balancing Property test...')
disp('(this might take a while, too)')
        yhats = x*res.bdraw';
        probit = @(yhat) normcdf(yhat,0,1); % función probit (CDF de una distribución gaussiana)
        pscores = probit(yhats);
        BFpvals = zeros(ndraw-nomit,size(X,2));
for i = 1:ndraw-nomit
    for j = 1:size(X,2)
        BFpvals(i,j) = STbalancing_bayFstat(X(:,j),pscores(:,i),y);
    end  
end
BFpval = median(BFpvals)';
% -----------------------------------
disp('Balancing property test') 
disp('(Bayesian Conjugate version of the Smith & Todd* test)')
disp('======================')
disp('Covariate   Bayesian p-value')
disp('---------------------------------------')
for i = 1:length(BFpval)
disp(['     ' mat2str(i) '           ' mat2str(BFpval(i),5)])
end
disp('---------------------------------------')
disp('Null (Ho): Conditional mean of the covariate is')
disp('independent of the treatment (balancing property holds)')
disp('(*) Smith, Jeffrey & Todd, Petra (2005). "Rejoinder",')
disp('Journal of Econometrics, vol. 125(1-2), pp 365-375')
disp('======================')
clear yhats probit pscores BFpval BFpvals i j 
path(p); clear p