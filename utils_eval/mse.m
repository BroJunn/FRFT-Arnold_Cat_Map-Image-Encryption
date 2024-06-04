function mse_value = mse(original_image, decrypted_image)
    mse_value = mean((double(original_image(:)) - double(decrypted_image(:))).^2);
end