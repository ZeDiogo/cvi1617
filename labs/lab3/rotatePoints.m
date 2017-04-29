clear all; close all;

a = [30 70 30 70; 30 30 70 70; 1 1 1 1];
dim =160;
a1 = a(1:2,:);

img = ones(dim,dim);
figure;
axis([-200 200 -200 200]);
grid on, hold on,
plot(a1(1,:),a(2,:), 'r.', 'markersize', 15);


theta = pi/4;
T = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1]; %matriz de rtacao
b = T*a;
b1 = b(1:2,:); % seleciona só as linha 1 e 2 da matriz
plot(b1(1,:), b(2,:), 'b.', 'markersize', 15);


T1 = [1 0 -60;0 1 -60;0 0 1]; %matriz de translacao


a1 = T1*a;
a2 = a1(1:2,:);
plot(a2(1,:), a2(2,:), 'm.', 'markersize', 15);

T2 = [2 0 0;0 2 0;0 0 1];
a3 = T2*a;
a4 = a3(1:2,:);
plot(a4(1,:), a4(2,:), 'g.', 'markersize', 15);
