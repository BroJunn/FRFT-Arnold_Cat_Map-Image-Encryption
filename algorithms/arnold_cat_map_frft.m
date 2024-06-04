function [encrypted_img, decrypted_image] = arnold_cat_map_frft(original_image, order, p, q, iter)
    % encryption
    encrypted_img_inter = frft2d(original_image, order);  % frft -> complex matrix
    encrypted_img = arnold_cat_map(encrypted_img_inter, p, q, iter);  % arnold cat map -> shuffle pixels
    % decryption
    inter_decrypted_image = arnold_cat_map_inverse(encrypted_img, p, q, iter);  % arnold cat map reverse -> recover pixels positions
    decrypted_image = abs(frft2d(inter_decrypted_image, -order));  % reverse frft 
    decrypted_image = uint8(decrypted_image); % 
end


