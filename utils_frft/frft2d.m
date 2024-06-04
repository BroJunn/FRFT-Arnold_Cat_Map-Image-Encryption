function output = frft2d(image, a)
    % 2D FrFT
    [M, N] = size(image);
    output = zeros(M, N);
    % Apply FrFT along rows
    for i = 1:M
        output(i, :) = frft1(image(i, :), a);
    end
    % Apply FrFT along columns
    for j = 1:N
        output(:, j) = frft1(output(:, j), a);
    end
end