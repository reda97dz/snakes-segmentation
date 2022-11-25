function [x,y] = snakeinit(delta)
%SNAKEINIT iitialisation manuelle du snake
% [x,y] = SNAKEINIT(delta)
% delta: pas d'interpolation des points du contour
% Remarque : cette fonction est exécutée après affichage de l'image
% le contour initial est alors tracé à l'aide de la souris sur l'image elle-même
hold on
x = [];
y = [];
n = 0;
disp('Bouton de gauche pour selectionner un point')
disp('Bouton de droite pour terminer la selection')
but = 1;
% boucle de sélection des points du contour initial
while but == 1
    [s, t, but] = ginput(1);
    n = n + 1;
    x(n,1) = s;
    y(n,1) = t;
    plot(x, y, 'r-');
end
plot([x;x(1,1)],[y;y(1,1)],'r-');
hold off
% rééchantillonnage du contour suivant le pas delta
x = [x(:);x(1,1)];
y = [y(:);y(1,1)];
t = 1:n+1;
ts = [1:delta:n+1]';
xi = interp1(t,x,ts);
yi = interp1(t,y,ts);
n = length(xi);
x = xi(1:n-1); % x et y contiennent les points du contour
y = yi(1:n-1);