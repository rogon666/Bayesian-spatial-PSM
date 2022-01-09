%% Un gráfico para el proyecto PEP
% ("Gráfico de enjambre" suena bien, no?)
function [] = swarmplot(I,y)
I0 = (I(y==0));
I1 = (I(y==1));
data = {I0,I1};
plotSpread(data,[],[],{'Without access','With access'})
xlabel('Financial access')
box on
line([.5 1.5],[mean(I0) mean(I0)],'LineWidth',2)
line([1.5 2.5],[mean(I1) mean(I1)],'LineWidth',2)
text(.5,mean(I0)+0.3*mean(I0),mat2str(mean(I0),3),'Color','b','BackgroundColor',[1 1 1])
text(1.5,mean(I1)+0.3*mean(I1),mat2str(mean(I1),3),'Color','b','BackgroundColor',[1 1 1])