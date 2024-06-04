function scrambled = arnold_cat_map(image, p, q, iterations)
    [rows, cols] = size(image);
    scrambled = image;
    for k = 1:iterations
        new_image = zeros(size(image));
        for x = 1:rows
            for y = 1:cols
                new_x = mod(x + p * y - 1, rows) + 1;
                new_y = mod(q * x + (p * q + 1) * y -1, cols) + 1;
                new_image(new_x, new_y) = scrambled(x, y);
            end
        end
        scrambled = new_image;
    end
end


