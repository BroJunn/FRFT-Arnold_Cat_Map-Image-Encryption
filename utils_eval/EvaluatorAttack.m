classdef EvaluatorAttack

    properties

        ssim_data;
        order_data;
        p_data;
        q_data;
        iter_data;
        size_data;

        count = 0;
        configs = struct();
        total_time = 0.0;

    end
    
    methods
        function obj = EvaluatorAttack(config)
            obj.configs = config;
            obj.size_data = obj.size_attack_num();

            obj.ssim_data = zeros(1, obj.size_data);
            obj.order_data = zeros(1, obj.size_data);
            obj.p_data = zeros(1, obj.size_data);
            obj.q_data = zeros(1, obj.size_data);
            obj.iter_data = zeros(1, obj.size_data);
        end

        function size_data = size_attack_num(obj)
            num_orders = ceil((obj.configs.order_high - obj.configs.order_low) / obj.configs.check_interval_order + 1);
            num_p = ceil((obj.configs.p_range_high - 0) / obj.configs.check_interval_p + 1);
            num_q = ceil((obj.configs.q_range_high - 0) / obj.configs.check_interval_q + 1);
            num_iter = ceil((obj.configs.iter_range_high - 0) / obj.configs.check_interval_iter);
            size_data = num_orders*num_p*num_q*num_iter;
        end
        
        function obj = eval_entry_for_attack(obj, decrypted_image, original_image)
            ssim_value = evaluation_de_quality(decrypted_image, original_image);
            obj.ssim_data(obj.count) = ssim_value;
            obj.count = obj.count + 1;
        end


        function [encrypted_img, decrypted_image, obj] = run_algo(obj, original_image)
            obj.configs.algo = validatestring(obj.configs.algo, {'single_frft', 'arnold_cat_map_frft'});

            if strcmp(obj.configs.algo, 'single_frft')
                [encrypted_img, decrypted_image] = single_frft(original_image, obj.configs.order);
            end
            if strcmp(obj.configs.algo, 'arnold_cat_map_frft')
                [encrypted_img, decrypted_image] = arnold_cat_map_frft(original_image, ...
                    obj.configs.order, obj.configs.p, obj.configs.q, obj.configs.iter);
            end

        end

        function [decrypted_image, obj] = run_algo_only_attack(obj, encrypted_img, original_image, order, p, q, iter)
            obj.configs.algo = validatestring(obj.configs.algo, {'single_frft', 'arnold_cat_map_frft'});
            tic;
            if strcmp(obj.configs.algo, 'single_frft')
                [decrypted_image] = single_frft_only_decrypt(encrypted_img, order);
            end
            if strcmp(obj.configs.algo, 'arnold_cat_map_frft')
                [decrypted_image] = arnold_cat_map_frft_only_decrypt(encrypted_img, ...
                    order, p, q, iter);
            end
            obj.total_time = obj.total_time + toc;  % 结束计时

            decrypted_image_ = double(decrypted_image);
            ssim_value = ssim(decrypted_image_, original_image);
            obj.count = obj.count + 1;
            obj.ssim_data(obj.count) = ssim_value;
            obj.order_data(obj.count) = order;
            obj.p_data(obj.count) = p;
            obj.q_data(obj.count) = q;
            obj.iter_data(obj.count) = iter;
            
        end

        function [average_time] = get_average(obj)
            
            average_time = obj.total_time / obj.count;
            fprintf('Average Time for each Brute-force Attack is %.2f', average_time)
        end

        function best_attacked_image = get_best_attacked_image(obj, encrypted_img)
            [min_value, min_index] = min(obj.ssim_data);
            best_order = obj.order_data(min_index);
            best_p = obj.p_data(min_index);
            best_q = obj.q_data(min_index);
            best_iter = obj.iter_data(min_index);
            
            if strcmp(obj.configs.algo, 'single_frft')
                [best_attacked_image] = single_frft_only_decrypt(encrypted_img, best_order);
            end
            if strcmp(obj.configs.algo, 'arnold_cat_map_frft')
                [best_attacked_image] = arnold_cat_map_frft_only_decrypt(encrypted_img, ...
                    best_order, best_p, best_q, best_iter);
            end

        end

    end
end

