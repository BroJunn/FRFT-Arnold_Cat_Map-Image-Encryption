function img_file_list = get_dataset_img_paths(main_folder)

img_file_list = {};
% Get the list of subfolders
subfolders = dir(main_folder);

% Loop through each subfolder
for i = 1:length(subfolders)
    subfolder_name = subfolders(i).name;
    if ~subfolders(i).isdir || ismember(subfolder_name, {'.', '..'})
        continue; % Skip if not a directory or is current/parent directory
    end
    
    % Full path to the subfolder
    subfolder_path = fullfile(main_folder, subfolder_name);
    
    % Get all .tiff files in the subfolder
    tiff_files = dir(fullfile(subfolder_path, '*.tiff'));
    
    % Read each .tiff image
    for j = 1:length(tiff_files)
        file_name = tiff_files(j).name;
        file_path = fullfile(subfolder_path, file_name);
        img_file_list{end+1} = file_path;
    end
end

end

