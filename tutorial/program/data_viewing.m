function data_viewing()
%% load fisher's iris data
load('../data/fisheries.mat');

%% divide information 

SL = meas(:,1);
SW = meas(:,2);

versicolorSL = SL(strcmp(cellstr(species),'versicolor'));
versicolorSW = SW(strcmp(cellstr(species),'versicolor'));

virginicaSL  = SL(strcmp(cellstr(species),'virginica'));
virginicaSW  = SW(strcmp(cellstr(species),'virginica'));
%% create scatter plot

name1 = 'SL';
name2 = 'SW';
figure;
plot(versicolorSL, versicolorSW,'.b');
hold all;
plot(virginicaSL, virginicaSW,'.r');
xlabel(name1);
ylabel(name2);
grid on;
legend('versicolor','virgnica','Location','SouthEast');
title(['Scatter Plot of ' name1 ' vs. ' name2]);

%% plot quadratic discriminator function 
f = @(x,y) K + [x y]*L + sum(([x y]*Q) .* [x y], 2);

h2 = ezplot(f,[4.5 8 2 4]);
set(h2,'Color','m','LineWidth',2)
axis([4.5 8 2 4])
xlabel('Sepal Length')
ylabel('Sepal Width')
title('{\bf Classification with Fisher Training Data}')


end