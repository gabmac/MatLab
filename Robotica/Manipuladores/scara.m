%% Definicoes
clc; clear; close all;

% Propriedades
m1 = 7; % [Kg]
m2 = 6; % [Kg]
m3 = 5; % [Kg]
m4 = 3; % [Kg]

I1 = [0.12 0 0
      0 0.12 0
      0 0 0.12];

I2 = [0.05 0 0
      0 0.05 0
      0 0 0.05];
 
I3 = [0.01 0 0
      0 0.01 0
      0 0 0.01];
 
I4 = [0.01 0 0
      0 0.01 0
      0 0 0.01];
  
% Constantes
A1 = 0.450; % [m]
A2 = 0.350; % [m]
D1 = 0.472; % [m]
D4 = 0.03; % [m]

% syms A1 A2 D1 D4;

% Variaveis
t1 = sym('t1'); % [rad]
t2 = sym('t2'); % [rad]
D3 = sym('D3'); % [m]
t4 = sym('t4'); % [rad]

w1 = sym('w1'); % [rad]
w2 = sym('w2'); % [rad]
v3 = sym('v3'); % [m]
w4 = sym('w4'); % [rad]

juncoes = [1 1 0 1];
n_juncoes = 4;

%% Cinematica
dh = [
    A1  0   D1  t1
    A2  pi  0   t2
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
[C,Cs] = christoffel(Dt, n_juncoes, vars, d_vars);
g = potencial_energy(A, m, n_juncoes, vars);

D = eval(Dt);
C = eval(C);
g = eval(g);


%% Obter pontos tragetória

Q0 = [
    0.3538
    0.1264
    1.3000
    0.0000
];

[ tragectory_coefficients, tempos_tragetoria, Q ] = get_trajectories( A, vars, Q0, juncoes );

Q0 = Q(:,1);
%% Simulacao

[T, X, Q_ideal, Q_real, Tal] = sim('sim_sys_scara.slx');


figure;
plot(T, Tal);
%% Animation

close all;
animation(A, vars, Q_ideal, T, 1, 'scara_ideal_animation');

close all;
animation(A, vars, Q_real, T, 1, 'scara_real_animation');
