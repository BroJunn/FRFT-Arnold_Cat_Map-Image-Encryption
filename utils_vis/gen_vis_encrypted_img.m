function encrypted_image = gen_vis_encrypted_img(encrypted_img, mode)
    
    % encrypted_image = uint8(mod(abs(encrypted_img), 256));
    mode = validatestring(mode, {'mod', 'linear-norm', 'log-scale'});
    switch mode
        case 'mod'
            encrypted_image = uint8(mod(abs(encrypted_img), 256));
        case 'linear-norm'
            encrypted_image = uint8(255 * mat2gray(abs(encrypted_img)));
        case 'log-scale'
            encrypted_image = uint8(255 * mat2gray(log(1 + abs(encrypted_img))));
    end
    
end

