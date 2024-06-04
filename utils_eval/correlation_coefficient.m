function corr_coeff = correlation_coefficient(img)

    if ~isreal(img)
        img = abs(img); % Option: abs, real, imag, angle
    end
    
    % Compute the correlation in horizontal, vertical, and diagonal directions
    horizontal_corr = corr2(img(:, 1:end-1), img(:, 2:end));
    vertical_corr = corr2(img(1:end-1, :), img(2:end, :));
    diagonal_corr = corr2(img(1:end-1, 1:end-1), img(2:end, 2:end));
    
    % Average the correlation coefficients
    corr_coeff = mean([horizontal_corr, vertical_corr, diagonal_corr]);
end
