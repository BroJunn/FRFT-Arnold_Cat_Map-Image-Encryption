function decrypted_image = arnold_cat_map_frft_only_decrypt(encrypted_img, order, p, q, iter)

    inter_decrypted_image = arnold_cat_map_inverse(encrypted_img, p, q, iter); 
    decrypted_image = abs(frft2d(inter_decrypted_image, -order)); 
    decrypted_image = uint8(decrypted_image); 
end