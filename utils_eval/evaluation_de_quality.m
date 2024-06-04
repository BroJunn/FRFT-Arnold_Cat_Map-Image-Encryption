function [psnr_value, ssim_value] = evaluation_de_quality(decrypted_image, original_image)
%   decrypted_image: uint8
%   original_image: uint8
    decrypted_image = double(decrypted_image);
    psnr_value = psnr(decrypted_image, original_image);
    ssim_value = ssim(decrypted_image, original_image);
    % Display the PSNR and SSIM values
    % fprintf('PSNR: %.2f\n', psnr_value);
    % fprintf('SSIM: %.2f\n', ssim_value);
end

