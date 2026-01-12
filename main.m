clc;clear;close all;
% Quarter-Car suspension parameters
ms=250; % Sprung mass(kg)-vehicle body
mu=40; % Unsprung mass(kg)-wheel+ axle
ks = 15000; % Suspension Spring Stiffness (N/m)
cs = 1000; % Suspension Damping coefficient (N·s/m)
kt=200000; % Tire Stiffness(N/m)
%Simulation time
tspan= [0,5]; % seconds
% Initial Condition
X0=[0 0 0 0]; %[xs xs_dot xu xu_dot]
% Road Input(bump)
zr=0.05; % 5 cm bump
% Solve ODe
[t, x] = ode45(@(t, X) quartercar_ode(t, X, ms, mu, ks, cs, kt, zr), tspan, X0);
figure;
plot(t, x(:,1), 'LineWidth', 1.5); hold on;
plot(t, x(:,3), 'LineWidth', 1.5);
grid on;
xlabel('Time (s)'); ylabel('Displacement (m)');
legend('Sprung mass x_s','Unsprung mass x_u');
title('Quarter-car response');
% Body acceleration (sprung mass)
xs_ddot = (-ks*(x(:,1)-x(:,3)) - cs*(x(:,2)-x(:,4))) / ms;

figure
plot(t, xs_ddot, 'LineWidth', 1.5)
xlabel('Time (s)')
ylabel('Body Acceleration (m/s^2)')
title('Ride Comfort Analysis')
grid on

% STEP 7: Effect of damping on suspension response

cs_values = [500 1000 2000];

figure
hold on

for i = 1:length(cs_values)
    cs = cs_values(i);

    [t, x] = ode45(@(t,x) quartercar_ode(t,x,ms,mu,ks,cs,kt,zr), tspan, X0);

    plot(t, x(:,1), 'LineWidth', 1.5)
end

legend('Low damping','Medium damping','High damping')
xlabel('Time (s)')
ylabel('Body Displacement (m)')
title('Effect of Damping on Vehicle Ride Comfort')
grid on
