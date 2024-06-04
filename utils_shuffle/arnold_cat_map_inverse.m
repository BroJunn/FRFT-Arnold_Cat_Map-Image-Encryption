function unscrambled = arnold_cat_map_inverse(image, p, q, iterations)
    [rows, cols] = size(image);
    unscrambled = image;
    for k = 1:iterations
        new_image = zeros(size(image));
        for x = 1:rows
            for y = 1:cols
                new_x = mod((p*q + 1) * x - p * y -1, rows) + 1;
                new_y = mod(-q * x + y-1, cols) + 1;
                new_image(new_x, new_y) = unscrambled(x, y);
            end
        end
        unscrambled = new_image;
    end
end