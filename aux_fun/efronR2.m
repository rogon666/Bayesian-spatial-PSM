function eR2 = efronR2(y,x,bdraws)
probit = inline('normcdf(Xbhat,0,1)');
pscore = probit(x*bdraws');
yfit = pscore;
ymean = mean(y);
d = sum((y-ymean).^2);
eR2 = zeros(1,size(yfit,2));
for draw = 1:size(yfit,2)
    n(draw) = sum((y-yfit(:,draw)).^2);
    eR2(draw) = 1 - n(draw)/d;
end
