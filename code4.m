% ID - 0321
p_trans = [0 0 0 1; 0 1 0 0; 0 0 0 1];
r = size(p_trans, 1);
I_1 = eye(r);
H = [p_trans I_1]; % Parity check matrix
n = size(H, 2);

p = p_trans';
k = n - r;
I_2 = eye(k);
G = [I_2 p];


% Generate(U) a vector of decimal numbers from 0 to 2^k - 1
dec_numbers = 0:(2^k - 1);
% Convert each decimal number to a binary string
bin_strings = dec2bin(dec_numbers);
% Convert each binary string to a binary vector
U = bin_strings - '0';
increment = 1;


% Calculate the codeword for each binary vector and Minimum distance
codewords = mod(U * G, 2);
min_distance = inf;
% Calculate the number of codewords
num_codewords = size(codewords, 1);
% Compare each pair of codewords
for i = 1:increment:num_codewords
    for j = i+1:increment:num_codewords
        % Calculate the Hamming distance between codewords(i, :) and codewords(j, :)
        distance = sum(codewords(i, :) ~= codewords(j, :));
        
        % If this distance is smaller than min_distance and not zero, update min_distance
        if distance < min_distance && distance > 0
            min_distance = distance;
            codeword_min_d_1 = codewords(i, :);
            codeword_min_d_2 = codewords(j, :);
        end
    end
end


% Syndrome vector
% Syndrome vector calculation: S = R * H'
% Where R is received codeword and H' is the transpose of the parity check matrix
syndrome_d_1 = mod(codeword_min_d_1 * H', 2);
syndrome_d_2 = mod(codeword_min_d_2 * H', 2);


% Generate transmitted code from last 4 LSB bits from Information bits
info_bits = [0 0 0 1];
transmitted_code = mod(info_bits * G, 2);


% Syndrome for the transmitted codeword
syndrome_transmitted_code = mod(transmitted_code * H', 2);


% Flip a bit and find syndrome
received_code = transmitted_code;
% Flip 3rd bit from LSB or 5th bit from MSB (ID = 321)
s = size(transmitted_code, 2);
received_code(s-3+1) = ~transmitted_code(s-3+1);
syndrome_received_code = mod(received_code * H', 2);

% E is all possible single bit error codewords all powers of 2 till 2^7
E = zeros(7, 7);
for i = 1:7
    E(i, i) = 1;
end

for i = 1:increment:size(E, 1)
    error = E(i, :);
    %syndrome vector calculation
    syndrome_error = mod(error * H', 2);
    if syndrome_received_code == syndrome_error
        error_position = i;
        error_vector = E(i, :);
    end
end

disp('Codeword with minimum distance:');
disp(codeword_min_d_1);
disp('Next codeword with minimum distance:');
disp(codeword_min_d_2);
disp(['Minimum distance:', num2str(min_distance)]);
disp('Syndrome for codeword with minimum distance:');
disp(syndrome_d_1);
disp('Syndrome for next codeword with minimum distance:');
disp(syndrome_d_2);
disp('Transmitted code:');
disp(transmitted_code);
disp('Syndrome for transmitted code:');
disp(syndrome_transmitted_code);
disp('Flipped transmitted(Received) code:');
disp(received_code);
disp('Syndrome for flipped transmitted(Received) code:');
disp(syndrome_received_code);
disp('Error position:');
disp(error_position);
disp('Error:');
disp(error_vector);
