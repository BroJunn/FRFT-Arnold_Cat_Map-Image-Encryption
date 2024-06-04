function [encrypted_img, decrypted_image] = single_frft(original_image, order)
    
    encrypted_img = frft2d(original_image, order);
    
    inter_decrypted_image = double(encrypted_img);
    inter_decrypted_image = abs(frft2d(inter_decrypted_image, -order));
    decrypted_image = uint8(inter_decrypted_image);
end

