function psnr_value = psnr(original_image, decrypted_image)
    mse_value = mse(original_image, decrypted_image);
    max_pixel_value = 255.0;
    psnr_value = 10 * log10((max_pixel_value^2) / mse_value);
end