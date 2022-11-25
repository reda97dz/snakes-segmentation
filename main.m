%% Lab 2: Snakes Segmentation
% Biometrics and Intelligent Vision
% UPEC - 2022/2023
% *Reda Baka*

%%

alpha = 0.1; % elasticity : ?
beta = 0.5; % rigidity : ?
gamma = 10; % viscosity : ?
kappa = 2; % external force weighting parameter ?
kappap = 0.2; % balloon force weighting parameter ?
Niter = 20; % resampling frequency parameter : ?
ITER = 30; % total number of iterations (to optimize) : ?
dmax = 2; % max and min distances for contour resampling : ?
dmin = 0.5;
delta = 0.3; % sampling step

%% 
% Read the image and show it

J=imread('irm_1.jpg');
imshow(J);

%% 
% Get the first channel,convert it to double and show it

J_first = J(:,:,1);

J_double = im2double(J_first);
imshow(J_double);

%% 
% Extract gradient vectors
[px, py] = gradient(J_double);

% Normalize vectors
normegrad = (sqrt(px.^2+py.^2));
figure();
quiver(px(1:1:end,1:1:end), py(1:1:end,1:1:end));
quiver(px, py);

%% 
% Show gradient image and initialize snake
figure;
imshow(normegrad)
[x,y] = snakeinit(delta);

% loop and iteratively show the contour
for i=1:ITER
    [x,y] = snakedeform(x,y,alpha,beta,gamma,kappa, kappap,px,py,Niter);
    hold on; plot(x,y,'yellow'); hold off;
    pause(0.5)
    [x,y] = snakeinterp(x,y,dmax,dmin);
end
%% 
% Show results on the original image
figure
imshow(J)
hold on; plot(x,y,'blue'); 

%% 
% apply gaussian filter to image

kernel = fspecial('gaussian', [3 3], 0.3);
h = imfilter(J_double,kernel);
subplot(1,2,1), imshow(J_first);
subplot(1,2,2), imshow(h);

%%

[px, py] = gradient(J_double);
normegrad = (sqrt(px.^2+py.^2));

%%

figure;
imshow(normegrad)
[x,y] = snakeinit(delta);

for i=1:ITER
    [x,y] = snakedeform(x,y,alpha,beta,gamma,kappa, kappap,px,py,Niter);
    hold on; plot(x,y,'yellow'); hold off;
    pause(0.5)
    [x,y] = snakeinterp(x,y,dmax,dmin);
end
%% 

figure
imshow(J)
hold on; plot(x,y,'blue'); 

%%
% set alpha to 0 then to 5
alpha = 0;

figure;
imshow(normegrad)
[x,y] = snakeinit(delta);

for i=1:ITER
    [x,y] = snakedeform(x,y,alpha,beta,gamma,kappa, kappap,px,py,Niter);
    hold on; plot(x,y,'yellow'); hold off;
    pause(0.5)
    [x,y] = snakeinterp(x,y,dmax,dmin);
end

%%

figure
imshow(J)
hold on; plot(x,y,'blue'); 

%%

alpha = 5;

figure;
imshow(normegrad)
[x,y] = snakeinit(delta);

for i=1:ITER
    [x,y] = snakedeform(x,y,alpha,beta,gamma,kappa, kappap,px,py,Niter);
    hold on; plot(x,y,'yellow'); hold off;
    pause(0.5)
    [x,y] = snakeinterp(x,y,dmax,dmin);
end

%%

figure
imshow(J)
hold on; plot(x,y,'blue'); 

%%
% set beta to 0 then to 5
alpha = 0.1;
beta = 0;


figure;
imshow(normegrad)
[x,y] = snakeinit(delta);

for i=1:ITER
    [x,y] = snakedeform(x,y,alpha,beta,gamma,kappa, kappap,px,py,Niter);
    hold on; plot(x,y,'yellow'); hold off;
    pause(0.5)
    [x,y] = snakeinterp(x,y,dmax,dmin);
end

%%

figure
imshow(J)
hold on; plot(x,y,'blue'); 

%%

alpha = 0.1;
beta = 5;

figure;
imshow(normegrad)
[x,y] = snakeinit(delta);

for i=1:ITER
    [x,y] = snakedeform(x,y,alpha,beta,gamma,kappa, kappap,px,py,Niter);
    hold on; plot(x,y,'yellow'); hold off;
    pause(0.5)
    [x,y] = snakeinterp(x,y,dmax,dmin);
end

%%

figure
imshow(J)
hold on; plot(x,y,'blue'); 

