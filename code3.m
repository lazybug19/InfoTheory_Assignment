% NAME: SANTRUPTI, First 5 letters : 'S', 'A', 'N', 'T', 'R'
chars = ["S","A","N","T","R"];
probabilities = [0.3 0.2 0.1 0.25 0.15];

encoded_tag = arithmetic_encode(chars, probabilities);
fprintf('Encoded tag is %f\n', encoded_tag);

function encoded_tag = arithmetic_encode(chars, probabilities)
[sorted_chars, indices] = unique(chars);
sorted_probabilities = probabilities(indices);
lower_bound = 0;
upper_bound = 1;
range = upper_bound - lower_bound;
lower_limits = zeros(length(chars));
upper_limits = zeros(length(chars));

for char_index = 1:length(chars)
    for prob_index = 1:length(sorted_chars)
        if prob_index == 1
            lower_limits(prob_index) = lower_bound;
            upper_limits(prob_index) = lower_bound + range * sorted_probabilities(prob_index);
        else
            lower_limits(prob_index) = lower_bound + range * sum(sorted_probabilities(1:prob_index-1));
            upper_limits(prob_index) = lower_bound + range * sum(sorted_probabilities(1:prob_index));
        end
    end
    
    char_position = find(sorted_chars == chars(char_index));
    lower_bound = lower_limits(char_position);
    upper_bound = upper_limits(char_position);
    range = upper_bound - lower_bound;
end
encoded_tag = (lower_bound + upper_bound) / 2;
end