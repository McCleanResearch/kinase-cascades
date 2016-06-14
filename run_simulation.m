global n k_act k_deact k_on k_off k_cat

n = 10;
k_act = 0.5*ones(n, 1);
k_deact = 0.1*ones(n, 1);
k_on = 0.5*ones(n, 1);
k_off = 0.5*ones(n, 1);
k_cat = 5*ones(n, 1);

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

