
function [avalanche_effect, hamming_distance] = eval_key_sensitivity(ciphertext1, ciphertext2)

    % Ensure the inputs are of equal size
    assert(numel(ciphertext1) == numel(ciphertext2), ...
           'The two ciphertexts must have the same size.');

    ciphertext1 = abs(ciphertext1);
    ciphertext2 = abs(ciphertext2);

    % Convert the ciphertexts to binary
    binary_str1 = dec2bin(typecast(ciphertext1(:), 'uint8'), 8);
    binary_str2 = dec2bin(typecast(ciphertext2(:), 'uint8'), 8);
    
    % Calculate Hamming Distance
    hamming_distance = sum(binary_str1 ~= binary_str2, 'all');
    
    % Calculate Avalanche Effect
    num_bits = numel(ciphertext1) * 8;
    avalanche_effect = hamming_distance / num_bits;
end


