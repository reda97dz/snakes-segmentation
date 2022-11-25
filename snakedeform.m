function [x,y] = snakedeform(x,y,alpha,beta,gamma,kappa, kappap,fx,fy,ITER)
% SNAKEDEFORM Déformation du snake dans un champ de force
% [x,y] = snakedeform(x,y,alpha,beta,gamma,kappa,fx,fy,ITER)
%
% x,y position du snake
% alpha paramètre d’élasticité
% beta paramètre de rigidité
% gamma paramètre de viscosité
% kappa pondération de la force externe
% fx,fy champ de force externe
% ITER nombre d’itérations pour le calcul de la déformation
% ----------------------------------------------------E. Deléchelle
% x,y nouvelle position du snake
% paramètres du snake
N = length(x); alpha = alpha* ones(1,N); beta = beta*ones(1,N);
% construction des 5 vecteurs
alpham1 = [alpha(2:N) alpha(1)]; alphap1 = [alpha(N) alpha(1:N-1)];
betam1 = [beta(2:N) beta(1)]; betap1 = [beta(N) beta(1:N-1)];
a = betam1; b = -alpha - 2*beta - 2*betam1;
c = alpha + alphap1 +betam1 + 4*beta + betap1;
d = -alphap1 - 2*beta - 2*betap1; e = betap1;
% Matrice des paramètres
A = diag(a(1:N-2),-2) + diag(a(N-1:N),N-2);
A = A + diag(b(1:N-1),-1) + diag(b(N), N-1);
A = A + diag(c);
A = A + diag(d(1:N-1),1) + diag(d(N),-(N-1));
A = A + diag(e(1:N-2),2) + diag(e(N-1:N),-(N-2));
%% Force du BALLON -----------------------
xp = [x(2:N); x(1)];
yp = [y(2:N); y(1)];
xm = [x(N);x(1:N-1)];
ym = [y(N);y(1:N-1)];
% direction de la force de pression
qx = xp-xm;
qy = yp-ym;
pmag = sqrt(qx.*qx+qy.*qy);
% normalisation
fx_b = qy./pmag;
fy_b = -qx./pmag;
% pondération par kappap
fx_b = kappap*fx_b;
fy_b = kappap*fy_b;
%% Calcul de la déformation
invAI = inv(A + gamma * diag(ones(1,N)));
for iter = 1:ITER
    vfx = interp2(fx,x,y,'*linear');
    vfy = interp2(fy,x,y,'*linear');
    % déformation du snake +force du ballon (fx_b,fy_b)
    x = invAI * (gamma* x + kappa*vfx + kappap*fx_b);
    y = invAI * (gamma* y + kappa*vfy + kappap*fy_b);
end