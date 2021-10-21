%==========================================================================
%% 2 percentage signs represent sections of code;
% 1 percentage sign represents comments for code or commented out code;

% Answers to question parts that don't involve code can be found at the
% bottom of the programme, in the section ``Questions asked in problemset x
% that don't involve code".

% Text answers to question parts that involve code will be between the
% sub-section label:
%=======
% ANSWER
%=======
% Answer here
%===========
% END ANSWER
%===========

% Comments that are important will be between the sub-section label:
%=====
% NOTE
%=====
% Important note here
%=========
% END NOTE
%=========

% ECO385K Problem Set 1, 1
% Paul Le Tran, plt377
% 10 October, 2021
%==========================================================================

%==========================================================================
%% Setting up workspace
clear all;
close all;
clc;

home_dir = 'path\to\programmes';

cd(home_dir);
%==========================================================================

%==========================================================================
%% Setting data that will be constant in 1a, 1b, 1c, 1d, 1e
% Assuming wage offers are uniformly distributed in the interval
% [w_min, w_max] = [10, 60].
w_min = 10;
w_max = 60;

% Setting sample period
% To ensure that the length of density vector won't be long to the point
% that the sum of the product between it and the value function blows up,
% we set the amount of periods to be equal to w_max - w_min.
N = w_max - w_min;

% Creating vector of wages from distribution mentioned above
w = w_min + (w_max - w_min).*rand(N, 1);

% Creating vector of densities associated with wage vector
p = unifpdf(w, w_min, w_max);
%==========================================================================

%==========================================================================
%% Part 1a: Calculate the reservation wage and plot the policy funciton
% Setting up data exclusive to 1a.
% Creating discount factor, beta
beta = 0.995;

% Creating benefit received when unemployed, b
b = 20;

% Creating loop for value function iteration to find Bellman equation
% Choosing initial value of value function to be value of accepting any
% wage.
v = w./(1 - beta);

% Creating variable that stores max(abs(v - v_next)), the error metric. We
% are focusing on the max of the error because if the max value satisfies
% the threshold, every other value of the vector will.
error = 1;

% Creating variable that stores iteration number
iteration = 0;

% Iterating to find fixed point of value function. The threshold that stops
% the loop will be 0.001.
while error >= 0.001
  % Displaying iteration number
  disp(iteration);
  
  % Calculating value function using initial or previous value function
  % WHY DOES USING sum(v.*p) CAUSE THE LOOP TO EXPLODE???
  v_next = max(w./(1 - beta), b + beta*sum(v.*p));
  
  % Storing max(abs(v - v_next)). Choosing the max so the abs vector has
  % every value to be below error threshold.
  error = max(abs(v - v_next));
  disp(error);
  
  % Storing previous value function
  v = v_next;
  
  iteration = iteration + 1;
end
clear iteration error;

% Calculating reservation wage using the Bellman equation
w_bar = (1 - beta)*(beta*mean(v));

% Creating policy function
syms s(wage);
s(wage) = piecewise(wage >= w_bar, 1, wage < w_bar, 0);

% Plotting policy function
fplot(s(wage), [10, 60], 'LineWidth', 2);
grid on
xlabel('Wage');
ylabel('Policy');
hold on
title('Policy function');

saveas(gcf, 'path\to\graphics\1a_plot.png');
close(gcf);
%==========================================================================

%==========================================================================
%% Part 1b: Vary b from 10 to 55, calculate the reservation wage and plot
% function for different values of UI. Is the reservation wage increasing
% or decreasing in b?

