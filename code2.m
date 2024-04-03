% Using image processing functions to read the image file
image = imread('id.png'); 

% We convert the image to grayscale (if it's not already grayscale)
if size(image, 3) == 3
    image_gray = rgb2gray(image);
else
    image_gray = image;
end

% We calculate the histogram using the pixel values of the image
histogram = imhist(image_gray);

% Optionally, visualize the histogram
figure;
bar(histogram);
xlabel('Pixel Value');
ylabel('Frequency');
title('Histogram of Pixel Values');

% We calculate the probability distribution
total_pixels = numel(image_gray);
prob_distri = histogram / total_pixels;

% Finally, we calculate the entropy
entropy_value = 0;
for i = 1:length(prob_distri)
    if prob_distri(i) > 0
        entropy_value = entropy_value - prob_distri(i) * log2(prob_distri(i));
    end
end

disp(['Entropy value: ', num2str(entropy_value)]);
