function original_image = img_preprocess(image_path)

    original_image = imread(image_path);
    if ndims(original_image) == 3
        original_image = rgb2gray(original_image);
    end
    original_image = double(original_image);
end