% Looping through value function iteration and policy function plotting
% portion as done in part 1a, for various values of b.
% Creating counter for overall loop
counter = 1;
for b = 10:5:55
  disp(b);
  % Creating loop for value function iteration to find Bellman equation
  % Choosing initial value of value function to be value of accepting any
  % wage.
  v = w./(1 - beta);

  % Creating variable that stores max(abs(v - v_next)), the error metric.
  % We are focusing on the max of the error because if the max value
  % satisfies the threshold, every other value of the vector will.
  error = 1;

  % Creating variable that stores iteration number
  iteration = 0;

  % Iterating to find fixed point of value function. The threshold that
  % stops the loop will be 0.001.
  while error >= 0.001
    % Displaying iteration number
    disp(iteration);
  
    % Calculating value function using initial or previous value function
    % WHY DOES USING sum(v.*p) CAUSE THE LOOP TO EXPLODE???
    v_next = max(w./(1 - beta), b + beta*sum(v.*p));
  
    % Storing max(abs(v - v_next)). Choosing the max so the abs vector has
    % every value to be below error threshold.
    error = max(abs(v - v_next));
    disp(error);
  
    % Storing previous value function
    v = v_next;
  
    iteration = iteration + 1;
  end
  clear iteration error;

  % Calculating reservation wage using the Bellman equation
  w_bar = (1 - beta)*(beta*mean(v));
  
  % Calculating value of reservation wage
  v_bar = w_bar/(1 - beta);
  
  % Storing w_bar and corresponding b in as a row in matrix
  w_bar_b(counter, :) = [w_bar b];

  % Creating policy function
  syms s(wage);
  s(wage) = piecewise(wage >= w_bar, 1, wage < w_bar, 0);

  % Plotting policy function
  fplot(s(wage), [50, 60], 'LineWidth', 1.25);
  grid on
  xlabel('Wage');
  ylabel('Policy');
  hold on

  % Creating legend
  Legend = cell(2,1)
  Legend{1}= 'b = 10';
  Legend{2}= 'b = 15';
  Legend{3}= 'b = 20';
  Legend{4}= 'b = 25';
  Legend{5}= 'b = 30';
  Legend{6}= 'b = 35';
  Legend{7}= 'b = 40';
  Legend{8}= 'b = 45';
  Legend{9}= 'b = 50';
  Legend{10}= 'b = 55';
  legend(Legend, 'Location', 'Northwest');
  
  % Creating title
  title('Policy function');
  
  saveas(gcf, 'path\to\graphics\1b_plot.png');
  
  counter = counter + 1;
end
close(gcf);
%=========================================================
% We can see that the reservation wage is increasing in b.
%=========================================================
%==========================================================================

%==========================================================================
%% Part 1c: Vary beta from 0.960 to 0.999, calculate the reservation wage,
% and plot the policy function for different values of beta. Is the
% reservation wage increasing or decreasing in beta?

% Setting up data exclusive to 1c.
b = 20;

% Looping through value function iteration and policy function plotting
% portion as done in part 1a, for various values of beta.
% Creating counter for overall loop
counter = 1;
for beta = 0.960:0.013:0.999
  disp(beta);
  % Creating loop for value function iteration to find Bellman equation
  % Choosing initial value of value function to be value of accepting any
  % wage.
  v = w./(1 - beta);

  % Creating variable that stores max(abs(v - v_next)), the error metric.
  % We are focusing on the max of the error because if the max value
  % satisfies the threshold, every other value of the vector will.
  error = 1;

  % Creating variable that stores iteration number
  iteration = 0;

  % Iterating to find fixed point of value function. The threshold that
  % stop the loop will be 0.001.
  while error >= 0.001
    % Displaying iteration number
    disp(iteration);
  
    % Calculating value function using initial or previous value function
    v_next = max(w./(1 - beta), b + beta*sum(v.*p));
  
    % Storing max(abs(v - v_next)). Choosing the max so the abs vector has
    % every value to be below error threshold.
    error = max(abs(v - v_next));
    disp(error);
  
    % Storing previous value function
    v = v_next;
  
    iteration = iteration + 1;
  end
  clear iteration error;

  % Calculating reservation wage using the Bellman equation
  w_bar = (1 - beta)*(beta*mean(v));
  
  % Storing w_bar and corresponding beta in as a row in matrix
  w_bar_beta(counter, :) = [w_bar beta];

  % Creating policy function
  syms s(wage);
  s(wage) = piecewise(wage >= w_bar, 1, wage < w_bar, 0);

  % Plotting policy function
  fplot(s(wage), [40, 60], 'LineWidth', 1.25);
  grid on
  xlabel('Wage');
  ylabel('Policy');
  hold on
  
  % Creating legend
  Legend = cell(2,1)
  Legend{1}= '\beta = 0.96';
  Legend{2}= '\beta = 0.973';
  Legend{3}= '\beta = 0.986';
  Legend{4}= '\beta = 0.999';
  legend(Legend, 'Location', 'Northwest');
  
  % Creating title
  title('Policy function')
  
  saveas(gcf, 'path\to\graphics\1c_plot.png');
  
  counter = counter + 1;
end
close(gcf);
%============================================================
% We can see that the reservation wage is increasing in beta.
%============================================================
%==========================================================================

%==========================================================================
%% Part 1d: Assume that the work has a utility function of ln(Y_t) and
% maximises his utility instead of maximising the expected discounted sum
% of earnings. Compute the reservation wage and compare with 1a.

% Setting up data exclusive to 1d.
b = 20;
beta = 0.995;

% Creating loop for value function iteration to find Bellman equation
% Choosing initial value of value function to be value of accepting any
% wage.
v = w./(1 - beta);

% Creating variable that stores max(abs(v - v_next)), the error metric. We
% are focusing on the max of the error because if the max value satisfies
% the threshold, every other value of the vector will.
error = 1;

% Creating variable that stores iteration number
iteration = 0;

