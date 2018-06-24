% Data based on the following robotic arm:
%   Epson C4-A901 (C4L)

%% Definicoes
clc; clear; close all;

% Propriedades
m1 = 10;  % [Kg]
m2 = 4;   % [Kg]
m3 = 7;   % [Kg]
m4 = 6;   % [Kg]
m5 = 1.5; % [Kg]
m6 = 0.5; % [Kg]

I1 = [0.15  0     0
      0     0.15  0
      0     0     0.15];

I2 = [0.05  0     0
      0     0.05   0
      0     0     0.05];
 
I3 = [0.1   0     0
      0     0.1  0
      0     0    0.1];
 
I4 = [0.1   0     0
      0     0.1   0
      0     0     0.1];
  
I5 = [0.05  0     0
      0     0.05  0
      0     0     0.05];
  
I6 = [0.01  0     0
      0     0.02  0
      0     0     0.02];
  
 
% Constantes
D1 = 0.253; % [m]
A2 = 0.120; % [m]
A3 = 0.400; % [m]
A4 = 0.400; % [m]
A5 = 0.065; % [m]
A6 = 0.050; % [m]

% Variaveis
t1 = sym('t1'); % [rad]
t2 = sym('t2'); % [rad]
t3 = sym('t3'); % [rad]
t4 = sym('t4'); % [rad]
t5 = sym('t5'); % [rad]
a6 = sym('a6'); % [rad]

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
    0    -pi/2  D1  t1
    A2   0      0   t2
    A3   0      0   t3
    A4   0      0   t4-pi/2
    A5   0      0   t5
    A6   a6     0   0
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
vars = [t1; t2; t3; t4; t5; a6];
d_vars = [w1; w2; w3; w4; w5; w6];

% Equacao de movimento

Dt = motion_equation(dh, n_juncoes, m, I, juncoes);
C = christoffel(Dt, n_juncoes, vars, d_vars);
g = potencial_energy(A, m, n_juncoes, vars);

D = eval(Dt);
C = eval(C);
g = eval(g);


%% Obter pontos tragetória

Q0 = [
    0
    1.2064
    0
    0
    0
    0
];

[ tragectory_coefficients, tempos_tragetoria ] = get_trajectories( A(:,:,1:4), vars(1:4), Q0(1:4), juncoes(1:4) );


%% Simulacao

[T, X, Q_ideal, Q_real, Tal] = sim('sim_sys_puma.slx');

%% Animation

close all;
animation(A, vars, Q_ideal, T, 0, 'puma_ideal_animation');

close all;
animation(A, vars, Q_real, T, 0, 'puma_real_animation');

figure;
plot(T, Tal);