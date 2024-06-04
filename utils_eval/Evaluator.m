classdef Evaluator

    properties
        ssim = 0.0;
        psnr = 0.0;
        entropy = 0.0;
        corr_coeff = 0.0;
        count = 0;
        configs = struct();
        total_time = 0.0;
        avalanche_effect = 0.0;
        hamming_distance = 0.0;
    end
    
    methods
        function obj = Evaluator(config)
            obj.configs = config;
        end
        
        function obj = eval_entry(obj, decrypted_image, original_image, encrypted_img)
            [psnr_value, ssim_value] = evaluation_de_quality(decrypted_image, original_image);
            obj.psnr = obj.psnr + psnr_value;
            obj.ssim = obj.ssim + ssim_value;

            [entropy_value, corr_coeff_value] = eval_en_safety(encrypted_img);
            obj.entropy = obj.entropy + entropy_value;
            obj.corr_coeff = obj.corr_coeff + corr_coeff_value;

            obj.count = obj.count + 1;
        end


        function [average_psnr, average_ssim, average_corr_coeff, average_entropy, ...
                average_time, average_hamming_distance, average_avalanche_effect] = get_average(obj)
            average_psnr = obj.psnr / obj.count;
            average_ssim = obj.ssim / obj.count;
            average_corr_coeff = obj.corr_coeff / obj.count;
            average_entropy = obj.entropy / obj.count;
            average_time = obj.total_time / obj.count;
            average_hamming_distance = obj.hamming_distance / obj.count;
            average_avalanche_effect = obj.avalanche_effect / obj.count;
        end

        function obj = eval_key_sen(obj, original_image, purtub_factor)
            obj.configs.algo = validatestring(obj.configs.algo, {'single_frft', 'arnold_cat_map_frft'});
            
            if strcmp(obj.configs.algo, 'single_frft')
                [encrypted_img1, ~] = single_frft(original_image, obj.configs.order);
                [encrypted_img2, ~] = single_frft(original_image, obj.configs.order + purtub_factor);
            end
            if strcmp(obj.configs.algo, 'arnold_cat_map_frft')
                [encrypted_img1, ~] = arnold_cat_map_frft(original_image, ...
                    obj.configs.order, obj.configs.p, obj.configs.q, obj.configs.iter);
                [encrypted_img2, ~] = arnold_cat_map_frft(original_image, ...
                    obj.configs.order + purtub_factor, obj.configs.p, obj.configs.q, obj.configs.iter);
            end

            [ava, ham] = eval_key_sensitivity(encrypted_img1, encrypted_img2);
            obj.avalanche_effect = obj.avalanche_effect + ava;
            obj.hamming_distance = obj.hamming_distance + ham;
        end

        function [encrypted_img, decrypted_image, obj] = run_algo(obj, original_image)
            obj.configs.algo = validatestring(obj.configs.algo, {'single_frft', 'arnold_cat_map_frft'});
            tic;
            if strcmp(obj.configs.algo, 'single_frft')
                [encrypted_img, decrypted_image] = single_frft(original_image, obj.configs.order);
            end
            if strcmp(obj.configs.algo, 'arnold_cat_map_frft')
                [encrypted_img, decrypted_image] = arnold_cat_map_frft(original_image, ...
                    obj.configs.order, obj.configs.p, obj.configs.q, obj.configs.iter);
            end
            obj.total_time = obj.total_time + toc; 
        end
    end
end

