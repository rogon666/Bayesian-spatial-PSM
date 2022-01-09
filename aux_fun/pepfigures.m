function [] = pepfigures(chain,chaint)
subplot(3,2,[1 2])
    plot(chain)
        title('MCMC trace')
subplot(3,2,3)
    gbins = 15;
    g = chain;
    h = histfit(g,gbins,'kernel');
    set(h(1),'FaceColor',[0.5 1 1]);
    set(h(2),'Color','blue');
    xlim([min(g) max(g)]);
    title('Histogram (full chain)')
subplot(3,2,4)
    [acf,~,bounds] = autocorr(chain,30);
    stem(acf,'r','MarkerFaceColor','r'); hold on
    plot(bounds(1)*ones(1,30),'b--')
    plot(bounds(2)*ones(1,30),'b--'); hold off
    xlim([1 30]);
    title('ACF original chain') 
subplot(3,2,5)
        g = chaint;
        h = histfit(g,gbins,'kernel');
        set(h(1),'FaceColor',[0.5 1 1]);
        set(h(2),'Color','blue');
        xlim([min(g) max(g)]);
        title('Histogram (thinned chain)')
subplot(3,2,6)
    [acf,~,bounds] = autocorr(chaint,30);
    stem(acf,'r','MarkerFaceColor','r'); hold on
    plot(bounds(1)*ones(1,30),'b--')
    plot(bounds(2)*ones(1,30),'b--'); hold off
    xlim([1 30]);
    title('ACF thinned chain') 