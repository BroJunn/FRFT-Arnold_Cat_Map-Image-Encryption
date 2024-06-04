clear;
clc;

% add paths
addpath('utils_frft', 'utils_eval', 'utils_vis', 'utils_log', 'utils_shuffle', ...
    'utils', 'algorithms', 'imgs');

% -------------------------------------------------------------------------
config = struct();
% paths
config.main_folder = './imgs';
config.log_folder = 'ex4';

% visualizaion
save_visualization = true;  % false
config.save_vis_interval = 1;
mode_vis_encrypted = 'linear-norm';   % mod, linear-norm, log-scale

% params for algorithms
config.algo = 'arnold_cat_map_frft';   % single_frft, arnold_cat_map_frft
config.order_low = 0;
config.order_high = 1;
config.order = config.order_low + (config.order_high - config.order_low) * rand;

config.p_range_high = 10;
config.q_range_high = 10;
config.iter_range_high = 2;
config.p = randi(config.p_range_high);
config.q = randi(config.q_range_high);
config.iter = randi(config.iter_range_high);

% eval
config.check_interval_order = 0.1;
config.check_interval_p = 3;
config.check_interval_q = 3;
config.check_interval_iter = 1;

% -------------------------------------------------------------------------
img_file_list = get_all_image_paths(config.main_folder);

h = waitbar(0, 'Progress');
evaluator = EvaluatorAttack(config);
logger = Logger(config);

img_file = img_file_list(1);
original_image = img_preprocess(img_file{1});

[encrypted_img, decrypted_image, evaluator]  = evaluator.run_algo(original_image);

for order_ = config.order_low:config.check_interval_order:config.order_high
    for p_ = 0: config.check_interval_p:config.p_range_high
        for q_ = 0:config.check_interval_q:config.q_range_high
            for iter_ = 1:config.check_interval_iter:config.iter_range_high
                [decrypted_image, evaluator] = evaluator.run_algo_only_attack(encrypted_img, original_image, order_, p_, q_, iter_);
                waitbar(evaluator.count/evaluator.size_attack_num, h, sprintf('Processing %d of %d', evaluator.count, evaluator.size_attack_num));
            end
        end
    end
end

close(h);

vis_encrypted_img = gen_vis_encrypted_img(encrypted_img, mode_vis_encrypted);

if save_visualization
    logger = logger.save_img(original_image,vis_encrypted_img,decrypted_image);
end
best_attacked_image = evaluator.get_best_attacked_image(encrypted_img);
logger.save_attack_img(original_image, vis_encrypted_img, best_attacked_image);
evaluator.get_average();