function save_img_(original_image,vis_encrypted_img,decrypted_image, save_path)

fig = figure('Visible', 'off');

subplot(1, 3, 1), imshow(uint8(original_image)), title('Original Image');
subplot(1, 3, 2), imshow(vis_encrypted_img), title('Encrypted Image');
subplot(1, 3, 3), imshow(decrypted_image), title('Decrypted Image');

exportgraphics(fig, save_path, 'Resolution', 300);
close(fig);
end