% Iterating to find fixed point of value function. The threshold that stops
% the loop will be 0.001.
while error >= 0.001
  % Displaying iteration number
  disp(iteration);
  
  % Calculating value function using initial or previous value function
  v_next = max(log(w)./(1 - beta), log(b) + beta*sum(v.*p));
  
  % Storing max(abs(v - v_next)). Choosing the max so the abs vector has
  % every value to be below error threshold.
  error = max(abs(v - v_next));
  disp(error);
  
  % Storing previous value function
  v = v_next;
  
  iteration = iteration + 1;
end
clear iteration error;

% Calculating reservation wage using the Bellman equation
% Because the worker is maximising ln(Y_t), the reservation wage will be in
% natural log terms. Therefore, we need to convert it back to levels.
w_bar = exp((1 - beta)*(beta*mean(v)));

% Creating policy function
syms s(wage);
s(wage) = piecewise(wage >= w_bar, 1, wage < w_bar, 0);

% Plotting policy function
fplot(s(wage), [10, 60], 'LineWidth', 2);
grid on
xlabel('Wage');
ylabel('Policy');
hold on
title('Policy function, maximising utility ln(Y_t)');

saveas(gcf, 'path\to\graphics\1d_plot.png');
close(gcf);
%========================================================================
% When comparing with the reservation wage in part 1a, we see that the
% reservation wage is smaller if the worker is maximising ln(Y_t) instead
% of Y_t.
%========================================================================
%==========================================================================

%==========================================================================
%% Part 1e: Now assume that the worker receives a job offer with
% probability phi = 0.7 and does not receive any with probability 1 - phi =
% 0.3. Write the Bellman equation for the worker's problem and compute the
% reservation wage with [w_min, w_max] = [10, 60], b = 20, and beta= 0.995,
% and plot the policy function.

% Observe that if the worker receives no wage offer in a time period, this
% is equivalent to saying the worker receives a wage offer of zero. In
% other words, the lifetime utility of the worker accepting the wage offer
% remains the same, but the lifetime utility of the worker continuing to be
% uneployed changes.

% We are also assuming that the worker is maximising Y_t instead of
% ln(Y_t).

% Setting up data exclusive to 1e.
b = 20;
beta = 0.995;
phi = 0.7;

% Creating loop for value function iteration to find Bellman equation
% Observe that the Bellman equation includes the value function evaluated
% at a wage offer of zero. This means to find the fixed point of the
% Bellman equation, we need to find the fixed point of the Bellman equation
% evaluated at a wage offer of zero. Therefore, we have "two" value
% functions to iterate over, where the latter plugs into the former.

% Choosing initial value of value function to be value of accepting any
% wage.
v = w./(1 - beta);
% Choosing initial value of value function of getting no offer to be b
v_nooffer = b*ones(N, 1);

% Creating variable that stores max(abs(v - v_next)), the error metric. We
% are focusing on the max of the error because if the max value satisfies
% the threshold, every other value of the vector will.
error = 1;

% Also making error metric measuring max(abs(v_nooffer - v_nooffer_next)).
error_nooffer = 1;

% Creating variable that stores iteration number
iteration = 0;

% Iterating to find fixed point of value function. The threshold that stops
% the loop will be 0.001.
while error >= 0.001 && error_nooffer >= 0.001
  % Displaying iteration number
  disp(iteration);
  
  % Calculating value function using initial or previous value function
  v_nooffer_next = max(zeros(N, 1)./(1 - beta), b + (1 - phi)*beta*v_nooffer + phi*beta*sum(v.*p));
  v_next = max(w./(1 - beta), b + (1 - phi)*beta*v_nooffer_next + phi*beta*sum(v.*p));
  
  % Storing max(abs(v - v_next)). Choosing the max so the abs vector has
  % every value to be below error threshold.
  error = max(abs(v - v_next));
  error_nooffer = max(abs(v_nooffer - v_nooffer_next));
  disp(error);
  disp(error_nooffer);
  
  % Storing previous value functions
  v = v_next;
  v_nooffer = v_nooffer_next;
  
  iteration = iteration + 1;
end
clear iteration error;

% Calculating reservation wage using the Bellman equation
% Because the worker is maximising ln(Y_t), the reservation wage will be in
% natural log terms. Therefore, we need to convert it back to levels.
w_bar = (1 - beta)*(beta*mean(v));

% Creating policy function
syms s(wage);
s(wage) = piecewise(wage >= w_bar, 1, wage < w_bar, 0);

% Plotting policy function
fplot(s(wage), [10, 60], 'LineWidth', 2);
grid on
xlabel('Wage');
ylabel('Policy');
hold on
title(['Policy Function, chance to receive job offer is ', '\phi = 0.7.']);

saveas(gcf, 'path\to\graphics\1e_plot.png');
close(gcf);
%==========================================================================

