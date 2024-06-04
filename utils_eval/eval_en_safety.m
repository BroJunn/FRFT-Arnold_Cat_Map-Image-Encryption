function [entropy_value, corr_coeff_value] = eval_en_safety(encrypted_img)
%   encrypted_img: complex number
    % For entropy
    entropy_value = entropy(abs(encrypted_img));
    
    % For correlation coefficient
    corr_coeff_value = correlation_coefficient(abs(encrypted_img));
end
