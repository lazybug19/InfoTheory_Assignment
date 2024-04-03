% Use fopen to open the text file and read its contents
fileID = fopen('textfile.txt', 'r'); 
textData = fscanf(fileID, '%c'); %to only read characters
fclose(fileID); 

% Next we store the contents of the text file in character array "A"
A = char(textData);

% We convert text to equivalent ASCII values using double
ascii_values = double(A);

% We calculate the histogram of the ASCII values
histogram = hist(ascii_values, 0:255);

% (Optional) Plotting the histogram
figure;
bar(0:255, histogram);
xlabel('ASCII Value');
ylabel('Frequency');
title('Histogram of ASCII Values');

% Next we calculate the probability distribution
prob_distri = histogram / length(A);

% Finally we calculate the entropy
entropy_value = 0;
for i = 1:length(prob_distri)
    if prob_distri(i) > 0
        entropy_value = entropy_value - prob_distri(i) * log2(prob_distri(i));
    end
end

disp(['Entropy value: ', num2str(entropy_value)]);