%==========================================================================
%% Part 1f: Assume that the wage offers are distributed uniformly in
% [w_min, w_max] = [5, 65], b = 20, and beta = 0.995. Compute the
% reservation wage and plot the policy function.

% Setting up data exclusive to 1f.
w_min = 5;
w_max = 65;

% Setting sample period
% To ensure that the length of density vector won't be long to the point
% that the sum of the product between it and the value function blows up,
% we set the amount of periods to be equal to w_max - w_min.
N = w_max - w_min;

% Creating vector of wages from distribution mentioned above
w = w_min + (w_max - w_min).*rand(N, 1);

% Creating vector of densities associated with wage vector
p = unifpdf(w, w_min, w_max);

b = 20;
beta = 0.995;

% Creating loop for value function iteration to find Bellman equation
% Choosing initial value of value function to be value of accepting any
% wage.
v = w./(1 - beta);

% Creating variable that stores max(abs(v - v_next)), the error metric. We
% are focusing on the max of the error because if the max value satisfies
% the threshold, every other value of the vector will.
error = 1;

% Creating variable that stores iteration number
iteration = 0;

% Iterating to find fixed point of value function. The threshold that stops
% the loop will be 0.001.
while error >= 0.001
  % Displaying iteration number
  disp(iteration);
  
  % Calculating value function using initial or previous value function
  % WHY DOES USING sum(v.*p) CAUSE THE LOOP TO EXPLODE???
  v_next = max(w./(1 - beta), b + beta*sum(v.*p));
  
  % Storing max(abs(v - v_next)). Choosing the max so the abs vector has
  % every value to be below error threshold.
  error = max(abs(v - v_next));
  disp(error);
  
  % Storing previous value function
  v = v_next;
  
  iteration = iteration + 1;
end
clear iteration error;

% Calculating reservation wage using the Bellman equation
w_bar = (1 - beta)*(beta*mean(v));

% Creating policy function
syms s(wage);
s(wage) = piecewise(wage >= w_bar, 1, wage < w_bar, 0);

% Plotting policy function
fplot(s(wage), [5, 65], 'LineWidth', 2);
grid on
xlabel('Wage');
ylabel('Policy');
hold on
title('Policy function, [w_{min}, w_{max}] = [5, 65]');

saveas(gcf, 'path\to\graphics\1f_plot.png');
close(gcf);
%==========================================================================

%==========================================================================
%% Part 1g: Assume that the wage offers are distributed uniformly in
% [w_min, w_max] = [15, 50], b = 20, and beta = 0.995. Compute the
% reservation wage and plot the policy function.

% Setting up data exclusive to 1f.
w_min = 15;
w_max = 50;

% Setting sample period
% To ensure that the length of density vector won't be long to the point
% that the sum of the product between it and the value function blows up,
% we set the amount of periods to be equal to w_max - w_min.
N = w_max - w_min;

% Creating vector of wages from distribution mentioned above
w = w_min + (w_max - w_min).*rand(N, 1);

% Creating vector of densities associated with wage vector
p = unifpdf(w, w_min, w_max);

b = 20;
beta = 0.995;

% Creating loop for value function iteration to find Bellman equation
% Choosing initial value of value function to be value of accepting any
% wage.
v = w./(1 - beta);

% Creating variable that stores max(abs(v - v_next)), the error metric. We
% are focusing on the max of the error because if the max value satisfies
% the threshold, every other value of the vector will.
error = 1;

% Creating variable that stores iteration number
iteration = 0;

% Iterating to find fixed point of value function. The threshold that stops
% the loop will be 0.001.
while error >= 0.001
  % Displaying iteration number
  disp(iteration);
  
  % Calculating value function using initial or previous value function
  % WHY DOES USING sum(v.*p) CAUSE THE LOOP TO EXPLODE???
  v_next = max(w./(1 - beta), b + beta*sum(v.*p));
  
  % Storing max(abs(v - v_next)). Choosing the max so the abs vector has
  % every value to be below error threshold.
  error = max(abs(v - v_next));
  disp(error);
  
  % Storing previous value function
  v = v_next;
  
  iteration = iteration + 1;
end
clear iteration error;

% Calculating reservation wage using the Bellman equation
w_bar = (1 - beta)*(beta*mean(v));

% Creating policy function
syms s(wage);
s(wage) = piecewise(wage >= w_bar, 1, wage < w_bar, 0);

% Plotting policy function
fplot(s(wage), [15, 50], 'LineWidth', 2);
grid on
xlabel('Wage');
ylabel('Policy');
hold on
title('Policy function, [w_{min}, w_{max}] = [15, 50]');

saveas(gcf, 'path\to\graphics\1g_plot.png');
close(gcf);
%==========================================================================