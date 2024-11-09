% Restoring Image 1
% Reading the degraded image
degradedImage = readDegradedImage('img1.png');

% Grayscale conversion
grayscaleImage = convertToGrayscale(degradedImage);

% Removing yellowish tint
adjustedImage = adjustColor(grayscaleImage);

% Gaussian filter to reduce high-frequency noise
smoothedImage = applyGaussianFilter(adjustedImage);

% Sharpening filter to restore edges
sharpenedImage = applySharpening(smoothedImage);

%Edge Smoothing
finalImage = applyEdgeSmoothing(sharpenedImage);

% Final Image
figure, imshow(finalImage), title('Restored Image');

% Restoring image 2
% Reading the degraded image
degradedImage2 = readDegradedImage('img2.png');
% Grayscale conversion
grayscaleImage2 = convertToGrayscale(degradedImage2);

% Image normalization
grayscaleImage2 = im2double(grayscaleImage2);

% Removing yellowish tint
adjustedImage2 = adjustColor(grayscaleImage2);

% Restoring the degraded image
restoredimage2=inpainting(adjustedImage2);
figure, imshow(restoredimage2), title('Restored Image');

% Restoring image 3
% Reading the degraded image
degradedImage3 = readDegradedImage('img3.png');

% Grayscale conversion
grayscaleImage3 = convertToGrayscale(degradedImage3);

% Image normalization
grayscaleImage3 = im2double(grayscaleImage3);

% Denoise the image
denoisedImage3 = denoiseImage(grayscaleImage3, 3); % Applying Gaussian filter with sigma = 3
figure, imshow(denoisedImage3), title('Denoised Image');


% Function for reading the Degraded Image
function degradedImage = readDegradedImage(imagePath)
    degradedImage = imread(imagePath); 
    figure, imshow(degradedImage), title('Degraded Image');
end

% Function  for Converting to Grayscale
function grayscaleImage = convertToGrayscale(degradedImage)
    % Converts the input image to grayscale 
    degradedImage = im2double(degradedImage); 
    if size(degradedImage, 3) == 3
        grayscaleImage = rgb2gray(degradedImage); 
    else
        grayscaleImage = degradedImage; % Image is already in grayscale
    end
    figure, imshow(grayscaleImage), title('Degraded Grayscale Image');
end

% Function for Adjusting Color (removing yellowish tint)
function adjustedImage = adjustColor(grayscaleImage)
    adjustedImage = imadjust(grayscaleImage, stretchlim(grayscaleImage), [0.1 1]);
    figure, imshow(adjustedImage), title('Color Adjusted Image');
end

% Function for Applying Gaussian Filter to Smooth Image
function smoothedImage = applyGaussianFilter(adjustedImage)
    % Applies Gaussian filtering to reduce noise in the image
    sigma = 1.5; % Standard deviation for the Gaussian filter
    smoothedImage = imgaussfilt(adjustedImage, sigma);
    figure, imshow(smoothedImage), title('Smoothed Image');
end

% Function for Applying Sharpening Filter to Restore Edges
function sharpenedImage = applySharpening(smoothedImage)
    % Sharpens the smoothed image to restore edges and improve clarity
    sharpenedImage = imsharpen(smoothedImage, 'Radius', 2, 'Amount', 1.5);
    figure, imshow(sharpenedImage), title('Sharpened Image');
end

% This function is for Image 1 only
% Function for Applying Edge Smoothing and Creating Final Image
function finalImage = applyEdgeSmoothing(sharpenedImage)
    [rows, cols] = size(sharpenedImage);

    % Meshgrid to calculate distance from center
    [X, Y] = meshgrid(1:cols, 1:rows);
    centerX = cols / 2;
    centerY = rows / 2;
    maxRadius = sqrt(centerX^2 + centerY^2); % Maximum distance from the center
    distanceFromCenter = sqrt((X - centerX).^2 + (Y - centerY).^2); % Euclidean distance from center

    % Threshold radius for applying the mask
    thresholdRadius = 0.6 * maxRadius; 
    mask = ones(rows, cols); % Initialize mask with ones (inside center)
    
    % Applying smoothing mask 
    mask(distanceFromCenter > thresholdRadius) = 1 - 1.5 * (distanceFromCenter(distanceFromCenter > thresholdRadius) - thresholdRadius) / (maxRadius - thresholdRadius);
    mask(mask < 0) = 0;  % No negative mask values ensured

    % Applying the mask to the sharpened image 
    smoothedEdgesImage = sharpenedImage .* mask + 1.2 * (1 - mask); 
    smoothedEdgesImage = min(smoothedEdgesImage, 1); % Ensuring pixel values are within the range [0, 1]
    
    % Final image with smoother edges
    finalImage = smoothedEdgesImage;
end

% Function for Denoising the Image
function denoisedImage = denoiseImage(image, sigma)
    denoisedImage = imgaussfilt(image, sigma);
end

% Function for flling corrupted pixels
function outputImage = inpainting(inputImage)
    % Mask for missing or corrupted pixels 
    mask = inputImage == 0;  % Assuming degraded pixels are 0 
    % Converting the mask to a logical array
    mask = logical(mask);  
    outputImage = inpaintExemplar(inputImage, mask);  
end

