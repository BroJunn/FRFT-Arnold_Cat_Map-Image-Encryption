# FRFT-Arnold's_Cat_Map Image Encryption

This project focuses on the encryption and decryption of images using fractional Fourier transform (FRFT) combined with Arnold's cat map algorithms. The primary goal is to enhance the security of image data by transforming it into an unintelligible form and then evaluating the effectiveness of these transformations through various metrics.



## Table of Contents

- [Visualization of Results](#visualization-of-results)
- [Theory](#theory)
- [Usage](#usage)
- [License](#license)

## Visualization of Results
<p align="center">
    <img src="logs\ex1\saved_visualization\1.png" width="350" hspace="20"/>
    <img src="logs\ex1\saved_hist\1.png" width="270" hspace="20"/>

</p>

<p align="center">
    <em>    Visualization of Results<br>
    (a) Visualization of Images 
    (b) Histogram Analysis</em>
</p>


## Theory

### Fractional Fourier Transform (FRFT)

The Fractional Fourier Transform is a generalization of the classical Fourier Transform. It allows for the transformation of a signal to intermediate domains between time and frequency. The transform order, typically denoted by a fractional value, determines the extent of this transformation. In the context of image encryption, FRFT can obscure the spatial features of an image, making it more secure against unauthorized access.

### Arnold's Cat Map

Arnold's Cat Map is a chaotic map used for image scrambling. It repeatedly permutes the pixel positions of an image, leading to a seemingly random arrangement. This method, when combined with FRFT, increases the security of the encrypted image by adding a layer of spatial confusion.

### Combine FRFT and Arnold's Cat Map

The combination of FRFT and Arnold's Cat Map involves the following steps:
1. **Encryption**:
    - Apply FRFT to the original image to obtain a complex matrix.
    - Apply Arnold's Cat Map to shuffle the pixels of the transformed image.
2. **Decryption**:
    - Reverse the Arnold's Cat Map to recover the pixel positions.
    - Apply the inverse FRFT to the recovered image to get the decrypted image.

## Usage

### Script 1: Image Processing and Evaluation

This script processes all images in the specified folder, encrypts them using the chosen algorithm, and evaluates the results.

1. Configure the settings in the `main.m` script:
    - **config.main_folder**: Path to the folder containing images to be processed.
    - **config.log_folder**: Path to the folder where logs and results will be saved.
    - **save_visualization**: Boolean flag to save visualizations.
    - **config.save_vis_interval**: Interval at which visualizations are saved.
    - **mode_vis_encrypted**: Visualization mode for encrypted images ('mod', 'linear-norm', 'log-scale').
    - **config.algo**: Algorithm used for encryption ('single_frft', 'arnold_cat_map_frft').
    - **config.order**: Order parameter for the FRFT.
    - **config.p, config.q, config.iter**: Parameters for the Arnold's Cat Map.
    - **config.purtub_factor**: Perturbation factor for key sensitivity evaluation.

2. Run the script:
    ```matlab
    main
    ```

### Script 2: Brute Force Attack Simulation

This script simulates a brute force attack on the encrypted images by systematically trying different parameters and evaluating the results.

1. Configure the settings in the `main_simu_attack.m` script:
    - **config.main_folder**: Path to the folder containing images to be processed.
    - **config.log_folder**: Path to the folder where logs and results will be saved.
    - **save_visualization**: Boolean flag to save visualizations.
    - **config.save_vis_interval**: Interval at which visualizations are saved.
    - **mode_vis_encrypted**: Visualization mode for encrypted images ('mod', 'linear-norm', 'log-scale').
    - **config.algo**: Algorithm used for encryption ('single_frft', 'arnold_cat_map_frft').
    - **config.order_low, config.order_high**: Range for the FRFT order parameter to be tested.
    - **config.p_range_high, config.q_range_high, config.iter_range_high**: Range for the Arnold's Cat Map parameters to be tested.
    - **config.check_interval_order, config.check_interval_p, config.check_interval_q, config.check_interval_iter**: Intervals for brute force parameter testing.

2. Run the script:
    ```matlab
    main_simu_attack.m
    ```

In both scripts, the results are saved and various metrics such as PSNR, SSIM, entropy, correlation coefficient, Hamming distance, and avalanche effect are evaluated to assess the quality and security of the encryption and decryption process. Visualizations of the encrypted and decrypted images are generated and saved at specified intervals.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.