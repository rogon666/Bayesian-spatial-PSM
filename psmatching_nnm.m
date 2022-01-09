function SATE = psmatching_nnm(y,X,Bdraw,I)
% Traditional, pair-wise nearest-neighbor matching
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Propensity Score
    probit = @(yhat) normcdf(yhat,0,1);
    pscore = probit(X*Bdraw);
% Matching
    m = length(y) - sum(y); % # of zeros (regions without access)
    diff = zeros(1,sum(y)); % pre-allocating 
    It = I(y==1);
    Iu = I(y==0);
    pst = pscore(y==1);
    psu = pscore(y==0);
for k = 1:sum(y)                        % for k= 1,...,sum(y) regions with access (treated pop)
    dis     = abs(pst(k)-psu(1:m));     % distance between scores
    indu     = dis == min(dis(:));      % (single) close match from the untreated
    diff(k) = It(k) - mean(Iu(indu));   % one-by-one difference between the k-treated and the matched untreated
end
SATE = mean(diff);  % average difference