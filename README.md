# Image Restoration Project

This project demonstrates the restoration of degraded images using various image processing techniques such as color adjustment, smoothing, sharpening, and inpainting. The aim is to improve the quality of degraded images and restore lost details.

## Features

- **Grayscale Conversion**: Converts color images to grayscale for simpler processing.
- **Color Adjustment**: Removes unwanted color tints (e.g., yellowish tint).
- **Gaussian Filtering**: Reduces high-frequency noise and smoothens the image.
- **Sharpening**: Enhances the edges and details of the image.
- **Edge Smoothing**: Softens edges while preserving important details.
- **Inpainting**: Fills corrupted or missing pixels using inpainting techniques.

## Steps Involved

### Restoring Image 1
- **Read and Convert**: The degraded image is read and converted to grayscale.
- **Color Adjustment**: The yellowish tint is removed from the image.
- **Smoothing**: Gaussian filter is applied to reduce noise.
- **Sharpening**: Edges are enhanced using a sharpening filter.
- **Edge Smoothing**: The edges are smoothed while preserving central details for a more natural look.

### Restoring Image 2
- **Read and Convert**: The image is loaded and converted to grayscale.
- **Color Adjustment**: The yellowish tint is removed from the grayscale image.
- **Inpainting**: Missing or corrupted pixels are restored using the inpainting function.

### Restoring Image 3
- **Read and Convert**: The degraded image is loaded and converted to grayscale.
- **Denoising**: Gaussian filter is applied to remove noise and improve image clarity.

## Functions

- **readDegradedImage**: Loads the image from the specified path.
- **convertToGrayscale**: Converts the image to grayscale for easier processing.
- **adjustColor**: Adjusts the image's color to remove tints.
- **applyGaussianFilter**: Applies Gaussian filtering to reduce noise.
- **applySharpening**: Sharpens the image to restore edges.
- **applyEdgeSmoothing**: Smooths the edges while keeping central details sharp.
- **inpainting**: Fills missing or corrupted pixels in the image.
- **denoiseImage**: Reduces noise by applying Gaussian filtering.

## Requirements

- MATLAB (R2020b or later recommended)
- Image Processing Toolbox

## How to Run

1. Clone the repository or download the code files.
2. Open the script in MATLAB.
3. Ensure the required images (`img1.png`, `img2.png`, `img3.png`) are available in the working directory.
4. Run the script to restore the images.

## Results

- The restored images will be displayed at each stage, showcasing the improvements made during the restoration process.
- The final restored images will be shown after all processing steps have been applied.

