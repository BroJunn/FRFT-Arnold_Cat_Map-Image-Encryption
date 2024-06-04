function save_hist(original_image, vis_encrypted_img, decrypted_image, save_path)

    fig = figure('Visible', 'off');
    
    subplot(1, 3, 1);
    imhist(uint8(original_image));
    title('Histogram of Original Image');

    subplot(1, 3, 2);
    imhist(vis_encrypted_img);
    title('Histogram of Encrypted Image');
    
    subplot(1, 3, 3);
    imhist(decrypted_image);
    title('Histogram of Decrypted Image');
    
    exportgraphics(fig, save_path, 'Resolution', 300);
    close(fig);
end