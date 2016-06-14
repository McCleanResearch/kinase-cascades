global n k_act k_deact k_on k_off k_cat

% Description
% This program generates a set of differential equations for an n-step
% kinase cascade. The first kinase in the cascade is activated and
% deactivated at a constant rate. The remaining kinases are activated and
% deactivated according to a Michaelis-Menten like model. The function
% models a total of 3*n - 1 components. The first two components are the
% unactivated and activated forms of the first kinase respectively .The
% remaining components are (for each kinase) (1) the deactivated form, (2)
% the activated form and (3) the deactivated form complexed with the
% activated form of the previous kinase. 
% 
% Usage
% Specify n, k_act, k_deact, k_on, k_off, and k_cat and initial conditions. 
% Then use one of MATLAB's built in ODE solvers to solve @KinaseODEs.

% The number of kinases in the cascade
n = 10;

% Rate constants for the equations

% k_act is the activation rate of the inital kinase in the cascade
k_act = 1;

% k_deact is an array containing the deactivation rates of each kinase in
% the cascade
k_deact = 0.1*ones(n, 1);

% k_on is the rate at which an activated kinase binds its substrate
k_on = 0.5*ones(n, 1);

% k_off is the rate at which an enzyme-substrate complex disassociates
k_off = 0.5*ones(n, 1);

% k_cat is the rate at which a kinase activates its substrate
k_cat = 5*ones(n, 1);

% Initial concentrations of each component of the cascade
initials = [1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0];

time_course = 0:0.01:30;

hold on;
legendInfo = cell(9, 1);
for i=2:10
    n = i;
    cur_initials = initials(1:(3*n - 1));
    [t,y] = ode23s(@KinaseODEs, time_course, cur_initials);
    hog1PP_percent = y(:, 3*n-1)./(y(:, 3*n-1) + y(:, 3*n-2) + y(:, 3*n-3));
    legendInfo{i} = ['n = ' int2str(i)];
    plot(time_course, hog1PP_percent, 'LineWidth', 2);
    hold on;
end
l = legend(legendInfo{:});
set(l, 'FontSize', 18);
xlabel('Time','FontSize', 18);
ylabel('% phosphorylated HOG1','FontSize', 18);

