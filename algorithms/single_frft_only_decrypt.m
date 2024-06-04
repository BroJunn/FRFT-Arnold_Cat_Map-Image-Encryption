function [decrypted_image] = single_frft_only_decrypt(encrypted_img, order)

    inter_decrypted_image = double(encrypted_img);
    inter_decrypted_image = abs(frft2d(inter_decrypted_image, -order));
    decrypted_image = uint8(inter_decrypted_image);
end

