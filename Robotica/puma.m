%% Definicoes
clc; clear; close all;

% Propriedades
m1 = 10; % [Kg]
m2 = 10; % [Kg]
m3 = 10; % [Kg]
m4 = 10; % [Kg]
m5 = 10; % [Kg]
m6 = 10; % [Kg]

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
  
I5 = [1 0 0
      0 1 0
      0 0 1];
  
I6 = [1 0 0
      0 1 0
      0 0 1];
% Constantes
A2 = 2; % [m]
A3 = 3; % [m]
D3 = 4; % [m]
D4 = 5; % [m]

% Variaveis
t1 = sym('t1'); % [rad]
t2 = sym('t2'); % [rad]
t3 = sym('t3'); % [rad]
t4 = sym('t4'); % [rad]
t5 = sym('t5'); % [rad]
t6 = sym('t6'); % [rad]

w1 = sym('w1'); % [rad]
w2 = sym('w2'); % [rad]
w3 = sym('w3'); % [rad]
w4 = sym('w4'); % [rad]
w5 = sym('w5'); % [rad]
w6 = sym('w6'); % [rad]

juncoes = [1 1 1 1 1 1];
n_juncoes = 6;

%% Cinematica
dh = [
    0   0      0   t1
    0   -pi/2  0   t2
    A2  0      D3  t3
    A3  -pi/2  D4  t4
    0   pi/2   0   t5
    0   -pi/2  0   t6
    ];

[J, A, K] = dh_table(dh, n_juncoes, juncoes);

%% Dinamica

% Massas do manipulador
m = [m1 m2 m3 m4 m5 m6];

% Matrizes de Inercia
I(:,:,1) = I1;
I(:,:,2) = I2;
I(:,:,3) = I3;
I(:,:,4) = I4;
I(:,:,5) = I5;
I(:,:,6) = I6;

% Variaveis
vars = [t1; t2; t3; t4; t5; t6];
d_vars = [w1; w2; w3; w4; w5; w6];

% Equacao de movimento

Dt = motion_equation(dh, n_juncoes, m, I, juncoes);
C = christoffel(Dt, n_juncoes, vars, d_vars);
g = potencial_energy(A, m, n_juncoes, vars);

D = eval(Dt);
C = eval(C);
g = eval(g);

T = A;


%% Simulacao

sim('sim_sys_scara.slx');