% Simulation parameters
err = 0.9; % Error probability = 0.(length of my first name = Santrupti)
range = 100:100:20000; % Range of total bits transmitted from 100-20000 in steps of 100

% Preallocate arrays for storing results
num_errors = zeros(length(range), 1);
error_ratios = zeros(length(range), 1);

% Simulation
for i = 1:length(range)
    total_bits = range(i);
    
    % Generate a sequence of binary digits (0s and 1s) with equal probability
    transmitted_sequence = randi([0, 1], total_bits, 1);
    
    % Simulate the binary symmetric channel with error probability 0.9
    received_sequence = transmitted_sequence;
    flip_probabilities = rand(total_bits, 1);
    received_sequence(flip_probabilities < err) = ~transmitted_sequence(flip_probabilities < err);
    
    % Calculate the number of errors (flipped bits)
    num_errors(i) = sum(transmitted_sequence ~= received_sequence);
    
    % Calculate the error ratio
    error_ratios(i) = num_errors(i) / total_bits;
end

% Plotting the results
figure;

% Plot the number of errors vs. the total number of bits transmitted
subplot(2, 1, 1);
plot(range, num_errors, 'b-');
xlabel('Total Number of Bits Transmitted');
ylabel('Number of Errors');
title('Number of Errors vs. Total Number of Bits Transmitted');

% Plot the error ratio vs. the total number of bits transmitted
subplot(2, 1, 2);
plot(range, error_ratios, 'r-');
xlabel('Total Number of Bits Transmitted');
ylabel('Error Ratio');
title('Error Ratio vs. Total Number of Bits Transmitted');

% Display the plots
grid on;
