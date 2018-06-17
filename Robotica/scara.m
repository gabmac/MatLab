%% Definicoes
clc; clear; close all;

% Propriedades
m1 = 10; % [Kg]
m2 = 10; % [Kg]
m3 = 10; % [Kg]
m4 = 10; % [Kg]

I1 = [1 0 0
      0 1 0
      0 0 1];

I2 = [1 0 0
      0 1 0
      0 0 1];
 
I3 = [1 0 0
      0 1 0
      0 0 1];
 
I4 = [1 0 0
      0 1 0
      0 0 1];
  
% Constantes
A1 = 2; % [m]
A2 = 3; % [m]
D1 = 4; % [m]
D4 = 5; % [m]

% Variaveis
D3 = sym('D3'); % [m]
t1 = sym('t1'); % [rad]
t2 = sym('t2'); % [rad]
t4 = sym('t4'); % [rad]

v3 = sym('v3'); % [m]
w1 = sym('w1'); % [rad]
w2 = sym('w2'); % [rad]
w4 = sym('w4'); % [rad]

juncoes = [1 1 0 1];
n_juncoes = 4;

%% Cinematica
dh = [
    A1  0   D1  t1
    A2  180 0   t2
    0   0   D3  0
    0   0   D4  t4
    ];

[J, A, K] = dh_table(dh, n_juncoes, juncoes);

%% Dinamica

% Massas do manipulador
m = [m1 m2 m3 m4];

% Matrizes de Inercia
I(:,:,1) = I1;
I(:,:,2) = I2;
I(:,:,3) = I3;
I(:,:,4) = I4;

% Variaveis
vars = [t1; t2; D3; t4];
d_vars = [w1; w2; v3; w4];

% Equacao de movimento

Dt = motion_equation(dh, n_juncoes, m, I, juncoes);
C = christoffel(Dt, n_juncoes, vars, d_vars);
g = potencial_energy(A, m, n_juncoes, vars);

save('dinamic.mat', 'Dt', 'C', 'g', 'vars', 'd_vars');

T = A;
save('cinematic.mat', 'T', 'vars');


%% Simulacao **** WARNING *****
% Esta divergindo e demorando muito

sim('sim_sys_robot.slx');