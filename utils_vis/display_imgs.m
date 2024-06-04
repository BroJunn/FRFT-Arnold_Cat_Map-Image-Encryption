function display_imgs(original_image,vis_encrypted_img,decrypted_image)

    % Display the images
    figure;
    subplot(1, 3, 1), imshow(uint8(original_image)), title('Original Image');
    subplot(1, 3, 2), imshow(vis_encrypted_img), title('Encrypted Image');
    subplot(1, 3, 3), imshow(decrypted_image), title('Decrypted Image');
    
end

