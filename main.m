clear;
clc;

% add paths
addpath('utils_frft', 'utils_eval', 'utils_vis', 'utils_log', 'utils_shuffle', ...
    'utils', 'algorithms', 'imgs');

% -------------------------------------------------------------------------
config = struct();
% paths
config.main_folder = './imgs';
config.log_folder = 'ex1';

% visualizaion
save_visualization = true;  % if save vis
config.save_vis_interval = 1;
mode_vis_encrypted = 'linear-norm';   % mod, linear-norm, log-scale

% params for algorithms
config.algo = 'arnold_cat_map_frft';   % single_frft, arnold_cat_map_frft
config.order = 0.65;   % 

config.p = 5;
config.q = 3;
config.iter = 1;

% eval
config.purtub_factor = 0.05;

% -------------------------------------------------------------------------

img_file_list = get_all_image_paths(config.main_folder);

h = waitbar(0, 'Progress'); % Create the waitbar
evaluator = Evaluator(config);
logger = Logger(config);
for i = 1:length(img_file_list)
    img_file = img_file_list(i);
    original_image = img_preprocess(img_file{1}); % uint8->double

    [encrypted_img, decrypted_image, evaluator]  = evaluator.run_algo(original_image);
    vis_encrypted_img = gen_vis_encrypted_img(encrypted_img, mode_vis_encrypted);

    evaluator = evaluator.eval_entry(decrypted_image, original_image, encrypted_img);
    evaluator = evaluator.eval_key_sen(original_image, config.purtub_factor);

    if save_visualization
        logger = logger.save_img(original_image,vis_encrypted_img,decrypted_image);
    end

    waitbar(i/length(img_file_list), h, sprintf('Processing %d of %d', i, length(img_file_list)));
end
close(h);

[average_psnr, average_ssim, average_corr_coeff, average_entropy, ...
    average_time, average_hamming_distance, average_avalanche_effect] = evaluator.get_average();
logger.write_to_txt(average_time, average_psnr, average_ssim, ...
    average_corr_coeff, average_entropy, average_hamming_distance, average_avalanche_effect)
