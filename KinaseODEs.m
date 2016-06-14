function dydt = KinaseODEs(t, y)

global n k_act k_deact k_on k_off k_cat

dydt = zeros(3*n - 1, 1);

if (n == 1)
    dydt(1) = - k_act*y(1) + k_deact(1)*y(2);
    dydt(2) = + k_act*y(1) - k_deact(1)*y(2);
else
    dydt(1) = - k_act*y(1) + k_deact(1)*y(2);
    dydt(2) = + k_act*y(1) - k_deact(1)*y(2) - k_on(1)*y(2)*y(4) + k_off(1)*y(3) + k_cat(1)*y(3);
    dydt(3) = + k_on(1)*y(2)*y(4) - k_off(1)*y(3) - k_cat(1)*y(3);
    for i = 2:(n-1)
        dydt(3*i - 2) = -k_on(i-1)*y(3*i - 2)*y(3*(i-1)-1) + k_off(i-1)*y(3*(i-1)) + k_deact(i)*y(3*i - 1);
        dydt(3*i - 1) = + k_cat(i-1)*y(3*(i-1)) - k_on(i)*y(3*i - 1)*y(3*(i+1) - 2) + k_off(i-1)*y(3*i) - k_deact(i)*y(3*i - 1) + k_cat(i)*y(3*i);
        dydt(3*i) = + k_on(i)*y(3*i - 1)*y(3*(i + 1) - 2) - k_off(i-1)*y(3*i) - k_cat(i)*y(3*i);
    end
    dydt(3*n-2) = - k_on(n-1)*y(3*(n-1)-1)*y(3*n-2) + k_off(n-1)*y(3*(n-1)) + k_deact(n)*y(3*n-1);
    dydt(3*n-1) = + k_cat(n-1)*y(3*(n-1)) - k_deact(n)*y(3*n-1);
end
