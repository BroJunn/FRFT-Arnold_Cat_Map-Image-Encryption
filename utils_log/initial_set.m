function log_root_dir = initial_set(log_folder)
    log_root_dir = fullfile('logs', log_folder);
    mkdir(log_root_dir);
end

