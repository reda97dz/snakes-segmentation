function [xi,yi] = snakeinterp(x,y,dmax,dmin)
%SNAKEINTERP rééchantillonnage adapté du contour
% [xi,yi] = snakeinterp(x,y,dmax,dmin)
%
% dmax: distance maximale
% dmin: distance minimale
%
% si d(i,i+1)>dmax, un nouveau point est inséré
% si d(i,i+1)<dmin, un des deux points est éliminé
% conversion en vecteurs colonnes
x = x(:); y = y(:);
N = length(x);
d = abs(x([2:N 1])- x(:)) + abs(y([2:N 1])- y(:));
% procédure d'élimination
IDX = (d<dmin);
idx = find(IDX==0); x = x(idx); y = y(idx);
N = length(x);
d = abs(x([2:N 1])- x(:)) + abs(y([2:N 1])- y(:));
IDX = (d>dmax);
L = length(IDX);
z=1:0.5:L+0.5; xx=1:L;
z(2*xx(IDX==0))=[];
p = 1:N+1;
xi = interp1(p,[x;x(1)],z'); yi = interp1(p,[y;y(1)],z');
N = length(xi);
d = abs(xi([2:N 1])- xi(:)) + abs(yi([2:N 1])- yi(:));
% procédure d'insertion
while (max(d)>dmax),
    IDX = (d>dmax);
    NN = length(IDX); z=1:0.5:NN+0.5; xx=1:NN; z(2*xx(IDX==0))=[];
    p = 1:N+1;
    xi = interp1(p,[xi;xi(1)],z'); yi = interp1(p,[yi;yi(1)],z');
    N = length(xi);
    d = abs(xi([2:N 1])- xi(:)) + abs(yi([2:N 1])- yi(:));
end