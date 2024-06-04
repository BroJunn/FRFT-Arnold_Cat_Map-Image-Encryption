function image_paths = get_all_image_paths(folder_path)
    img_types = {'*.jpg', '*.jpeg', '*.png', '*.bmp', '*.tiff', '*.tif', '*.gif'};

    image_paths = {};
    
    for i = 1:length(img_types)
        files = dir(fullfile(folder_path, img_types{i}));
        
        for j = 1:length(files)
            image_paths{end+1} = fullfile(folder_path, files(j).name);
        end
    end
end