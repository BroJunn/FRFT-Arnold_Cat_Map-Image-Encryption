
classdef Logger
    
    properties
        log_root_path;
        save_vis_interval = 1;
        save_img_count = 0;
        configs = struct();
    end
    
    methods
        function obj = Logger(config)
            obj.log_root_path = initial_set(config.log_folder);
            obj.save_vis_interval = config.save_vis_interval;
            obj.configs = config;
        end
        
        function obj = save_img(obj, original_image,vis_encrypted_img,decrypted_image)
            obj.save_img_count = obj.save_img_count + 1;
            if mod(obj.save_img_count, obj.save_vis_interval) ~= 0
                return
            end
            vis_folder1 = fullfile(obj.log_root_path, 'saved_visualization');
            if ~exist(vis_folder1, 'dir')
                mkdir(vis_folder1);
            end
            vis_folder2 = fullfile(obj.log_root_path, 'saved_hist');
            if ~exist(vis_folder2, 'dir')
                mkdir(vis_folder2);
            end
            save_path1 = fullfile(obj.log_root_path, 'saved_visualization', ...
                [num2str(obj.save_img_count), '.png']);
            save_img_(original_image,vis_encrypted_img,decrypted_image, save_path1);
            save_path2 = fullfile(obj.log_root_path, 'saved_hist', ...
                [num2str(obj.save_img_count), '.png']);
            save_hist(original_image, vis_encrypted_img, decrypted_image, save_path2);
        end

        function write_to_txt(obj, average_time, average_psnr, average_ssim, ...
                average_corr_coeff, average_entropy, average_hamming_distance, average_avalanche_effect)
            txt_file = fullfile(obj.log_root_path, 'metrics.txt');
            write_metrics_to_file(txt_file, average_time, average_psnr, average_ssim, ...
                average_corr_coeff, average_entropy, average_avalanche_effect, obj.configs.purtub_factor)
        end

        function obj = save_attack_img(obj, original_image, vis_encrypted_img, best_attacked_image)
            obj.save_img_count = obj.save_img_count + 1;

            vis_folder1 = fullfile(obj.log_root_path, 'saved_visualization');
            if ~exist(vis_folder1, 'dir')
                mkdir(vis_folder1);
            end

            save_path1 = fullfile(obj.log_root_path, 'saved_visualization', ...
                ['attack_contrast', '.png']);
            save_attack_img_(original_image,vis_encrypted_img,best_attacked_image,save_path1);

        end
    end
end

